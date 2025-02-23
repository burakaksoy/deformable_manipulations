#!/usr/bin/env bash

# Check if MY_PASSWORD is set
if [ -z "$MY_PASSWORD" ]; then
    read -s -p "Enter your password to install necessary packages: " MY_PASSWORD
    # echo "Password not set. Exiting..."
    echo ""
fi


# CUSTOM RELATED
echo $MY_PASSWORD | sudo -S apt-get install -y sshpass;

echo $MY_PASSWORD | sudo -S apt-get install -y ros-noetic-rqt-ez-publisher;
# echo $MY_PASSWORD | sudo -S apt-get install -y ros-noetic-twist-mux;
echo $MY_PASSWORD | sudo -S apt-get install -y spacenavd;
echo $MY_PASSWORD | sudo -S apt-get install -y ros-noetic-spacenav-node;
echo $MY_PASSWORD | sudo -S apt-get install -y ros-noetic-tf2-sensor-msgs;
echo $MY_PASSWORD | sudo -S apt-get install -y ros-noetic-visualization-tutorials; # rviz python bindings.

# PYTHON RELATED
echo $MY_PASSWORD | sudo -S apt-get install -y python3-pip;

## To install Tesseract Python Planning on Ubuntu 20.04 and Ubuntu 22.04:
sudo apt install python3-pip # python3-numpy
# The supplied version of pip on Ubuntu 20.04 is too old for manylinux_2_31, upgrade pip
python3 -m pip install -U pip
python3 -m pip install --user  tesseract_robotics tesseract_robotics_viewer

# pip3 install pyserial;
# pip3 install scs; # A solver (splitting conic solver)
pip3 install quadprog; # A solver
pip3 install cvxopt; # A solver
pip3 install clarabel; # A solver 

pip3 install cvxpy;
# pip3 install cvxpy[CBC(cylp problems),CVXOPT,GLOP,GLPK,GUROBI,MOSEK(commercial license),PDLP]  # an interface for available qp solvers
# print(cp.installed_solvers()): ['CLARABEL', 'CVXOPT', 'ECOS', 'ECOS_BB', 'GLOP', 'GLPK', 'GLPK_MI', 'GUROBI', 'OSQP', 'PDLP', 'SCIPY', 'SCS']
# Interior point solver algorithms: 'CLARABEL', 'CVXOPT', 'ECOS', 'GUROBI', 'MOSEK',...
# See paper 2008, Kruth, Interior-point algorithms for quadratic programming.
pip3 install cvxpy[CVXOPT,GLOP,GLPK,GUROBI,PDLP] # an interface for available qp solvers
pip3 install qpsolvers;  # another interface for available qp solvers

pip3 install pandas;
pip3 install pygame;
pip3 install scipy;
pip3 install numpy #==1.21; # needed to resolve the issue "AttributeError: module 'numpy' has no attribute 'typeDict'"
pip3 install shapely; # needed to calculate the swarm footprint polygon and costmap parameter updater functions
pip3 install matplotlib #==3.7.3;


pip3 install meshpy;
pip3 install trimesh;
pip3 install python-fcl;
pip3 install rtree;
pip3 install open3d; # ~300MB ,needed for obj. simplification! (You might need to install the following packages: pip3 install testresources)

pip3 install simple-pid;

pip3 install yourdfpy[full] # needed for deformable_simulator_scene_utilities

## Building Steps
cd;
mkdir catkin_ws_deformable;
cd catkin_ws_deformable;
rm -rf {*,.*};

mkdir src;
cd src;

git clone https://github.com/burakaksoy/deformable_manipulations.git;
git clone https://github.com/burakaksoy/deformable_manipulations_rope.git; # Private
git clone https://github.com/burakaksoy/deformable_manipulations_centralized_rope.git; # Private
git clone https://github.com/burakaksoy/deformable_manipulations_fabric.git; # Private
git clone https://github.com/burakaksoy/deformable_manipulations_tent_building.git; # Private
git clone https://github.com/burakaksoy/deformable_simulator_scene_utilities.git # Public
git clone https://github.com/burakaksoy/deformable_description.git # Public
git clone https://github.com/burakaksoy/dlo_simulator_stiff_rods.git; # Private
git clone https://github.com/burakaksoy/dlo_approximation.git; # Public. Used to approximate the dlo with fewer rigid bodies than the simulation representation.
git clone https://github.com/burakaksoy/fabric_simulator.git; # Private
git clone https://github.com/burakaksoy/odio_urdf.git # Public, needed for auto-generating deformable urdf files
git clone https://github.com/burakaksoy/rviz_ortho_view_controller.git;
git clone https://github.com/burakaksoy/rviz_odom_trail_plugin.git; # Public, needed for visualizing the odometry trail in rviz
git clone https://github.com/facontidavide/rosbag_editor.git;
# git clone --branch throttle-tf-repeated-data-error https://github.com/burakaksoy/geometry2.git; # to fix tf repeating data warning flooding
git clone https://github.com/burakaksoy/topic_tf_transformers.git; # to read odom from tf


cd ..;
source /opt/ros/noetic/setup.bash;
# catkin_make -DCATKIN_BLACKLIST_PACKAGES='...;...' -DCMAKE_BUILD_TYPE=Release; 
catkin_make -DCMAKE_BUILD_TYPE=Release; 
source devel/setup.bash;

grep -qxF 'source ~/catkin_ws_deformable/devel/setup.bash' ~/.bashrc || echo 'source ~/catkin_ws_deformable/devel/setup.bash' >> ~/.bashrc;
