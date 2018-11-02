FROM arm64v8/ubuntu

RUN sudo apt-get update && sudo apt-get install -y software-properties-common && sudo add-apt-repository ppa:openjdk-r/ppa && \
   sudo add-apt-repository universe && sudo printf "deb http:// artful main universe" >> /etc/apt/sources.list && \ 
   sudo apt-get update && sudo apt-get install -y openjdk-8-jre wget android-sdk-platform-tools android-sdk-build-tools && \ 
   wget https://sh.rustup.rs -O rustup-init && sh rustup-init -y && chmod +x $HOME/.cargo/env && $HOME/.cargo/env && \ 
   sudo /usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\xe2\x68\x6e\x45\xfb\x43\xdf\xa4\xd9\x92\xdd\x41\xce\xb6\xb2\x1c\x63\x30\xd7\x92' > /etc/ssl/certs/java/cacerts && \ 
   sudo /var/lib/dpkg/info/ca-certificates-java.postinst configure && sudo printf "2\n" | update-alternatives --config java
