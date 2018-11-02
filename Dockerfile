FROM arm64v8/ubuntu

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && \
   add-apt-repository universe && printf "deb http:// artful main universe" >> /etc/apt/sources.list && \ 
   apt-get update && apt-get install -y openjdk-8-jre wget android-sdk-platform-tools android-sdk-build-tools && \ 
   wget https://sh.rustup.rs -O rustup-init && sh rustup-init -y && chmod +x $HOME/.cargo/env && $HOME/.cargo/env && \ 
   /usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\xe2\x68\x6e\x45\xfb\x43\xdf\xa4\xd9\x92\xdd\x41\xce\xb6\xb2\x1c\x63\x30\xd7\x92' > /etc/ssl/certs/java/cacerts && \ 
   /var/lib/dpkg/info/ca-certificates-java.postinst configure && printf "2\n" | update-alternatives --config java && \
   apt-get remove openjdk-11-jre-headless
ENV ANDROID_HOME=/usr/lib/android-sdk
