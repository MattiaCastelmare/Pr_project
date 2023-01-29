close all
clear 
clc 

# import utilites
source "utilities/helpers.m"
source "utilities/loader.m"
source "utilities/pose_landmark.m"
source "utilities/pose_pose.m"


global pos_dim = 3;
global landmark_dim = 3;


#load landmark data
A = load("data/world.dat");
landmark_id = A(:,1) + 1;
for i = 1:size(landmark_id)
    land_gt(:,i) = [A(i,2); A(i,3); A(i,4)];
endfor

#load matrix data 
disp('************************** Loading the camera data ******************************');

[K, T_cam, z_near, z_far, img_width, img_height] = load_camera_parameters();

#load trajectory data #
disp('************************** Loading the trajectory data **************************');
data_trajectory = load("data/trajectory.dat");


#h = figure(1);


# PLOT the groundtruth trajectory 
TrueTrajectory=compute_odometry_trajectory(data_trajectory(:,2:4));
disp('*************************** Groundtruth trajectory ******************************');
#hold on;
#plot(TrueTrajectory(:,1),TrueTrajectory(:,2), 'r-', 'lineimg_width', 2);
#title({'Red - Groundtruth'; 'Green - Odometry'});
#pause(1);


# PLOT the odometry trajectory
OdomTrajectory=compute_odometry_trajectory(data_trajectory(:,5:7));
disp('*************************** Odometry trajectory *********************************');
#hold on; 
#plot(OdomTrajectory(:,1),OdomTrajectory(:,2), 'g-', 'lineimg_width', 2);
#pause(5);



disp("***************** Loading measurement and creating data structure ***************");
# Load measurement and create data structure 
[pos, odometry_pose, dict_pos_land] = load_measurements();


disp("************************** Performing triangulation *****************************");
################## TRIANGULATION ##################

Xl_initial_guess = triangulation(K, T_cam, pos, odometry_pose, dict_pos_land); # initial guess for landmarks position
#g = figure(2);
#hold on;

#scatter3(land_gt(1,:),land_gt(2,:), land_gt(3,:), 40,[1,0,0])
#scatter3(Xl_initial_guess(1,:),Xl_initial_guess(2,:), Xl_initial_guess(3,:), 40,[0,1,0])
#view(40,40)
#title({"Red - Groundtruh"; "Green - Inital guess"})
#pause(100)


threshold = 5000;
num_poses = size(odometry_pose)(2);
num_landmarks = 1000;
disp("************************ Performing Total Least Square ***************************");
[H, b, chi_tot, num_inliers] = Proj_H_b(K, T_cam, odometry_pose, Xl_initial_guess, dict_pos_land, num_poses, num_landmarks, threshold, pos_dim, landmark_dim, z_near, z_far, img_width, img_height);
num_inliers
