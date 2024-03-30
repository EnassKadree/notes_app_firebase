// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_button_upload.dart';
import 'package:firebase_course/components/custom_text_field.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditNote extends StatefulWidget 
{
  const EditNote({Key? key, required this.note, required this.noteId, required this.category, required this.categoryId, required this.url}) : super(key: key);
  final String note; 
  final String url;
  final String noteId;
  final String category; 
  final String categoryId;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> 
{
  bool isLoading = false;
  bool isImageLoading = false;
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  File? file;
  String? url;

  @override
  void initState() 
  {
    url = widget.url;
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
              if(url != 'none') 
                GestureDetector
                (
                  onTap: () async
                  {
                    await getImage();
                    setState(() { });
                  },
                  child: Container
                  (
                    width: double.infinity,
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration
                    (
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: isImageLoading? const Center(child: CircularProgressIndicator(color: Colors.orange,),) :
                    ClipRRect
                    (
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url!, fit: BoxFit.cover,)
                    ),
                  ),
                ),
              CustomTextFormFieldNote(controller: controller, hint: 'Take a note'),
              const SizedBox(height: 16,),
              CustomButtonAuth(title: 'Edit', onPressed: () async
              {
                isLoading = true;
                setState(() { });
                await editNote(context);
                Navigator.of(context).pop();
              }),
            ]
          ),
        ),
      ),
    );
  }

  Future<void> editNote(context) async
  {
    CollectionReference notes = FirebaseFirestore.instance.collection('categories').doc(widget.categoryId).collection('notes');
    try
    {
      await notes.doc(widget.noteId).update
      ({
        'note' : controller.text,
        'url' : url
      });
      FirebaseStorage.instance.refFromURL(widget.url).delete();
      ShowSnackBar(context, 'Note updated successfully');
    }
    catch(e)
    {
      ShowSnackBar(context, 'Failed to update note');
    }
  }

    getImage() async
    {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if(image != null)
      {
        isImageLoading = true;
        setState(() { });

        var imageName = basename(image.path);

        file = File(image.path);
        var storageRef = FirebaseStorage.instance.ref(FirebaseAuth.instance.currentUser!.uid).child(imageName);
        await storageRef.putFile(file!);
        url = await storageRef.getDownloadURL();

        isImageLoading = false;
        setState(() { });
      }
  }

  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }

}