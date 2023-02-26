# Probabilistic robotics project "Planar monocular SLAM".
Final project of the probabilistic robotics course of the a.y. 2022/2023 held by professor Giorgio Grisetti. 

The aim of this project is to solve a SLAM system by developing a Total Least Square algorithm. The scenario is the following: a differential drive robot moving in a 2D environment sensing 3D landmarks by a monocular camera.
Input of the problem:
 - Wheeled odometry
 - Camera parameters (extrinsics and intrinsics)
 - Stream of point projections with the real "id"

Output of the problem:
 - Trajectory of the robot
 - Position of the 3D landmarks
 - Error values
 
 To run the code clone the repository and on the terminal run the command
 ```
$ octave main.m

```
