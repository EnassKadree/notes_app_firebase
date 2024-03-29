import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/auth/login_page.dart';
import 'package:firebase_course/categories/add_category.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});
  static const id = 'home page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  List<QueryDocumentSnapshot> data = [];

  @override
  void initState() 
  {
    getData();
    super.initState();
  }
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
        child: GridView.builder
        (
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4/3, crossAxisSpacing: 5, mainAxisSpacing: 5), 
          itemCount: data.length,
          itemBuilder: (context, index)
          {
            return Card
            (
              child: Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column
                (
                  children: 
                  [
                    Image.asset('assets/images/folder.png', height: 100,), 
                    Text(data[index]['name'], style: const TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }

  getData() async
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('categories').get();
    data.addAll(querySnapshot.docs);
    setState(() { });
  }
}