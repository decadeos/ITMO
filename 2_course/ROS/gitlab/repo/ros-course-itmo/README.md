# ros course itmo
If you have Ubuntu 22 or 24 or WSL,  you will need Docker. Ubuntu 20.04 users don't need Docker, you have to go the ROS Installation [here](http://wiki.ros.org/noetic/Installation/Ubuntu).

## For Windows users - how to use WSL
For this course you can use WSL indide OS Windows 10 or 11. To do it follow the next steps:
1. Open search line and type `cmd` and prerss Enter. Windows command line must appear.
2. In the Windows command line type `wsl --install` and press Enter. (During installation or later the comman line could ask you to enter the username and/or password, please save the password because you will need it later).
3. Wnen the process finished you will be inside linux system.
4. At any time latert you can open `cmd` and use command `wsl` to enter the linux system.
5. Go to Docker installation section.

## For Ubuntu 22 and 24 users
Just go to the docker installation instruction. 

## Docker installation
Docker is useful tool allowing to use isolated any kind of OS.

1. Install docker following the instructions on https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository 

2. Don't forger to add user to the group docker (https://docs.docker.com/engine/install/linux-postinstall/)

3. Contnue with Docker Usage section

## Docker Usage
The course developer prepared Docker installation bash-scripts for you, but to get it on your computer u have to download it. 
1. Clone the repository via command `git clone https://gitlab.com/likerobotics/ros-course-itmo.git` in the terminal
2. Change the working directory with `cd ros-course-itmo/docker`
3. Now you are in the directory with bash-scripts, foolow this command to see, are they executable `ls`, in the terminal you should see list of files colored green. (if not colored green, use the command `chmod +x *`)
4. Execute ones the command `xhost +local:root` 
5. Execute ones the command to install docker Images `./docker_install.bash`
6. Execite ones to build docker `./docker_build.bash`
7. Execute each time when you want to start docker Container `./docker_run.bash`
> [!NOTE]
> When you close the terminal, the docker session will end and all data inside will be deleted (except the data in the folder `workspace`), it means that you have to work only in this folder when used Docker.
8. If you need another terminal inside Docker, you cant use the previous script because Docker container already started. To open same docker container in differen terminal just make another terminal, go to the `docker` folder and execute the command `./docker_new.bash`.
9. When you installed Docker via my bash-scripts also the ROS installation has been included,  so now you have ROS inside Docker.


## How to check is the ROS installation OK ?

In the docker use `rosversion -d` and in the terminal u have to see the ROS version.


To copy folder with content via command line from Linux dyrectory to mounted folder used by Docker `sudo cp -a /home/likerobotics/ros-course-itmo/lab1/. /home/likerobotics/workspace/src/lab1/`
