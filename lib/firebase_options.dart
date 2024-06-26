// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBitD3ZdFz-cGok-0NEtaktt2-OkrXuNuc',
    appId: '1:821024960814:web:89df7322fba88361950abf',
    messagingSenderId: '821024960814',
    projectId: 'fir-course-a12bf',
    authDomain: 'fir-course-a12bf.firebaseapp.com',
    storageBucket: 'fir-course-a12bf.appspot.com',
    measurementId: 'G-6NE8RFWNTJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGXXYvnhUwBqwJMphvBvm48hz5_41Fq6E',
    appId: '1:821024960814:android:1f22882fed7d9799950abf',
    messagingSenderId: '821024960814',
    projectId: 'fir-course-a12bf',
    storageBucket: 'fir-course-a12bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxfkMoWDGSGzT49JBdw57PlWwhcps9ChE',
    appId: '1:821024960814:ios:5d8bd0df81836f5a950abf',
    messagingSenderId: '821024960814',
    projectId: 'fir-course-a12bf',
    storageBucket: 'fir-course-a12bf.appspot.com',
    iosBundleId: 'com.example.firebaseCourse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxfkMoWDGSGzT49JBdw57PlWwhcps9ChE',
    appId: '1:821024960814:ios:e22b6717998cd088950abf',
    messagingSenderId: '821024960814',
    projectId: 'fir-course-a12bf',
    storageBucket: 'fir-course-a12bf.appspot.com',
    iosBundleId: 'com.example.firebaseCourse.RunnerTests',
  );
}
