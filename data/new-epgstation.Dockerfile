FROM l3tnun/epgstation:master-debian

ENV DEV_TOOLS="build-essential cmake automake autoconf curl wget libtool \
meson checkinstall ninja-build pkg-config texinfo libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev zlib1g-dev"

ENV NODEJS="nodejs npm"

ENV DEV_LIB="nasm yasm libmp3lame-dev libopus-dev libvpx-dev \
libx265-dev libnuma-dev libx264-dev libavcodec-dev libavformat-dev \
libswscale-dev libatomic-ops-dev libdevil-dev libsoundtouch-dev \
libboost-all-dev libasound2 libass9 libvdpau1 libva-x11-2 libva-drm2 \
libxcb-shm0 libxcb-xfixes0 libxcb-shape0 libvorbisenc2 libtheora0 \
libsndio7.0 libxv1 libaribb24-dev libxxhash-dev"

ENV VAAPI_DEPS="i965-va-driver-shaders intel-media-va-driver-non-free \
vainfo libfdk-aac-dev libfdk-aac2t64"

RUN apt update && \
    apt -y install $DEV_TOOLS && \
    apt -y install $DEV_LIB && \
    apt -y install $NODEJS && \
\
# Added for vaapi support
    echo "deb http://http.us.debian.org/debian trixie main contrib non-free" | tee -a /etc/apt/sources.list && \
    apt update && \
    apt -y install $VAAPI_DEPS && \
\
# avisynth+
    cd /tmp && \
    git clone https://github.com/AviSynth/AviSynthPlus && \
    cd AviSynthPlus && \
    cmake ./ -G Ninja && \
    checkinstall --pkgname=avisynth \
    --pkgversion="$(grep -r Version avs_core/avisynth.pc | cut -f2 -d " ")-$(date --rfc-3339=date |sed 's/-//g')-git"\
    --backup=no \
    --deldoc=yes \
    --delspec=yes \
    --deldesc=yes \
    --strip=yes \
    --stripso=yes \
    --addso=yes \
    --fstrans=no \
    --default ninja install && \
\
# ffmpeg build (recommend repo for l-smash-works)
    cd /tmp && \
    git clone --depth 1 -b custom-patches-for-lsmashsource \
    https://github.com/HomeOfAviSynthPlusEvolution/FFmpeg.git && \
    cd FFmpeg && \
    ./configure \
      --prefix=/usr/local \
      --disable-shared \
      --pkg-config-flags=--static \
      --enable-gpl \
      --enable-libass \
      --enable-libfreetype \
      --enable-libmp3lame \
      --enable-libopus \
      --enable-libtheora \
      --enable-libvorbis \
      --enable-libvpx \
      --enable-libx264 \
      --enable-libx265 \
      --enable-version3 \
      --enable-libaribb24 \
      --enable-nonfree \
      --disable-debug \
      --disable-doc \
      --enable-vaapi \
      --enable-libfdk-aac \
      --enable-avisynth \
    && \
    make -j$(nproc) && \
    make install && \
\
# l-smash-works
    cd /tmp && \
    git clone https://github.com/dwbuiten/obuparse.git && \
    cd obuparse && \
    make -j$(nproc) && \
    make install && \
\
    cd /tmp && \
    git clone https://github.com/vimeo/l-smash.git && \
    cd l-smash && \
    ./configure --enable-shared && \
    make -j$(nproc) && \
    make install && \
\
    cd /tmp && \
    git clone -b 1310.0.0.0 https://github.com/HomeOfAviSynthPlusEvolution/L-SMASH-Works.git && \
    cd L-SMASH-Works/AviSynth && \
    sed -i -e \
    's/last_percent != percent/& \&\& (percent == 0 || percent == 100)/' -e 's/\\r/\\n/' lwlibav_source.cpp && \
    LDFLAGS="-Wl,-Bsymbolic" meson setup build && \
    cd build && \
    ninja -v && \
    ninja install && \
\
# JoinLogoScpTrialSetLinux
    cd /tmp && \
    git clone --depth 1 --recursive https://github.com/tobitti0/JoinLogoScpTrialSetLinux.git && \
    \
    ## chapter_exe
    cd /tmp/JoinLogoScpTrialSetLinux/modules/chapter_exe/src && \
    sed -i 's/_mm_load_si128/_mm_loadu_si128/g' mvec.cpp && \
    sed -i 's/(__m128i\*)p1 \+  0/(__m128i*)(p1 + 0)/g' mvec.cpp && \
    sed -i 's/(__m128i\*)p2 \+  0/(__m128i*)(p2 + 0)/g' mvec.cpp && \
    sed -i -e 's/^CC = gcc/CC = g++/' \
    -e 's/-std=gnu99/-std=gnu++11/' \
    -e 's/-fno-tree-vectorize//g' \
    -e 's/CFLAGS = -O3/CFLAGS = -O3 -msse2/' Makefile && \
    make -j$(nproc) && \
    mv chapter_exe /tmp/JoinLogoScpTrialSetLinux/modules/join_logo_scp_trial/bin && \
    \
    ## logoframe
    cd /tmp/JoinLogoScpTrialSetLinux/modules/logoframe/src && \
    make -j$(nproc) && \
    mv logoframe /tmp/JoinLogoScpTrialSetLinux/modules/join_logo_scp_trial/bin && \
    \
    ## join_logo_scp
    cd /tmp/JoinLogoScpTrialSetLinux/modules/join_logo_scp/src && \
    make -j$(nproc) && \
    mv join_logo_scp /tmp/JoinLogoScpTrialSetLinux/modules/join_logo_scp_trial/bin && \
    \
    ## tsdivider
    cd /tmp/JoinLogoScpTrialSetLinux/modules/tsdivider && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j$(nproc) && \
    mv tsdivider /tmp/JoinLogoScpTrialSetLinux/modules/join_logo_scp_trial/bin && \
    \
    ## copy directory
    mv /tmp/JoinLogoScpTrialSetLinux/modules/join_logo_scp_trial / && \
\
# delogo
    cd /tmp && \
    git clone https://github.com/tobitti0/delogo-AviSynthPlus-Linux && \
    cd delogo-AviSynthPlus-Linux/src && \
    make -j$(nproc) && \
    make install && \
\
# jlse
    cd /join_logo_scp_trial && \
    npm install && \
    npm link && \
\
# 不要なパッケージを削除
    apt -y remove $DEV_TOOLS && \
    apt -y autoremove && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*