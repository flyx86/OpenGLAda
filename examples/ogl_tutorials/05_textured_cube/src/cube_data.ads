
with GL.Types; use GL.Types;

package Cube_Data is

    --  The vertices. Three consecutive floats give a 3D vertex;
    --  Three consecutive vertices give a triangle.
    --  A cube has 6 faces with 2 triangles each,
    --  so this makes 6*2 = 12 triangles and 12*3 = 36 vertices
    Vertex_Data : Singles.Vector3_Array (1 .. 36) :=
                    ((-1.0, -1.0, -1.0),  -- triangle 1 : begin
                     (-1.0, -1.0, 1.0),
                     (-1.0, 1.0, 1.0),    -- triangle 1 : end
                     (1.0, 1.0, -1.0),    -- triangle 2 : begin
                     (-1.0, -1.0, -1.0),
                     (-1.0, 1.0, -1.0),   -- triangle 2 : end
                     (1.0, -1.0, 1.0),
                     (-1.0, -1.0, -1.0),
                     (1.0, -1.0, -1.0),
                     (1.0, 1.0, -1.0),
                     (1.0, -1.0, -1.0),
                     (-1.0, -1.0, -1.0),
                     (-1.0, -1.0, -1.0),
                     (-1.0, 1.0, 1.0),
                     (-1.0, 1.0, -1.0),
                     (1.0, -1.0, 1.0),
                     (-1.0, -1.0, 1.0),
                     (-1.0, -1.0, -1.0),
                     (-1.0, 1.0, 1.0),
                     (-1.0, -1.0, 1.0),
                     (1.0, -1.0, 1.0),
                     (1.0, 1.0, 1.0),
                     (1.0, -1.0, -1.0),
                     (1.0, 1.0, -1.0),
                     (1.0, -1.0, -1.0),
                     (1.0, 1.0, 1.0),
                     (1.0, -1.0, 1.0),
                     (1.0, 1.0, 1.0),
                     (1.0, 1.0, -1.0),
                     (-1.0, 1.0, -1.0),
                     (1.0, 1.0, 1.0),
                     (-1.0, 1.0, -1.0),
                     (-1.0, 1.0, 1.0),
                     (1.0, 1.0, 1.0),
                     (-1.0, 1.0, 1.0),
                     (1.0, -1.0, 1.0));

    --  Two UV coordinatesfor each vertex. These were generated randomly.
    UV_Data : Singles.Vector2_Array (1 .. 36) :=
              ((0.000059, 0.000004),
		(0.000103, 0.336048),
		(0.335973, 0.335903),
		(1.000023, 0.000013),
		(0.667979, 0.335851),
		(0.999958, 0.336064),
		(0.667979, 0.335851),
		(0.336024, 0.671877),
		(0.667969, 0.671889),
		(1.000023, 0.000013),
		(0.668104, 0.000013),
		(0.667979, 0.335851),
		(0.000059, 0.000004),
		(0.335973, 0.335903),
		(0.336098, 0.000071),
		(0.667979, 0.335851),
		(0.335973, 0.335903),
		(0.336024, 0.671877),
		(1.000004, 0.671847),
		(0.999958, 0.336064),
		(0.667979, 0.335851),
		(0.668104, 0.000013),
		(0.335973, 0.335903),
		(0.667979, 0.335851),
		(0.335973, 0.335903),
		(0.668104, 0.000013),
		(0.336098, 0.000071),
		(0.000103, 0.336048),
		(0.000004, 0.671870),
		(0.336024, 0.671877),
		(0.000103, 0.336048),
		(0.336024, 0.671877),
		(0.335973, 0.335903),
		(0.667969, 0.671889),
		(1.000004, 0.671847),
		(0.667979, 0.335851));
end Cube_Data;
