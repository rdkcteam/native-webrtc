#!/bin/bash

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
cd depot_tools
export PATH=$(pwd):$PATH
cd -

mkdir webrtc-checkout
cd webrtc-checkout
fetch --nohooks webrtc
gclient sync

export WEBRTC_DIR=$(pwd)
cd src
./build/install-build-deps.sh
git checkout remotes/branch-heads/72 --force
gclient sync --force

gn gen out/Default --args='rtc_use_h264=true is_component_ffmpeg=true   rtc_libvpx_build_vp9=false   rtc_use_gtk=false'
cd $WEBRTC_DIR/src/third_party/ffmpeg
 mkdir build
 
./configure --enable-shared --disable-programs --disable-doc --prefix=$WEBRTC_DIR/src/third_party/ffmpeg/build --disable-x86asm
make && make install

cp $WEBRTC_DIR/src/third_party/ffmpeg/build/lib/*   $WEBRTC_DIR/src/out/Default
cd $WEBRTC_DIR/src

grep -rl "solibs" ./out --include="peerconnection_client.ninja" | xargs sed -i '/solibs/s|./libffmpeg.so|./libavcodec.so ./libavformat.so ./libavutil.so ./libswscale.so|g'

cd $WEBRTC_DIR/src
find out/ -name "peerconnection_client.ninja" | xargs sed -i 's|include_dirs =|include_dirs = -I../../third_party/ffmpeg/build/include |g'



git apply ../../72_camera.patch
git apply ../../72_Server.patch
git apply ../../h264patch1.diff
git apply ../../h264patch2.diff


ninja -C out/Default
cd out/Default
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
