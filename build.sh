# Clean up old builds
rm -rf ./.build/
rm ssh-proxy-client

# Create the build folder
mkdir .build
cd .build

# Clone the Azure SDK
git clone -b public-preview https://github.com/Azure/azure-iot-sdk-c.git
cd azure-iot-sdk-c
git submodule update --init

# Create a cmake folder for the SDK
mkdir cmake
cd cmake

# Make the Azure SDK
cmake ..
cmake --build .

# Build this app
cd ../../
cmake ..
cmake --build .

# Copy the built app locally
cp ssh-proxy-client ..

cd ..

# Clean up
rm -rf ./.build/