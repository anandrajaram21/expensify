# Expensify

A simple expense tracking application for iOS devices.

## Requirements

- Xcode 16.3 or later
- iOS 18.1 or later
- macOS Ventura or later
- Apple Developer account (for running on physical devices)

## Getting Started

### Clone the Repository

```bash
git clone [repository-url]
cd expensify
```

### Open the Project

1. Open Xcode
2. Select "Open a project or file"
3. Navigate to the cloned repository and select the `expensify.xcodeproj` file

### Run the App

#### Running on Simulator

1. Select the desired simulator from the device dropdown menu in the top toolbar
2. Click the "Run" button (▶️) or press `Cmd + R`

#### Running on a Physical Device

1. Connect your iOS device to your Mac
2. Select your device from the device dropdown menu
3. You may need to:
   - Trust the developer in your device settings
   - Sign in with your Apple ID in Xcode
   - Update the signing certificate in the project settings
4. Click the "Run" button (▶️) or press `Cmd + R`

## Features

- Track and manage your personal and business expenses
- Categorize expenses
- View spending trends
- Export expense reports

## App Icon and Name

The app is named "Expensify" and includes a custom app icon. If you want to change these:

- To change the app name: Modify the `INFOPLIST_KEY_CFBundleDisplayName` value in the project settings
- To update the app icon: Replace the `AppIcon.png` file in `expensify/Assets.xcassets/AppIcon.appiconset/` with your own 1024x1024 PNG image

## Troubleshooting

If you encounter any issues running the app:

1. Ensure Xcode is updated to the latest version
2. Clean the build folder (Shift + Cmd + K)
3. Reset the simulator (Device menu > Erase All Content and Settings)
4. Check that your Apple Developer account has the necessary permissions
