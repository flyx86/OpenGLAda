
with GL.Objects.Programs;

with Window_Types;

package Run is
    procedure Main_Loop(Main_Window    : in out Window_Types.tWindow;
                                         Rendering_Program   : GL.Objects.Programs.Program);
end Run;