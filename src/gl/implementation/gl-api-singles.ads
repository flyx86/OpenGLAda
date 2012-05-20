--------------------------------------------------------------------------------
-- Copyright (c) 2012, Felix Krause <flyx@isobeef.org>
--
-- Permission to use, copy, modify, and/or distribute this software for any
-- purpose with or without fee is hereby granted, provided that the above
-- copyright notice and this permission notice appear in all copies.
--
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-- ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-- WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
-- ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
-- OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
--------------------------------------------------------------------------------

package GL.API.Singles is
   pragma Preelaborate;
   
   use GL.Types.Singles;
   
   procedure Get_Light_Position (Name   : Enums.Light_Name;
                                 Pname  : Enums.Light_Param;
                                 Target : in out Vector4);
   pragma Import (Convention => StdCall, Entity => Get_Light_Position,
                  External_Name => "glGetLightfv");
   
   procedure Get_Light_Direction (Name   : Enums.Light_Name;
                                  Pname  : Enums.Light_Param;
                                  Target : in out Vector3);
   pragma Import (Convention => StdCall, Entity => Get_Light_Direction,
                  External_Name => "glGetLightfv");
   
   procedure Light_Position (Name  : Enums.Light_Name; Pname : Enums.Light_Param;
                             Param : Vector4);
   pragma Import (Convention => StdCall, Entity => Light_Position,
                  External_Name => "glLightfv");
   
   procedure Light_Direction (Name  : Enums.Light_Name; Pname : Enums.Light_Param;
                              Param : Vector3);
   pragma Import (Convention => StdCall, Entity => Light_Direction,
                  External_Name => "glLightfv");
   
end GL.API.Singles;