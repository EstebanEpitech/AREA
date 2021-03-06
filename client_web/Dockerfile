# Install dependencies
FROM debian:latest AS build-env
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 psmisc
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Run flutter doctor
RUN flutter doctor -v

# Copy the app files
COPY . /usr/local/bin/app
WORKDIR /usr/local/bin/app

# Get App Dependencies
RUN flutter pub get

# Build the app for the web
RUN flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true -d chrome --web-port:8081

# Document the exposed port
EXPOSE 8081