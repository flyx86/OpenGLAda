--  part of OpenGLAda, (c) 2017 Felix Krause
--  released under the terms of the MIT license, see the file "COPYING"

with Ada.Text_IO;

with GL.Attributes;
with GL.Buffers;
with GL.FreeType;
with GL.Objects.Buffers;
with GL.Objects.Shaders;
with GL.Objects.Programs;
with GL.Objects.Textures.Targets;
with GL.Objects.Vertex_Arrays;
with GL.Types.Colors;
with GL.Uniforms;
with GL.Window;

with GL_Test.Display_Backend;

procedure FreeType_Test.Basic is
   use GL.Buffers;
   use GL.Types;
   use GL.Objects.Vertex_Arrays;
   use GL_Test;

   procedure Load_Vectors is new GL.Objects.Buffers.Load_To_Buffer
     (Singles.Vector2_Pointers);

   procedure Load_Data (Array1  : Vertex_Array_Object;
                        Buffer1 : GL.Objects.Buffers.Buffer;
                        Width, Height : GL.FreeType.Pixel_Size) is
      use GL.Objects.Buffers;

      Square : constant Singles.Vector2_Array
        := ((0.0, 0.0),
            (Single (Width), 0.0),
            (0.0, Single (Height)),
            (Single (Width), Single (Height)));
   begin
      Array1.Bind;
      Array_Buffer.Bind (Buffer1);
      GL.Attributes.Enable_Vertex_Attrib_Array (0);
      Load_Vectors (Array_Buffer, Square, Static_Draw);
      GL.Attributes.Set_Vertex_Attrib_Pointer (0, 2, Single_Type, 0, 0);
   end Load_Data;

   procedure Load_Shaders (Program : out GL.Objects.Programs.Program) is
      Vertex_Shader   : GL.Objects.Shaders.Shader
        (Kind => GL.Objects.Shaders.Vertex_Shader);
      Fragment_Shader : GL.Objects.Shaders.Shader
        (Kind => GL.Objects.Shaders.Fragment_Shader);
   begin
      Vertex_Shader.Initialize_Id;
      Fragment_Shader.Initialize_Id;
      Program.Initialize_Id;

      Vertex_Shader.Set_Source ("#version 410 core" & Character'Val (10) &
        "layout(location = 0) in vec2 vertex;" & Character'Val (10) &
        "uniform mat4 transformation;" & Character'Val (10) &
        "out vec2 uv;" & Character'Val (10) &
        "void main() {" & Character'Val (10) &
        "  gl_Position = transformation * vec4(vertex, 0.0, 1.0);" & Character'Val (10) &
        "  uv = vertex;" & Character'Val (10) &
        "}");

      Fragment_Shader.Set_Source ("#version 410 core" & Character'Val (10) &
        "in vec2 uv;" & Character'Val (10) &
        "out vec3 color;" & Character'Val (10) &
        "uniform sampler2D texSampler;" & Character'Val (10) &
        "void main() {" & Character'Val (10) &
        "  color = texture(texSampler, uv).rgb;" & Character'Val (10) &
--        "  color = vec4(1.0, 0.0, 0.0, 1.0);" & Character'Val (10) &
        "}");

      Vertex_Shader.Compile;
      Fragment_Shader.Compile;

      if not Vertex_Shader.Compile_Status then
         Ada.Text_IO.Put_Line ("Compilation of vertex shader failed. log:");
         Ada.Text_IO.Put_Line (Vertex_Shader.Info_Log);
      end if;

      if not Fragment_Shader.Compile_Status then
         Ada.Text_IO.Put_Line ("Compilation of fragment shader failed. log:");
         Ada.Text_IO.Put_Line (Fragment_Shader.Info_Log);
      end if;

      -- set up program
      Program.Attach (Vertex_Shader);
      Program.Attach (Fragment_Shader);
      Program.Link;
      if not Program.Link_Status then
         Ada.Text_IO.Put_Line ("Program linking failed. Log:");
         Ada.Text_IO.Put_Line (Program.Info_Log);
         return;
      end if;
   end Load_Shaders;

   Program : GL.Objects.Programs.Program;

   Vector_Buffer1 : GL.Objects.Buffers.Buffer;
   Array1 : GL.Objects.Vertex_Arrays.Vertex_Array_Object;

   Width, Height : GL.FreeType.Pixel_Size;
   Text : constant String := "The quick brown fox jumps over the lazy dog.";
   Text_Image : GL.Objects.Textures.Texture;
   Rendering_Program : GL.FreeType.Font_Rendering_Program;
   Renderer : GL.FreeType.Renderer_Reference;
   Texture_ID : GL.Uniforms.Uniform;
   Transformation : GL.Types.Singles.Matrix4;
   Transformation_ID : GL.Uniforms.Uniform;

   use type GL.Types.Singles.Matrix4;
begin
   Display_Backend.Init;
   Display_Backend.Configure_Minimum_OpenGL_Version (Major => 3, Minor => 2);
   Display_Backend.Open_Window (Width => 500, Height => 500);
   GL.Window.Set_Viewport (0, 0, 500, 500);
   Transformation := GL.Types.Singles.Matrix4'((1.0, 0.0, 0.0, 0.0),
                                               (0.0, 1.0, 0.0, 0.0),
                                               (0.0, 0.0, 1.0, 0.0),
                                               (-1.0, -1.0, 0.0, 1.0)) *
                     GL.Types.Singles.Matrix4'((1.0 / 250.0, 0.0, 0.0, 0.0),
                                               (0.0, 1.0 / 250.0, 0.0, 0.0),
                                               (0.0, 0.0, 1.0, 0.0),
                                               (0.0, 0.0, 0.0, 1.0));
   Ada.Text_IO.Put_Line ("Initialized GLFW window");

   Rendering_Program := GL.FreeType.Init_Program;
   Renderer.Create (Rendering_Program, "../tests/ftgl/SourceCodePro-Regular.ttf", 0);
   Renderer.Calculate_Dimensions (Text, Width, Height);

   Ada.Text_IO.Put_Line ("Rendered text will have the dimensions" & Width'Img &
                           " x" & Height'Img & ".");

   Text_Image := Renderer.To_Texture (Text, Width, Height,
                                      GL.Types.Colors.Color'(1.0, 0.0, 0.0, 0.5));
   GL.Objects.Textures.Set_Active_Unit (0);
   GL.Objects.Textures.Targets.Texture_2D.Bind (Text_Image);

   Ada.Text_IO.Put_Line ("Rendered text to texture");

   Vector_Buffer1.Initialize_Id;
   Array1.Initialize_Id;

   Ada.Text_IO.Put_Line ("Initialized objects");

   Load_Shaders (Program);
   Program.Use_Program;
   Texture_ID := Program.Uniform_Location ("texSampler");
   Transformation_ID := Program.Uniform_Location ("transformation");
   GL.Uniforms.Set_Int (Texture_ID, 0);
   GL.Uniforms.Set_Single (Transformation_ID, Transformation);

   Ada.Text_IO.Put_Line ("Loaded shaders");

   Load_Data (Array1, Vector_Buffer1, Width, Height);

   Ada.Text_IO.Put_Line ("Loaded data");

   GL.Buffers.Set_Color_Clear_Value (Colors.Color'(0.0, 0.2, 0.7, 1.0));
   while Display_Backend.Window_Opened loop
      Clear (Buffer_Bits'(Color => True, Depth => True, others => False));

      Array1.Bind;
      GL.Objects.Vertex_Arrays.Draw_Arrays (Triangle_Strip, 0, 4);

      GL.Objects.Vertex_Arrays.Null_Array_Object.Bind;

      GL.Flush;
      Display_Backend.Swap_Buffers;

      Display_Backend.Poll_Events;
   end loop;

   Display_Backend.Shutdown;
end FreeType_Test.Basic;
