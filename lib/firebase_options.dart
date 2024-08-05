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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCB-WknlxH0kVj1Z-81t3McjB9aKKxTvP4',
    appId: '1:497383329986:android:0d7fe9b01ed609cbab6b5b',
    messagingSenderId: '497383329986',
    projectId: 'appguardowl',
    storageBucket: 'appguardowl.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIlifHuJbpmQeYSwC6nNinkpxJ9G8lRqw',
    appId: '1:497383329986:ios:8645577171e6f0f0ab6b5b',
    messagingSenderId: '497383329986',
    projectId: 'appguardowl',
    storageBucket: 'appguardowl.appspot.com',
    androidClientId: '497383329986-m5s697o5qlvlg3egck01esmno0bethqg.apps.googleusercontent.com',
    iosClientId: '497383329986-gdidkp84ja616rc6oeirqg0cr23mhmcq.apps.googleusercontent.com',
    iosBundleId: 'com.example.guardowl',
  );

}