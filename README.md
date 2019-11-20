# Numerical Methods for Graphics Project

Project for Numerical Methods for Graphics (NMG) course. Implementation of
some exercises based on Bézier Curves, B-Spline Curves and their 
applications on Surfaces.

## Prof. Conti Part - Bezier Curves

### Excercise 1
Realizes a Matlab function that implements de Casteljau algorithm for 
drawing Bézier Curves.

### Excercise 2
Takes as input the coordinates of the control polygon and use de Casteljau
algorithm to visualize the relative Bézier curve.

### Excercise 3
Finds control points in the BÃ©zier representation of the parametric with
curve with equations X(t)=1+t+t^2; Y(t)=t^3 and with t in [0, 1], display 
the control polygon and the relative Bézier curve.

### Excercise 4
Takes as input the coordinates of the control polygon of a cubic Bézier 
curve and use de Casteljau algorithm to perform the subdivision of the 
curve given a parameter t_star chosen by the user. Display the control
polygons of the two divided curves and verify that continuity C^3 holds.

### Excercise 5
Starting from a cubic Bézier curve defined by vertices V0, V1, V2, V3,
build grade l+3 Bézier curves, with 1>=1, whose control polygon is the 
polygon V0, V1, V2 -- l times -- V2, V3. Shows an examples.

### Excercise 6
Takes as input the coordinates of the control polygon of a cubic Bézier
curve use the degree elevation algorithm to find the control polygons of
this curve elevated to 4, 5, 6 degrees and draws them.

### Excercise 7
Takes V0=(0,0,0), V1=(1,2,0), V2=(3,2,0), V3 =(6,-1,0) as control points
of a cubic Bézier curve and builds one second cubic Bézier curve that
connects with continuity C^2 with the previus curve. Display the two 
curves and their respective control polygons.

## Prof. Giannelli Part - B-Spline Curves ans Surfaces

## Authors
- Elia Mercatanti
- Marco Calamai
