import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Init {
  Future<void> initSetup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}
