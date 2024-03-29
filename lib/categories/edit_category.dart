// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_text_field_auth.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:firebase_course/homepage.dart';
import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget 
{
  const EditCategory({Key? key, required this.name, required this.categoryId}) : super(key: key);
  final String name; 
  final String categoryId;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> 
{
  bool isLoading = false;
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  @override
  void initState() {
    controller.text = widget.name;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Edit category'),
      ),
      body: isLoading? const Center(child: CircularProgressIndicator(color: Colors.orange,),): 
      Padding
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
              CustomButtonAuth(title: 'Save', onPressed: () async
              {
                isLoading = true;
                setState(() { });
                await editCategory();
                Navigator.of(context).pushNamedAndRemoveUntil(HomePage.id, (route) => false,);
              })
            ]
          ),
        ),
      ),
    );
  }

  Future<void> editCategory() async
  {
    try
    {
      await categories.doc(widget.categoryId).update({'name' : controller.text});
      ShowSnackBar(context, 'Category updated successfully');
    }
    catch(e)
    {
      ShowSnackBar(context, 'Failed to update category');
    }
  }

}