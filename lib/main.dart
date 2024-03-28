import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/auth/login_page.dart';
import 'package:firebase_course/auth/register_page.dart';
import 'package:firebase_course/auth/verify_email_page.dart';
import 'package:firebase_course/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp
  ( options: DefaultFirebaseOptions.currentPlatform, );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{

  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) 
      {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });   
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser == null || !FirebaseAuth.instance.currentUser!.emailVerified) ? const LoginPage() : const HomePage(),
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: 
      {
        LoginPage.id : (context) => const LoginPage(),
        RegisterPage.id : (context) => const RegisterPage(),
        HomePage.id : (context) => const HomePage(),
        VerifyEmailPage.id : (context) => const VerifyEmailPage()
      },
    );
  }
}
