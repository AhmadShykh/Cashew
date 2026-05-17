// Synced with android/app/google-services.json (project cashew-budget-513fe).
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static const String googleOAuthWebClientId =
      '219417103997-02lkn8jpk4a0th8lb25a587d1g01i2vt.apps.googleusercontent.com';

  static const String googleCloudProjectNumber = '219417103997';

  static String get googleDriveApiEnableUrl =>
      'https://console.developers.google.com/apis/api/drive.googleapis.com/overview?project=$googleCloudProjectNumber';

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDiG4ek0tTn2qg3qG_7ZE_vpZSRaFGRJJI',
    appId: '1:219417103997:web:02lkn8jpk4a0th8lb25a587d1g01i2vt',
    messagingSenderId: '219417103997',
    projectId: 'cashew-budget-513fe',
    authDomain: 'cashew-budget-513fe.firebaseapp.com',
    storageBucket: 'cashew-budget-513fe.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiG4ek0tTn2qg3qG_7ZE_vpZSRaFGRJJI',
    appId: '1:219417103997:android:6e0e185573c27c1d482b14',
    messagingSenderId: '219417103997',
    projectId: 'cashew-budget-513fe',
    storageBucket: 'cashew-budget-513fe.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnw75YB1Omi2IKOLzy438GsJpWyrZbzSA',
    appId: '1:219417103997:ios:0915d125478cdcfc482b14',
    messagingSenderId: '219417103997',
    projectId: 'cashew-budget-513fe',
    storageBucket: 'cashew-budget-513fe.firebasestorage.app',
    androidClientId:
        '219417103997-gv99q9f7e2qbps9ogdc72jtq6ue79bae.apps.googleusercontent.com',
    iosClientId:
        '219417103997-gsplvldtv26sh5ndp7p70llscg5116rp.apps.googleusercontent.com',
    iosBundleId: 'com.ahmadali.opencashew',
  );
}
