# #!/bin/zsh
#
# # Install minimal prerequisites (Ubuntu 18.04 as reference)
# sudo apt update && sudo apt install -y cmake g++ wget unzip
# wget https://github.com/opencv/opencv/archive/master.zip
# wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/master.zip
# unzip master.zip
#  unzip opencv_contrib.zip
# mkdir -p build && cd build
# # Configure
# cmake -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-master/modules ../opencv-master
# # Build
# cmake --build .
# make install

# sudo apt-get install cmake
# sudo apt-get install build-essential libgtk2.0-dev libavcodec-dev libavformat-dev libjpeg.dev libtiff5.dev libswscale-dev libjasper-dev
# git clone --depth=1 https://hub.fastgit.org/opencv/opencv.git
cd opencv
mkdir build
cd build
sudo cmake -DCMAKE_BUILD_TYPE=Release \
-DOPENCV_GENERATE_PKGCONFIG=ON \
-DCMAKE_INSTALL_PREFIX=/usr/local ..
sudo make -j4
sudo make install
echo "/usr/local/lib" >>/etc/ld.so.conf.d/opencv4.conf
ldconfig
