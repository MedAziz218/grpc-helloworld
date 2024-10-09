# Flutter gRPC Application

This Flutter project demonstrates the usage of gRPC for communication between a mobile application and a gRPC server. Follow the instructions below to set up, build, and run the project.

## Prerequisites

Before you can run this project, make sure you have the following installed:

- **Flutter SDK**  
  [Download and install Flutter](https://flutter.dev/docs/get-started/install)
  
- **Protocol Buffers (protoc)**  
  Required for generating Dart code from `.proto` files.  
  [Download Protocol Buffers](https://github.com/protocolbuffers/protobuf/releases/latest) (find the appropriate version for your system under "Assets").

- **gRPC Dart Plugin**  
  Used to generate gRPC client and server stubs from `.proto` files. Install it globally with:
  
  ```bash
  dart pub global activate protoc_plugin
  ```

## Setting up Protocol Buffers on Windows

### 1. Download and Install Protocol Buffers

1. Download the `protoc-<version>-win64.zip` file from the [Protocol Buffers releases page](https://github.com/protocolbuffers/protobuf/releases/latest).
2. Extract the `.zip` file to a folder. For example, extract it to `C:\protoc`.

Here’s the fully corrected version with the additional note:

### 2. Add `protoc-gen-dart` to the Protoc Directory

1. Copy the `protoc-gen-dart.bat` file located in one of the following directories:
   ```
   C:\Users\<YourUsername>\AppData\Local\Pub\bin
   ```
   or
   ```
   C:\Users\<YourUsername>\AppData\Local\Pub\Cache\bin
   ```

2. Paste the `protoc-gen-dart.bat` file into the Protoc installation directory, typically located at:
   ```
   C:\protoc\binj
   ```

3. **If `protoc-gen-dart.bat` is not found**, make sure that you've installed it by following the steps in the **Prerequisites** section, which typically involves running:
   ```bash
   dart pub global activate protoc_plugin
   ```
   This installs the Dart plugin for `protoc` and places the necessary files in the Pub directory.

### 3. Add `protoc` to System PATH

1. Open the **Start Menu**, type **Environment Variables**, and select **Edit the system environment variables**.
2. In the **System Properties** window, click on **Environment Variables**.
3. In the **User variables** section, find and select the **Path** variable, then click **Edit**.
4. In the **Edit Environment Variable** window, click **New** and add the path to the `bin` folder where you extracted Protocol Buffers, for example:
   ```
   C:\protoc\bin
   ```
5. Click **OK** to close all dialog windows.

6. To verify that `protoc` is correctly installed and added to your `PATH`, open a new **Command Prompt** window and type:
   ```bash
   protoc --version
   ```
   You should see the version of `protoc` displayed.

## Setup Instructions

### 1. Install Dependencies

Navigate to the project directory and install the required dependencies by running:

```bash
flutter pub get
```

### 2. Generate gRPC Code

If you have made any changes to the `.proto` files, regenerate the Dart code by running the following command in the project root:

```bash
protoc --dart_out=grpc:lib/src/generated --proto_path ../protos/  helloworld.proto
```

This will generate the necessary Dart files for gRPC in `lib/src/generated`.

### 3. Configure Internet Permission for Android

Ensure that the project has internet permissions for Android to allow network requests. This is already configured in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### 4. Build and Run the Application

To run the app on your connected device or emulator, execute the following command:

```bash
flutter run
```

For building a release version of the app, use:

```bash
flutter build apk
```

This will generate the APK file located in the `build/app/outputs/flutter-apk/` directory.

### 5. Start gRPC Server

The app uses a gRPC server. Make sure the server is running before you send requests. The server code is already integrated within the app, and it will start automatically when the app is launched.

To run the server in debug mode, you can follow the logs in your IDE or use:

```bash
flutter logs
```

### 6. Test the Application

After the server is up and running, you can send gRPC requests from the app to the server. The app will display notifications based on the received requests.

## Additional Notes

- **Regenerating gRPC Files**: If you modify the `.proto` files, remember to regenerate the Dart files using the `protoc` command.
- **Internet Permission**: Make sure that internet permission is enabled on Android to allow communication over the network.
  
