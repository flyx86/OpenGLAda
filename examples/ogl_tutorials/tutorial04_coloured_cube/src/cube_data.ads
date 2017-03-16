
with GL.Types; use GL.Types;

package Cube_Data is

    type tElement_Array is array (GL.Types.UInt range <>) of
      aliased GL.Types.Single;

--  The vertices. Three consecutive floats give a 3D vertex;
--  Three consecutive vertices give a triangle.
--  A cube has 6 faces with 2 triangles each,
--  so this makes 6*2 = 12 triangles and 12*3 = 36 vertices
    Vertex_Data : tElement_Array (0 .. 36 * 3 - 1) :=
                           (-0.5, -0.5, -0.5,
                            -0.5, -0.5, 0.5,
                            -0.5, 0.5, 0.5,
                            0.5, 0.5, -0.5,
                            -0.5, -0.5, -0.5,
                            -0.5, 0.5, -0.5,
                            0.5, -0.5, 0.5,
                            -0.5, -0.5, -0.5,
                            0.5, -0.5, -0.5,
                            0.5, 0.5, -0.5,
                            0.5, -0.5, -0.5,
                            -0.5, -0.5, -0.5,
                            -0.5, -0.5, -0.5,
                            -0.5, 0.5, 0.5,
                            -0.5, 0.5, -0.5,
                            0.5, -0.5, 0.5,
                            -0.5, -0.5, 0.5,
                            -0.5, -0.5, -0.5,
                            -0.5, 0.5, 0.5,
                            -0.5, -0.5, 0.5,
                            0.5, -0.5, 0.5,
                            0.5, 0.5, 0.5,
                            0.5, -0.5, -0.5,
                            0.5, 0.5, -0.5,
                            0.5, -0.5, -0.5,
                            0.5, 0.5, 0.5,
                            0.5, -0.5, 0.5,
                            0.5, 0.5, 0.5,
                            0.5, 0.5, -0.5,
                            -0.5, 0.5, -0.5,
                            0.5, 0.5, 0.5,
                            -0.5, 0.5, -0.5,
                            -0.5, 0.5, 0.5,
                            0.5, 0.5, 0.5,
                            -0.5, 0.5, 0.5,
                            0.5, -0.5, 0.5);

    --  One colour for each vertex. These were generated randomly.
    Colour_Data : tElement_Array (0 .. 36 * 3 - 1) :=
               (0.583,  0.771,  0.014,
		0.609,  0.115,  0.436,
		0.327,  0.483,  0.844,
		0.822,  0.569,  0.201,
		0.435,  0.602,  0.223,
		0.310,  0.747,  0.185,
		0.597,  0.770,  0.761,
		0.559,  0.436,  0.730,
		0.359,  0.583,  0.152,
		0.483,  0.596,  0.789,
		0.559,  0.861,  0.639,
		0.195,  0.548,  0.859,
		0.014,  0.184,  0.576,
		0.771,  0.328,  0.970,
		0.406,  0.615,  0.116,
		0.676,  0.977,  0.133,
		0.971,  0.572,  0.833,
		0.140,  0.616,  0.489,
		0.997,  0.513,  0.064,
		0.945,  0.719,  0.592,
		0.543,  0.021,  0.978,
		0.279,  0.317,  0.505,
		0.167,  0.620,  0.077,
		0.347,  0.857,  0.137,
		0.055,  0.953,  0.042,
		0.714,  0.505,  0.345,
		0.783,  0.290,  0.734,
		0.722,  0.645,  0.174,
		0.302,  0.455,  0.848,
		0.225,  0.587,  0.040,
		0.517,  0.713,  0.338,
		0.053,  0.959,  0.120,
		0.393,  0.621,  0.362,
		0.673,  0.211,  0.457,
		0.820,  0.883,  0.371,
		0.982,  0.099,  0.879);
end Cube_Data;
