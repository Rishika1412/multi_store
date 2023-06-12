# Flutter Firebase Ecommerce App

This is a final year B.Tech CSE group project created using a Flutter ecommerce app template and Firebase as the backend. The app allows users to browse through products, add items to their cart, and complete the checkout process.

## Features

- User authentication: Users can create accounts, log in, and log out securely using Firebase Authentication. Authentication features were implemented by Yash Sahu and Rishika Garg.
- Product catalog: The app displays a list of available products, including details such as name, description, price, and an image. Vicky Singh contributed to the UI implementation of the product catalog.
- Shopping cart: Users can add items to their cart and view the contents of the cart. They can also adjust quantities and remove items. Rishika Garg implemented the shopping cart functionality.
- Checkout process: Users can complete the purchase by providing their shipping address and payment details. Firebase Firestore is used to store the order information. Rishika Garg and Vicky Singh worked on the database management using Cloud Firestore for the checkout process.
- Order history: Users can view their past orders and track the status of their deliveries. Yash Sahu and Rishika Garg contributed to the implementation of the order history feature.
- Search functionality: The app includes a search feature to help users find specific products.
- Real-time updates: Firebase Realtime Database is used to provide real-time updates on products and orders. Rishika GArg worked on the real-time updates implementation.
- Admin panel: Admins have access to an admin panel where they can manage products, categories, and user orders. Yash, Vicky and Rishika contributed to the admin panel functionality.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Rishika1412/multi_store.git
   ```

2. Navigate to the project directory:

   ```bash
   cd multi_store
   ```

3. Install the dependencies:

   ```bash
   flutter pub get
   ```

4. Create a new Firebase project and enable the necessary Firebase services (Firebase Authentication, Firestore, Realtime Database).

5. Download the `google-services.json` file from the Firebase console.

6. Place the `google-services.json` file in the `android/app` directory.

7. Run the app:

   ```bash
   flutter run
   ```

## Configuration

Before running the app, make sure to update the Firebase configuration in the `lib/config/firebase_config.dart` file with your own Firebase project credentials.

```dart
// lib/config/firebase_config.dart

class FirebaseConfig {
  static const String apiKey = 'YOUR_API_KEY';
  static const String authDomain = 'YOUR_AUTH_DOMAIN';
  static const String projectId = 'YOUR_PROJECT_ID';
  static const String databaseURL = 'YOUR_DATABASE_URL';
  static const String storageBucket = 'YOUR_STORAGE_BUCKET';
  static const String messagingSenderId = 'YOUR_MESSAGING_SENDER_ID';
}
```

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request. Make sure to follow the existing code style and guidelines.


## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- This project was created using a Flutter ecommerce app template and was further developed and customized for the group project.
- Flutter - Firebase - MySQL : Multi-store App(https://www.udemy.com/course/flutter-multi-store/) by Salah Shams(https://www.udemy.com/course/flutter-multi-store/#instructor-1)

## Contact

If you have any questions or

 need any assistance, feel free to reach out to Rishika Garg at [gargrishika5@gmail.com](mailto:gargrishika5@gmail.com).
