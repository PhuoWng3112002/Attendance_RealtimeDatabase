import 'package:attendance_application/modal/user.dart';
import 'package:attendance_application/modal/user_modal.dart';
import 'package:attendance_application/providers/shared_prefs.dart';
import 'package:attendance_application/screens/home_screen.dart';
import 'package:attendance_application/screens/login_screen.dart';
import 'package:attendance_application/screens_by_admin/home_screen_by_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // ProviderScope(
    //   key: const Key('RiverpodProviderScope'),
    //   overrides: <Override>[
    //     prefsProvider.overrideWithValue(sharedPreferences),
    //     firestoreProvider.overrideWithValue(FirebaseFirestore.instance),
    //   ],
    //   observers: <ProviderObserver>[ProviderLogger()],
    // child:
    const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  AppTheme themeData = ref.watch(themeDataProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance Application',
      theme: ThemeData(fontFamily: "SF-Pro-Text"),
      home: AuthCheck(),
      localizationsDelegates: const [MonthYearPickerLocalizations.delegate],
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (sharedPreferences.getString("email") != null) {
        setState(() {
          UserAuth.email = sharedPreferences.getString("email")!;
          userAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable ? const HomeScreenAdmin() : const LoginScreen();
  }
}
