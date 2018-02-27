
with Ada.Text_IO; use Ada.Text_IO;

package body Feedback is
   use GL.Types;

   procedure Begin_Transform_Feedback (Primitive_Mode : Connection_Mode) is
   begin
      Transform_Feedback_API.Begin_Transform_Feedback (Primitive_Mode);
      --        Raise_Exception_On_OpenGL_Error;
   exception
      when  others =>
         Put_Line ("An exception occurred in Feedback.Begin_Transform_Feedback.");
         raise;
   end Begin_Transform_Feedback;

   --  -------------------------------------------------------------------------

   procedure End_Transform_Feedback is
   begin
      null;
--        Transform_Feedback_API.End_Transform_Feedback;
      --        Raise_Exception_On_OpenGL_Error;
   exception
      when  others =>
         Put_Line ("An exception occurred in Feedback.End_Transform_Feedback.");
         raise;
   end End_Transform_Feedback;

   --  -------------------------------------------------------------------------

   procedure Get_Transform_Feedback_Varying
     (Program :  GL.Objects.Programs.Program;
      Index, Buffer_Size, Length, V_Length : Integer;
      V_Type : GL.Objects.Programs.Buffer_Mode; Name : String) is
   begin
      Transform_Feedback_API.Get_Transform_Feedback_Varying
        (Program, Int (Index), Size (Buffer_Size), Size (Length),
         Size (V_Length), V_Type, Name);
      --        Raise_Exception_On_OpenGL_Error;
   exception
      when  others =>
         Put_Line ("An exception occurred in Feedback.Get_Transform_Feedback_Varying.");
         raise;
   end Get_Transform_Feedback_Varying;

   --  -------------------------------------------------------------------------

   --     procedure Texture_Buffer (Target : GL.Objects.Buffers.Buffer_Target;
   --                               Format : GL.Pixels.Internal_Format;
   --                               Object : GL.Objects.Buffers.Buffer'Class) is
   --     begin
   --        Transform_Feedback_API.Tex_Buffer (Target, Format, Object);
   --        Raise_Exception_On_OpenGL_Error;
   --     end Texture_Buffer;

   --  -------------------------------------------------------------------------

   procedure Transform_Feedback_Varyings
     (Program :  GL.Objects.Programs.Program;
      Count : Integer; Varyings : Transform_Feedback_API.Varyings_Array;
      Buffer_Mode : Transform_Feedback_API.Transform_Buffer_Mode) is
   begin
      null;
--        Transform_Feedback_API.Transform_Feedback_Varyings
--          (Program, Size (Count), Varyings, Buffer_Mode);
      --        Raise_Exception_On_OpenGL_Error;
   exception
      when  others =>
         Put_Line ("An exception occurred in Feedback.Transform_Feedback_Varyings.");
         raise;
   end Transform_Feedback_Varyings;

   --  -------------------------------------------------------------------------

end Feedback;
