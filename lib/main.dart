import 'package:berber_yeni/services/auth.dart';
import 'package:berber_yeni/services/auth_service.dart';

import 'loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/auth_service.dart';

Locale _locale = WidgetsBinding.instance.window.locale;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      home: AuthServiceForGoogle().handleAuthState(),
    );
  }
}
