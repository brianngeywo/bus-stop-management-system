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
    apiKey: 'AIzaSyCUbQrAIlSuoTrgSaZlHMNdtCCd33z1x14',
    appId: '1:800408495477:web:b52c539e0583da7e995f3c',
    messagingSenderId: '800408495477',
    projectId: 'transpolink-management-system',
    authDomain: 'transpolink-management-system.firebaseapp.com',
    storageBucket: 'transpolink-management-system.appspot.com',
    measurementId: 'G-97LCTYECG5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw6qwqGbN3CNATxgiT56r6V75B4RLuzG4',
    appId: '1:800408495477:android:691bad1b7f64ad70995f3c',
    messagingSenderId: '800408495477',
    projectId: 'transpolink-management-system',
    storageBucket: 'transpolink-management-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7nZH8iPQ0E5lDUglbgi9A6fq8EE5Pswc',
    appId: '1:800408495477:ios:4ffb1d7378db0237995f3c',
    messagingSenderId: '800408495477',
    projectId: 'transpolink-management-system',
    storageBucket: 'transpolink-management-system.appspot.com',
    iosClientId: '800408495477-c0jkm45r1ffgba0jbt6dpossjtrg68tu.apps.googleusercontent.com',
    iosBundleId: 'com.station.busSacco',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7nZH8iPQ0E5lDUglbgi9A6fq8EE5Pswc',
    appId: '1:800408495477:ios:1c6a946b69281543995f3c',
    messagingSenderId: '800408495477',
    projectId: 'transpolink-management-system',
    storageBucket: 'transpolink-management-system.appspot.com',
    iosClientId: '800408495477-jknq9mqp2nl6g3rjdl0ie4o2rr2ueioo.apps.googleusercontent.com',
    iosBundleId: 'com.station.busSacco.RunnerTests',
  );
}
