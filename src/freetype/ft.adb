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

with Errors;
with FT.API; use FT.API;

package body FT is

   procedure Done_Library (Library : Library_Ptr) is
      use Errors;
      Code : constant Errors.Error_Code := FT_Done_Library (Library);
   begin
      if Code /= Ok then
         raise FreeType_Exception with "FT.Done_Library failed with error: " &
             Description (Code);
      end if;
   end Done_Library;

   --  -------------------------------------------------------------------------

   procedure Initialize (aLibrary : in out Library_Ptr)is
      use Errors;
      Code : constant Errors.Error_Code := FT_Init_FreeType (System.Address (aLibrary));
   begin
      if Code /= Ok then
         raise FreeType_Exception with "FT.Initialize failed" &
             Description (Code);
      end if;
   end Initialize;

   --  -------------------------------------------------------------------------

end FT;
