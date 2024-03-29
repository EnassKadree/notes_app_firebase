// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_text_field.dart';
import 'package:firebase_course/components/custom_text_field_auth.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:firebase_course/notes/view_notes.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget 
{
  const EditNote({Key? key, required this.note, required this.noteId, required this.category, required this.categoryId}) : super(key: key);
  final String note; 
  final String noteId;
  final String category; 
  final String categoryId;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> 
{
  bool isLoading = false;
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();


  @override
  void initState() 
  {
    controller.text = widget.note;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) 
  {

    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Edit note'),
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
              CustomTextFormFieldNote(controller: controller, hint: 'Take a note'),
              const SizedBox(height: 16,),
              CustomButtonAuth(title: 'Edit', onPressed: () async
              {
                isLoading = true;
                setState(() { });
                await editNote();
                Navigator.of(context).pushReplacement
                (MaterialPageRoute(builder: (context) => ViewNotes(category: widget.category, categoryId: widget.categoryId)));
              })
            ]
          ),
        ),
      ),
    );
  }

  Future<void> editNote() async
  {
    CollectionReference notes = FirebaseFirestore.instance.collection('categories').doc(widget.categoryId).collection('notes');
    try
    {
      await notes.doc(widget.noteId).update({'note' : controller.text});
      ShowSnackBar(context, 'Note updated successfully');
    }
    catch(e)
    {
      ShowSnackBar(context, 'Failed to update note');
    }
  }

  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }

}