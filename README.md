# realty_group_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Notifications Feature

This apps Notifications page has two modes:
1. **Firebase-Powered Notifications (Dynamic):** Fetches notifications in real time from Firebase Firestore.
2. **Local Notifications (Static):** Displays notifications already defined 

### Firebase Setup to start the fire base notificatiosn:

1. **Create a Firebase Project:**
   - Go to the [Firebase Console]

2. **Enable Firestore Database:**
   - Go to **Firestore Database** in the Firebase Console.
   - Click **Create Database** and choose **Start in Test Mode**.

3. **Create the `notifications` Collection:**
   - Add a collection named `notifications`.
   - Add sample documents with the following structure:
     ```json
     {
       "message": "Sample Notification"
     }
     

4. **Download Configuration Files:**
   - For **Android**: Download the `google-services.json` file and place it in the  `android/app/` directory.
   

5. **Run the App:**
   

### Local Notifications (Default Behavior)
When the Firebase is not functional:
- The app will display pre-defined notifications, 

