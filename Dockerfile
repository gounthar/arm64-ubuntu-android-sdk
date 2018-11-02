FROM arm64v8/ubuntu

ENV ANDROID_HOME=/usr/lib/android-sdk

RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common && \
   add-apt-repository ppa:openjdk-r/ppa && add-apt-repository universe && \ 
   printf "deb http:// artful main universe" >> /etc/apt/sources.list && apt-get update && apt-get upgrade -y && \ 
   apt-get install -y wget android-sdk android-sdk-platform-tools android-sdk-build-tools && \ 
   wget https://sh.rustup.rs -O rustup-init && sh rustup-init -y && chmod +x $HOME/.cargo/env && $HOME/.cargo/env && \ 
   /usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\xe2\x68\x6e\x45\xfb\x43\xdf\xa4\xd9\x92\xdd\x41\xce\xb6\xb2\x1c\x63\x30\xd7\x92' > /etc/ssl/certs/java/cacerts && \ 
   /var/lib/dpkg/info/ca-certificates-java.postinst configure && printf "2\n" | update-alternatives --config java 
#   apt-get remove -y openjdk-11-jre-headless 
# download and install Android SDK # https://developer.android.com/studio/#downloads
ENV ANDROID_SDK_VERSION 4333796 
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip *tools*linux*.zip && \
    rm *tools*linux*.zip
    
# set the environment variables
ENV ANDROID_HOME /opt/android-sdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN find /opt/android-sdk -name android 

#RUN $ANDROID_HOME/android update sdk --no-ui --all
RUN yes|$ANDROID_HOME/tools/bin/sdkmanager --licenses && \ 
   /usr/local/android-sdk-linux/tools/bin/sdkmanager --update

