
# Vehicle Repair and Accident Management System MotoManager Hub (Mobile App)

## Description

A comprehensive vehicle management system built using Flutter and Firebase. This application allows users to manage their vehicle data, view and upload documents, and monitor repair and accident details. there is user role management and there are roles such as user, garage and insurencesCo. Each role has unique attributes and garage user can add and view repair details and they can view accident details while insurenceCo user can add accident details. the user can request revenue liscenses using the mibile app and they can view accident details and repair details.

There is also an admin who uses the Web app to manage users and issue revenue licenses by viewing the user uploaded docunments.


## Mobile App Documentation
## Features

- **User Authentication:** Secure login with Firebase Authentication.
- **Vehicle Management:** Add, edit, and view detailed information about vehicles.
- **Document Management:** Upload PDF files for insurance, eco test, and other documents.
- **Repair Tracking:** Monitor and review past repairs with detailed info.
- **Accident History:** Track vehicle accident records and associated details.
- **Responsive Design:** Adapts to different screen sizes with Flutter's cross-platform capabilities.

## Technologies Used

- **Frontend:**
  - [Flutter](https://flutter.dev/): UI toolkit for crafting natively compiled apps.
  - [Firebase Authentication](https://firebase.google.com/products/auth): Handles user sign-in and sign-up.
  - [Cloud Firestore](https://firebase.google.com/products/firestore): Stores user and vehicle data.

- **Backend:**
  - [Firebase Cloud Storage](https://firebase.google.com/products/storage): Secure storage for files.
  - [Firebase Cloud Functions](https://firebase.google.com/products/functions): Backend functions for admin tasks.

## Setup and Installation

1. **Prerequisites:**
   - [Flutter SDK](https://flutter.dev/docs/get-started/install)
   - [Firebase CLI](https://firebase.google.com/docs/cli)

2. **Clone the Repository:**
   ```bash
   git clone https://github.com/PramodMannapperuma/Final_project.git
   ```
   
3. **Navigate to the project folder**
    ```bash
    cd Final_project/mobile
    ```

3. **Install Dependencies:**
  ```bash
  flutter pub get
  ```

4. **Configure Firebase:**
    Create a Firebase project and register an iOS/Android app.
    Download the google-services.json (for Android) or GoogleService-Info.plist (for iOS) from Firebase Console.
    Place them in their respective locations in the Flutter project.

5. **Run the App:**
    To start the app on a connected device/emulator, use:
  ```bash
  flutter run
  ```

  ### Usage

  - **Sign In/Sign Up:**
      - Users need to sign up or log in to access the app's features.
  - **Vehicle Management:**
      - sers can add, view, and edit their vehicle profiles.
  - **Get revenue license:**
      - Upload PDF files for various vehicle documents and get revenue license.
  - **Accidents and Repairs:**
      - View accident and repair details linked to your vehicles.
  - **Admin Panel:**
      - Admins can manage other users and view detailed information.


  #### Firebase Rules
  Ensure that the Firestore security rules are properly configured to avoid unauthorized access. Sample rules:


  rules_version = '2';

  service cloud.firestore {
    match /databases/{database}/documents {
      match /accidents { allow read, write: if request.auth != null; }
      match /admins { allow read, write: if request.auth != null; }
      match /fileIds { allow read, write: if request.auth != null; }
      match /garages { allow read, write: if request.auth != null; }
      match /insurenceCo { allow read, write: if request.auth != null; }
      match /licenses { allow read, write: if request.auth != null; }
      match /repairs { allow read, write: if request.auth != null; }
      match /users { allow read, write: if request.auth != null; }
      match /vehicles { allow read, write: if request.auth != null; }
    }
  }





# Web App Documentation

This web-based application complements the Vehicle Repair and Accident Management System by providing an accessible, browser-based interface for vehicle owners, admins, and other stakeholders. Built with React and Firebase, this app allows for comprehensive vehicle data management and document tracking.

## Features

- **User Authentication:** Secure login using Firebase Authentication.
- **Admin Dashboard:** A central place for admins to manage users, garages, and insurance companies.
- **Vehicle Management:** Add, edit, and view vehicle details.
- **Document Upload:** Upload vehicle-related PDF files for insurance, eco tests, etc.
- **Repair Tracking:** Monitor and review past repair details.
- **Accident Tracking:** View and analyze accident history for individual vehicles.

## Technologies Used

- **Frontend:**
  - [React](https://reactjs.org/): A JavaScript library for building user interfaces.
  - [Material-UI](https://material-ui.com/): A set of React components for faster and easier web development.
  - [Firebase Authentication](https://firebase.google.com/products/auth): Handles user sign-in/sign-up.
  - [Firebase Firestore](https://firebase.google.com/products/firestore): Stores user, vehicle, and document data.

- **Backend:**
  - [Firebase Cloud Functions](https://firebase.google.com/products/functions): Backend functions for admin tasks.
  - [Firebase Cloud Storage](https://firebase.google.com/products/storage): Secure storage for files.

## Setup and Installation

1. **Prerequisites:**
   - [Node.js](https://nodejs.org/)
   - [Firebase CLI](https://firebase.google.com/docs/cli)

2. **Clone the Repository:**
   ```bash
   git clone https://github.com/PramodMannapperuma/Final_project.git

3. **Navigate to the project directory of web app:**
    ```bash
    cd Final_project/Web_App
    ```

4. **Install Dependencies:**
    ```bash
    npm install
    ```

5. **Configure Firebase:**
    - Create a Firebase project and register your web app.
    - Download the Firebase config object and add it to your React app.
    - Make sure the necessary services are enabled in the Firebase Console.

6. **Run the App:**
  ```bash
  npm start
  ```

  ### Usage

  - **Authentication:**
      - Admins need to sign up or log in to access the web app.
  - **Admin Dashboard**
      - Manage users, garages, and insurance companies
  - **Issuing revenue liscense**
      - Issue softcopy of revenue liscenses.
  - **Admin Panel:**
      - Admins can manage other users and view detailed information.

## Contributing

Interested in contributing to the Smart Agriculture System? Please read through our contributing guidelines. Here, you will find directions for opening issues, coding standards, and notes on development.





