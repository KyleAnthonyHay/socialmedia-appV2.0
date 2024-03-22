import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socialmediaapv2/auth/LoginOrRegister.dart';
import 'package:socialmediaapv2/auth/auth.dart';
import 'package:socialmediaapv2/firebase_options.dart';
import 'package:socialmediaapv2/pages/HomePage.dart';
import 'package:socialmediaapv2/pages/ProfilePage.dart';
import 'package:socialmediaapv2/pages/UsersPage.dart';
import 'package:socialmediaapv2/theme/DarkMode.dart';
import 'package:socialmediaapv2/theme/LightMode.dart';
// for firebase
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/LoginOrRegister': (context) => const LoginOrRegister(),
        '/HomePage': (context) => HomePage(),
        '/ProfilePage': (context) => ProfilePage(),
        '/UsersPage': (context) => const UserPage(),
      },
    );
  }
}

//test