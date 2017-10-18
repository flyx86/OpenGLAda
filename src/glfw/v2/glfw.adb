--  part of OpenGLAda, (c) 2017 Felix Krause
--  released under the terms of the MIT license, see the file "COPYING"

with Glfw.Api;
with Glfw.Enums;

with GL;

with Interfaces.C.Strings;

package body Glfw is

   procedure Init is
   begin
      if Api.Init = 0 then
         raise Initialization_Exception;
      end if;
      GL.Init;
   end Init;

   procedure Terminate_Glfw is
   begin
      Api.Glfw_Terminate;
   end Terminate_Glfw;

   procedure Version (Major, Minor, Rev : out Natural) is
      Raw_Major, Raw_Minor, Raw_Rev : C.int;
   begin
      Api.Get_Version (Raw_Major, Raw_Minor, Raw_Rev);
      Major := Natural (Raw_Major);
      Minor := Natural (Raw_Minor);
      Rev   := Natural (Raw_Rev);
   end Version;

   function Time return Seconds is
   begin
      return Api.Get_Time;
   end Time;

   procedure Set_Time (Value : Seconds) is
   begin
      Api.Set_Time (Value);
   end Set_Time;

   function Extension_Supported (Name : String) return Boolean is
   begin
      return Boolean (Api.Extension_Supported (C.Strings.New_String (Name)));
   end Extension_Supported;

   procedure GL_Version (Major, Minor, Rev : out Natural) is
      Raw_Major, Raw_Minor, Raw_Rev : C.int;
   begin
      Api.Get_GL_Version (Raw_Major, Raw_Minor, Raw_Rev);
      Major := Natural (Raw_Major);
      Minor := Natural (Raw_Minor);
      Rev   := Natural (Raw_Rev);
   end GL_Version;

   procedure Toggle_Auto_Poll_Events (Enable  : Boolean) is
   begin
      if Enable then
         Api.Enable (Enums.Auto_Poll_Events);
      else
         Api.Disable (Enums.Auto_Poll_Events);
      end if;
   end Toggle_Auto_Poll_Events;

end Glfw;
