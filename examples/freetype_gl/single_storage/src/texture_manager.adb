
with System;

with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;

with GL.Attributes;
with GL.Objects.Textures.Targets;
with GL.Pixels;
with GL.Types.Colors;

with FT;
with FT.API;
with FT.Errors;
with FT.Glyphs;
with FT.Image;
with FT.Interfac;
with FT.Utilities;

with Utilities;

package body Texture_Manager is

   theLibrary     : FT.API.Library_Ptr;
   Face_Ptr       : FT.API.Face_Ptr;
   Character_Data : FT.Interfac.Character_Data_Vector (0 .. 127);
   Vertex_Data    : Vertex_Array;

   procedure Setup_Buffer (Vertex_Buffer : in out V_Buffer;
                           Char          : Character;
                           X, Y, Scale   : GL.Types.Single);
   procedure Setup_Font;
   procedure Setup_Texture (aTexture : in out GL.Objects.Textures.Texture);

   --  ------------------------------------------------------------------------

   procedure Setup_Buffer (Vertex_Buffer : in out V_Buffer;
                           Char          : Character;
                           X, Y, Scale   : GL.Types.Single) is
      use GL.Objects.Buffers;
      use GL.Objects.Textures.Targets;
      use GL.Types;
      X_Pos         : Single := X;
      Y_Pos         : Single := Y ;
      Width         : Single;
      Height        : Single;
      Num_Triangles : Int := 2;
      Stride        : Int := 4;
   begin
     if FT.Interfac.Load_Character (Face_Ptr, Character'Pos (Char),
                                      FT.Interfac.Load_Render) /= 0 then
         Put_Line ("A character failed to load.");
         raise FT.FT_Exception;
     end if;

      --  Ensure that the glyph image is an anti-aliased bitmap
      if FT.Glyphs.Render_Glyph (Face_Ptr, FT.API.Render_Mode_Mono) /= 0 then
         Put_Line ("A character failed to render.");
         raise FT.FT_Exception;
      end if;
      FT.Utilities.Print_Character_Metadata (Face_Ptr, Char);

      Vertex_Buffer.Initialize_Id;
      Array_Buffer.Bind (Vertex_Buffer);
      Width := FT.Glyphs.Bitmap_Width (Face_Ptr) * Scale;
      Height := Single (FT.Glyphs.Bitmap_Rows (Face_Ptr)) * Scale;
      Vertex_Data := (
                      (X_Pos, Y_Pos,                  0.0, 0.0),  --  Lower left
                      (X_Pos + Width, Y_Pos,          1.0, 0.0),  --  Lower right
                      (X_Pos, Y_Pos + Height,         0.0, 1.0),  --  Upper left

                      (X_Pos, Y_Pos + Height,         0.0, 1.0),  --  Upper left
                      (X_Pos + Width, Y_Pos + Height, 1.0, 1.0),  --  Upper Right
                      (X_Pos + Width, Y_Pos,          1.0, 0.0)); --  Lower right

      Utilities.Load_Vertex_Buffer (Array_Buffer, Vertex_Data, Static_Draw);

   exception
      when others =>
         Put_Line ("An exceptiom occurred in Setup_Buffer.");
         raise;
   end Setup_Buffer;

   --  ------------------------------------------------------------------------

   procedure Setup_Font is
      use GL.Types;
      Font_File  : String := "/System/Library/Fonts/Helvetica.dfont";
   begin
      if FT.Interfac.New_Face (theLibrary, Font_File, 0, Face_Ptr) /= 0 then
         Put_Line ("A face failed to load.");
         raise FT.FT_Exception;
      end if;
      --  Set pixel size to 48 x 48
      if FT.Interfac.Set_Pixel_Sizes (Face_Ptr, 0, 48) /= 0 then
         Put_Line ("Unable to set pixel sizes.");
         raise FT.FT_Exception;
      end if;

      GL.Pixels.Set_Unpack_Alignment (GL.Pixels.Bytes);  --  Disable byte-alignment restriction
   exception
      when others =>
         Put_Line ("An exception occurred in Setup_Font.");
         raise;
   end Setup_Font;

   --  ------------------------------------------------------------------------

   procedure Setup_Graphic (Vertex_Buffer : in out V_Buffer;
                            aTexture      : in out GL.Objects.Textures.Texture;
                            X, Y: GL.Types.Single; Scale : GL.Types.Single;
                            Char          : Character := 'g') is
      use GL.Types;
   begin
      if FT.Interfac.Init_FreeType (theLibrary) /= 0 then
         Put_Line ("The Freetype Library failed to load.");
         raise FT.FT_Exception;
      end if;

      Setup_Font;
      Setup_Buffer (Vertex_Buffer, Char, X, Y, Scale);
      Setup_Texture (aTexture);

      FT.Interfac.Done_Face (Face_Ptr);
      FT.Interfac.Done_Library (theLibrary);
   end Setup_Graphic;

   --  ------------------------------------------------------------------------

   procedure Setup_Texture (aTexture : in out GL.Objects.Textures.Texture) is
      use GL.Objects.Textures.Targets;
      use GL.Pixels;
      use GL.Types;
      Width        : Size;
      Height       : Size;
      X_Offset     : constant GL.Types.Int := 0;
      Y_Offset     : constant GL.Types.Int := 0;
      Num_Levels   : constant GL.Types.Size := 1;
      Char_Data    : FT.Interfac.Character_Record;
      Bitmap_Image : GL.Objects.Textures.Image_Source;
      Error_Code   : FT.FT_Error;
   begin
      Width := Size (FT.Glyphs.Bitmap_Width (Face_Ptr));
      Height := Size (FT.Glyphs.Bitmap_Rows (Face_Ptr));
      FT.Interfac.Set_Char_Data
                     (Char_Data, Width, Height, FT.Glyphs.Bitmap_Left (Face_Ptr),
                     FT.Glyphs.Bitmap_Top (Face_Ptr),
                     FT.Image.Vector_X (FT.Glyphs.Glyph_Advance (Face_Ptr)));

      aTexture.Initialize_Id;
      Texture_2D.Bind (aTexture);
      Texture_2D.Set_Minifying_Filter (GL.Objects.Textures.Linear);
      Texture_2D.Set_Magnifying_Filter (GL.Objects.Textures.Linear);
      Texture_2D.Set_X_Wrapping (GL.Objects.Textures.Clamp_To_Edge); --  Wrap_S
      Texture_2D.Set_Y_Wrapping (GL.Objects.Textures.Clamp_To_Edge); --  Wrap_T
      If Width < 1 and then Height < 1 then
         Texture_2D.Storage (Num_Levels, RGBA8, 1, 1);
      else
         Texture_2D.Storage (Num_Levels, RGBA8, Width, Height);
      end if;

      Error_Code := FT.Glyphs.Bitmap_Image (Face_Ptr, Bitmap_Image);
      if Error_Code = 0 then
         Texture_2D.Load_Sub_Image_From_Data
              (0, X_Offset, Y_Offset, Width, Height, Red, Unsigned_Byte,
               Bitmap_Image);
      else
         Put_Line ("Setup_Texture Bitmap_Image error: " &
                       FT.Errors.Error (Error_Code));
         raise FT.FT_Exception;
      end if;
   exception
      when others =>
         Put_Line ("An exception occurred in Setup_Texture.");
         raise;
   end Setup_Texture;

   --  ------------------------------------------------------------------------

end Texture_Manager;
