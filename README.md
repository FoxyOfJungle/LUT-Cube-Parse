# LUT-Cube-Parse
My own GML implementation to parse a .cube LUT file for color grading.
- It supports 32 bits;
- Only tested with 3D LUTs - I will improve this function later, to support 1D LUTs and so on.

------------------------------------------------------

A .cube LUT (Look-Up Table) file is a color grading preset used in digital video and image editing software. It contains a table of pre-defined color values that are applied to the input image or video, transforming its color appearance.

The LUT file is named after its structure, which is a 3D cube. The cube has RGB (Red, Green, Blue) values along its X, Y, and Z axes, respectively. Each point in the cube represents a specific color value, and the LUT file contains information on how to transform the original color values to the new ones.

LUT files are often used in film and video production, where color grading is an essential part of the post-production process. They allow filmmakers to achieve a specific look or mood for their footage by adjusting the color values of the original image or video. LUT files are also used in photography and graphic design for color correction and enhancement.
