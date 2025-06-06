// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDWeuBeYWz_V_YCgxmagnzuiWzRKkwIya8',
    appId: '1:520503104733:web:73734e0d033f47a28ab734',
    messagingSenderId: '520503104733',
    projectId: 'online-barter-df181',
    authDomain: 'online-barter-df181.firebaseapp.com',
    storageBucket: 'online-barter-df181.firebasestorage.app',
    measurementId: 'G-ZM96GECZH5',
    databaseURL: 'https://online-barter-df181-default-rtdb.firebaseio.com/'
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARJcK7sWdNe9Og7NByS0j3wP3GF0b323g',
    appId: '1:520503104733:android:ef84d62edc8f73218ab734',
    messagingSenderId: '520503104733',
    projectId: 'online-barter-df181',
    storageBucket: 'online-barter-df181.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRailkRy7Yzw6S4YCMhVgxGrtUPzE4DLM',
    appId: '1:520503104733:ios:81c1dd0ce40870528ab734',
    messagingSenderId: '520503104733',
    projectId: 'online-barter-df181',
    storageBucket: 'online-barter-df181.firebasestorage.app',
    iosBundleId: 'com.example.onlineBarterMarketplace',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRailkRy7Yzw6S4YCMhVgxGrtUPzE4DLM',
    appId: '1:520503104733:ios:81c1dd0ce40870528ab734',
    messagingSenderId: '520503104733',
    projectId: 'online-barter-df181',
    storageBucket: 'online-barter-df181.firebasestorage.app',
    iosBundleId: 'com.example.onlineBarterMarketplace',
    databaseURL: 'https://online-barter-df181-default-rtdb.firebaseio.com/'
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDWeuBeYWz_V_YCgxmagnzuiWzRKkwIya8',
    appId: '1:520503104733:web:3fcf2fff956dab4c8ab734',
    messagingSenderId: '520503104733',
    projectId: 'online-barter-df181',
    authDomain: 'online-barter-df181.firebaseapp.com',
    storageBucket: 'online-barter-df181.firebasestorage.app',
    measurementId: 'G-8M64EZRRF6',
  );
}
