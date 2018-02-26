
with Ada.Containers.Doubly_Linked_Lists;

with GL.Types; use GL.Types;

package Load_VB_Object is

   type VBM_Flags is (VBM_Has_Vertices, VBM_Has_Indices, VBM_Has_Frames,
                      VBM_Has_Materials);
   for VBM_Flags use
     (VBM_Has_Vertices => 1, VBM_Has_Indices => 2,
      VBM_Has_Frames => 4, VBM_Has_Materials => 8);

   type Material_Texture is private;

   procedure Load_From_VBM (File_Name : String; Vertex_Index, Normal_Index,
                            Tex_Coord0_Index : Int; Result : out Boolean);
   procedure Render;

private
   New_Header_Magic : UInt := 16#314d4253#;  -- 1MBS

   type VBM_Header (Magic : UInt := New_Header_Magic) is record
      Name           : String (1 .. 64);
      Size           : UInt := 0;
      Num_Attributes : UInt := 0;
      Num_Frames     : UInt := 0;
      Num_Vertices   : UInt := 0;
      Num_Indices    : UInt := 0;
      Num_Materials  : UInt := 0;
      Index_Type     : Numeric_Type := UByte_Type;
      Flags          : UInt := 0;
      case Magic is
         when others =>
            Num_Chunks  : UInt;
      end case;
   end record;

   type VBM_Attributes_Header is record
      Name           : String (1 .. 64);
      Attribute_Type : Numeric_Type := UByte_Type;
      Components     : UInt := 0;
      Flags          : UInt := 0;
   end record;

   type VBM_Frame_Header is record
      First  : UInt := 0;
      Count  : UInt := 0;
      Flags  : VBM_Flags;
   end record;

   type VBM_Render_Chunk is record
      Material_Index  : UInt := 0;
      First           : UInt := 0;
      Count           : UInt := 0;
   end record;

   type VBM_Vec2F is record
      X  : Float := 0.0;
      Y  : Float := 0.0;
   end record;

   type VBM_Vec3F is record
      X  : Float := 0.0;
      Y  : Float := 0.0;
      Z  : Float := 0.0;
   end record;

   type VBM_Vec4F is record
      X  : Float := 0.0;
      Y  : Float := 0.0;
      Z  : Float := 0.0;
      W  : Float := 0.0;
   end record;

   type VBM_Material is record
      Name               : String (1 .. 32);
      Ambient            : VBM_Vec3F;
      Diffuse            : VBM_Vec3F;
      Specular           : VBM_Vec3F;
      Specular_Exponent  : VBM_Vec3F;
      Transmission       : VBM_Vec3F;
      Shininess          : Float := 0.0;
      Alpha              : Float := 0.0;
      Ambient_Map        : String (1 .. 64);
      Diffuse_Map        : String (1 .. 64);
      Specular_Map       : String (1 .. 64);
      Normal_Map         : String (1 .. 64);
   end record;

   type Material_Texture is record
      Diffuse  : UInt := 0;
      Specular : UInt := 0;
      Normal   : UInt := 0;
   end record;
   package Material_Textures_Package is new
     Ada.Containers.Doubly_Linked_Lists (Material_Texture);
   type Material_Textures is new Material_Textures_Package.List with null record;

end Load_VB_Object;