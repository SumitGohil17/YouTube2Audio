## Overview

- **Youtube-audio_backend**: This is the backend service that handles the conversion of YouTube videos to audio files. It is built using Node.js and provides an API for the conversion process.

- **YouTube2Audio**: This is the frontend application built with Flutter. It provides a user interface for users to input YouTube video URLs and download the converted audio files.

## Features

- Convert YouTube videos to audio files.
- Download audio files in MP3 format.
- User-friendly interface for easy conversion and download.
- Backend API for handling conversion requests.

## Getting Started
### Installation

### Prerequisites

- Node.js and npm installed on your machine for the backend.
- Flutter SDK installed for the frontend application.

1. Clone the repository:
   ```bash
   git clone https://github.com/SumitGohil17/YouTube2Audio.git
   cd YouTube2Audio
   ```

2. Get Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```


## Important Configuration

Before running the application, you need to update the backend API URL in the frontend code to point to your local machine's IPv4 address. This is necessary for the frontend to communicate with the backend server running on your machine.

### Steps to Update the API URL

1. **Find Your Local IPv4 Address:**
   - On Windows, open Command Prompt and type `ipconfig`. Look for the "IPv4 Address" under your active network connection.
   - On macOS or Linux, open Terminal and type `ifconfig` or `ip addr show`. Look for the "inet" address under your active network interface.

2. **Update the Code:**
   - Open the `main.dart` file in the `YouTube2Audio` Flutter project.
   - Locate the line with the API URL:
     ```dart
     final apiUrl = 'http://ENTER_YOUR_IPV4_LOCAL_MACHINE_ADDRESS:5000/api/data?URL=$videoUrl';
     ```
   - Replace `ENTER_YOUR_IPV4_LOCAL_MACHINE_ADDRESS` with your actual IPv4 address, for example:
     ```dart
     final apiUrl = 'http://192.168.x.xxx:5000/api/data?URL=$videoUrl';
     ```

3. **Save the Changes:**
   - Save the file and restart the Flutter application to apply the changes.

By following these steps, you ensure that the frontend application can successfully communicate with the backend server running on your local machine.

## Usage

1. Start the backend server.
2. Open the frontend application.
3. Enter the YouTube video URL in the provided text field.
4. Click the "Download Audio" button to convert and download the audio file.
