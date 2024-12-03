# Realty Group Project
Group Members
Jason Pickering - 100439553
Caleb Gladwin - 100755915
Nicholas Drapak - 100754042
Zain Siddiqui - 100867903
# Realty App README

## Overview

**Realty** is a Flutter-based real estate application that allows users to browse property listings, place bids, track their favorite properties, and manage their profiles. This project integrates Firebase for backend functionality, including authentication, database operations, and notifications. The app demonstrates key Flutter development principles while fulfilling specific project requirements.

---

## Features

### 1. **User Authentication**
- Login and registration using Firebase Authentication.
- Persistent user sessions.
- Guest mode for browsing without signing in.

### 2. **Property Listings**
- View property details such as address, price, number of bedrooms, bathrooms, square footage, and images.
- Search and filter properties by address.
- Add new property listings (for sellers).

### 3. **Bidding System**
- Place bids on properties.
- View the current highest bid.
- Receive notifications when a bid is updated.

### 4. **Favorites Management**
- Track and view starred (favorite) properties.
- Access starred properties from a dedicated "Favorites" page.

### 5. **Search History**
- Maintain a history of searches for easy reference.
- Option to clear search history.

### 6. **Profile Management**
- Update user profile details, including username.
- View personal information and manage settings.

### 7. **Notifications**
- Real-time notifications for changes in property bids.
- Integration with local notifications on Android.

---

## How Requirements Are Met

### **1. Navigation Between Screens**
- The app includes multiple screens: 
  - **Login/Register Page** for user authentication.
  - **Listings Page** for browsing properties.
  - **Add Listing Page** for adding new properties.
  - **User Profile Page** for managing user details.
- Navigation is implemented using **Navigator** and **Routes**, ensuring smooth transitions between screens.

### **2. Dialogs and Pickers**
- **Dialogs**:
  - Used for **user registration** in the `Register.dart` dialog.
  - Used for **username updates** on the User Profile Page.
- **Pickers**:
  - Location picker integrated using the `FlutterMap` package to select property locations.

### **3. Notifications**
- The app includes **real-time notifications** for bid updates using `flutter_local_notifications`.
- Notifications are designed to alert users about essential updates (e.g., changes in the highest bid for a property).
- Proper configuration and handling of notification permissions are implemented.

### **4. Snackbars**
- **Snackbars** are used for brief, non-intrusive feedback:
  - On successful login/logout.
  - To confirm successful property additions or bid placements.
  - To notify users about invalid inputs or errors (e.g., empty fields).

### **5. Local Storage**
- Local storage is implemented using the `SharedPreferences` package:
  - Stores search history, making it easily retrievable for users.
  - Maintains application settings persistently.
- The app also includes functionality to reset and populate Firebase data using a local CSV file through `firebase_clear_and_import.dart`.

### **6. Cloud Storage**
- **Firebase Firestore** is used for cloud storage:
  - Stores property listings, user profiles, and bid information.
  - Data is retrieved efficiently using Firestore queries and streams.
- Firebase setup is correctly configured for Android and web platforms.

### **7. HTTP Requests**
- **External API Interaction**:
  - OpenStreetMap tile layers are integrated for property location display using HTTP requests.
- **Error Handling**:
  - All API calls include error-handling mechanisms to ensure the app remains robust under network issues or invalid data.

---
## Developer Features
1. **Unit Testing:** 
- cd into the root project directory and enter `dart run build_runner build` in the command line
- uses Mockito library
2. **Script for Resetting Firebase "Houses" Table:**
- cd into the root project directory and enter `dart run lib\scripts\firebase_clear_and_import.dart` in the command line
- uses firedart library
- overwrites houses table with dummy data contained in `lib\scripts\houses_data.csv`
---

## Project Structure

### **Main Modules**
1. **Authentication**
   - `AuthService.dart`: Manages user login, logout, and authentication streams.
   - `LoginPage.dart`: User login interface.
   - `Register.dart`: Registration form for new users.

2. **Listings**
   - `ListingsPage.dart`: Displays property listings.
   - `Listing.dart`: Data model and widget for individual property listings.
   - `ListingsModel.dart`: Manages Firebase operations for listings.
   - `AddListingPage.dart`: Interface to add new property listings.

3. **User Management**
   - `UserPage.dart`: Displays user profile.
   - `UserModel.dart`: State management for logged-in user details.
   - `UserData.dart`: User data model.

4. **Favorites**
   - `StarredListings.dart`: State management for favorite properties.
   - `FavouriteListings.dart`: Page displaying all starred properties.

5. **Search**
   - `SearchHistory.dart`: Maintains and displays the user's search history.

6. **Utilities**
   - `Converter.dart`: Helper functions (e.g., number-to-currency formatting).
   - `firebase_clear_and_import.dart`: Script to reset and populate the Firebase database using CSV.

7. **Notifications**
   - `NotificationHandler.dart`: Manages local notifications.

8. **UI Components**
   - `AppDrawer.dart`: Sidebar navigation drawer.

---

## Installation

### Prerequisites
- Flutter SDK installed on your system.
- Firebase project set up with Firestore, Authentication, and Cloud Messaging.

### Steps
1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Update Firebase configuration files (`firebase_options.dart`).
5. Run the app using `flutter run`.

---

## Usage

1. Launch the app.
2. Sign in or browse as a guest.
3. Explore property listings, search for specific addresses, and star your favorites.
4. Place bids on desired properties and monitor bid updates.
5. Add new listings if you're a seller.

---

## Future Enhancements
- Add map-based property search.
- Enable social login (Google, Facebook).
- Enhance search filtering options (price range, property type).
- Implement chat functionality between buyers and sellers.
- Associate listings with sellers
