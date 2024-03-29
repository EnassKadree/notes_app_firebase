// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/auth/login_page.dart';
import 'package:firebase_course/categories/add_category.dart';
import 'package:firebase_course/categories/edit_category.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = true;

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
              //? await GoogleSignIn().disconnect();
              Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.id, (route) => false);
            },   
            icon:const Icon(Icons.exit_to_app_rounded)
          )
        ],
      ),
      body: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.orange,),) :
        GridView.builder
        (
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4/3, crossAxisSpacing: 5, mainAxisSpacing: 5), 
          itemCount: data.length,
          itemBuilder: (context, index)
          {
            return GestureDetector
            (
              onLongPress: () async
              {
                showDialog
                (
                  context: context, builder: (context)
                  {
                    return AlertDialog
                    (
                      title: const Text('Category Options', style: TextStyle(color: Colors.orange),),
                      content: const Text('What do you want to do?'),
                      actions: 
                      [
                        TextButton
                        (
                          onPressed: () async
                          {
                            await FirebaseFirestore.instance.collection('categories').doc(data[index].id).delete();
                            Navigator.of(context).pushReplacementNamed(HomePage.id);
                          }, child: const Text('Delete', style: TextStyle(color: Colors.orange),)
                        ),
                        TextButton
                        (
                          onPressed: () 
                          {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCategory(name: data[index]['name'], categoryId: data[index].id)));
                          }, child: const Text('Edit', style: TextStyle(color: Colors.brown),)
                        ),
                        //TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Cancel', style: TextStyle(color: Colors.grey[700]),)),
                      ],
                    );
                  }
                );
              },
              child: Card
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
              ),
            );
          },
        ),
      )
    );
  }

  getData() async
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('categories').where('u_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() { });
  }
}