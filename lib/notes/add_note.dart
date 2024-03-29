// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_text_field.dart';
import 'package:firebase_course/components/custom_text_field_auth.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:firebase_course/notes/view_notes.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget 
{
  const AddNote({Key? key, required this.categoryId, required this.category}) : super(key: key);
  final String categoryId;
  final String category; 

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> 
{
  bool isLoading = false;
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  
  @override
  Widget build(BuildContext context) {

    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Add Note'),
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
              CustomTextFormFieldNote(controller: controller, hint: 'Take a note',),
              const SizedBox(height: 16,),
              CustomButtonAuth(title: 'Add', onPressed: () async
              {
                isLoading = true;
                setState(() { });
                await addNote();
                Navigator.of(context).pushReplacement
                (MaterialPageRoute(builder: (context) => ViewNotes(category: widget.category, categoryId: widget.categoryId)));
              })
            ]
          ),
        ),
      ),
    );
  }

  Future<void> addNote() 
  {
    CollectionReference notes = FirebaseFirestore.instance.collection('categories').doc(widget.categoryId).collection('notes');

    return notes
        .add({
          'note': controller.text,
        })
        .then((value) {isLoading = false; setState(() { }); return ShowSnackBar(context, 'Note added successfully'); })
        .catchError((error) { isLoading = false; setState(() { }); return ShowSnackBar(context, 'Failed to add note');});
  }

  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }

}