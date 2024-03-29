import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/auth/login_page.dart';
import 'package:firebase_course/categories/add_category.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_text_field_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});
  static const id = 'home page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      floatingActionButton: FloatingActionButton
      (
        shape: const CircleBorder(),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add_rounded, color: Colors.white,),
        onPressed: (){Navigator.of(context).pushNamed(AddCategory.id);}
      ),
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
      body: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: GridView
        (
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4/3, crossAxisSpacing: 5, mainAxisSpacing: 5), 
          children: 
          [
            Card
            (
              child: Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column
                (
                  children: 
                  [
                    Image.asset('assets/images/folder.png', height: 100,), 
                    const Text('Company', style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ),
            Card
            (
              child: Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column
                (
                  children: 
                  [
                    Image.asset('assets/images/folder.png', height: 100,), 
                    const Text('Company', style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}