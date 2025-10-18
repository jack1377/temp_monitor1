import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: "AIzaSyA5C2ubgJmIONViCeNYywQIs2wpVBFFc6Q",
        authDomain: "temp-monitor-d2607.firebaseapp.com",
        projectId: "temp-monitor-d2607",
        storageBucket: "temp-monitor-d2607.firebasestorage.app",
        messagingSenderId: "1035898446761",
        appId: "1:1035898446761:web:e1c6b276a3186eef939ab8",
        measurementId: "G-BLBMT69ZBT",
      );
    } else {
      return FirebaseOptions(
        apiKey: "AIzaSyA5C2ubgJmIONViCeNYywQIs2wpVBFFc6Q",
        appId: "1:1035898446761:web:e1c6b276a3186eef939ab8",
        messagingSenderId: "1035898446761",
        projectId: "temp-monitor-d2607",
      );
    }
  }
}
