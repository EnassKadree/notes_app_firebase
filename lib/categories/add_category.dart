// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_text_field_auth.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget 
{
  const AddCategory({Key? key}) : super(key: key);
  static const id = 'add category';

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> 
{
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  
  @override
  Widget build(BuildContext context) {

    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Add category'),
      ),
      body: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Form
        (
          key: formstate,
          child: ListView
          (
            children: 
            [
              CustomTextFormFieldAuth(controller: controller, hint: 'Enter Category name',),
              const SizedBox(height: 32,),
              CustomButtonAuth(title: 'Add', onPressed: () async
              {
                await addCategory();
                
                Navigator.of(context).pop();
              })
            ]
          ),
        ),
      ),
    );
  }

  Future<void> addCategory() 
  {
      return categories
          .add({
            'name': controller.text, // John Doe
          })
          .then((value) => ShowSnackBar(context, 'Category added successfully'))
          .catchError((error) => ShowSnackBar(context, 'Failed to add category'));
    }

}