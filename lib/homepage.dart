import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget
{
  const HomePage({super.key});
  static const id = 'home page';

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('home page'),
        actions: 
        [
          IconButton
          (
            onPressed: () async
            {
              await FirebaseAuth.instance.signOut();
              GoogleSignIn().disconnect();
              Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.id, (route) => false);
            },   
            icon:const Icon(Icons.exit_to_app_rounded)
          )
        ],
      ),
    );
  }
}