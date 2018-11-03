FROM arm64v8/ubuntu

# set the environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64/jre
ENV GRADLE_HOME=/usr/share/gradle
ENV ANDROID_HOME=/usr/lib/android-sdk
ENV ANDROID_SDK_VERSION 4333796 
ENV PATH="$JAVA_HOME/bin:$ANDROID_HOME/tools/bin:$GRADLE_HOME/bin:${PATH}"

RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common && \
   add-apt-repository ppa:openjdk-r/ppa && add-apt-repository universe && \ 
   printf "deb http:// artful main universe" >> /etc/apt/sources.list && apt-get update && apt-get upgrade -y && \ 
   apt-get install --no-install-recommends -y wget android-sdk android-sdk-platform-tools android-sdk-build-tools gradle && apt-get install --no-install-recommends -y openjdk-8-jdk && \ 
   wget https://sh.rustup.rs -O rustup-init && sh rustup-init -y && chmod +x $HOME/.cargo/env && $HOME/.cargo/env && \ 
   /usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\xe2\x68\x6e\x45\xfb\x43\xdf\xa4\xd9\x92\xdd\x41\xce\xb6\xb2\x1c\x63\x30\xd7\x92' > /etc/ssl/certs/java/cacerts && \ 
   /var/lib/dpkg/info/ca-certificates-java.postinst configure && printf "2\n" | update-alternatives --config java && \ 
   apt-get autoremove -y && mkdir -p /opt/android-sdk && cd /opt/android-sdk && \
   wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
   unzip *tools*linux*.zip && rm -fr *x86* && cd /opt/android-sdk && cp --remove-destination -vraxu * $ANDROID_HOME && \ 
   cd && rm -fr /opt/android-sdk
    
RUN yes|$ANDROID_HOME/tools/bin/sdkmanager --licenses && $ANDROID_HOME/tools/bin/sdkmanager --update && \ 
    $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" "platforms;android-26" "build-tools;26.0.2" && \ 
    $ANDROID_HOME/tools/bin/sdkmanager --uninstall "platforms;android-24"

