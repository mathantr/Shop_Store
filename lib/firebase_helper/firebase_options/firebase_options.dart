import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isAndroid) {
      // Android
      return const FirebaseOptions(
          apiKey: '1:360087786810:android:5f53319bee927ea4c0ec03',
          appId: 'AIzaSyAe0oIraaZ3m7SX62oPWjXZnEhTkrK14l0',
          messagingSenderId: '360087786810',
          projectId: 'shopstore-9bfa1');
    } else {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:360087786810:android:5f53319bee927ea4c0ec03',
        apiKey: 'AIzaSyAe0oIraaZ3m7SX62oPWjXZnEhTkrK14l0',
        projectId: 'e-commerce-6455a',
        messagingSenderId: '360087786810',
        iosBundleId: 'com.example.shop_store',
      );
    }
  }
}
