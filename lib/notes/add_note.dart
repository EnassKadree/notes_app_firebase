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

  File? file;
  String? url;

  
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
              if(file != null) 
                Container
                (
                  width: double.infinity,
                  height: 300,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration
                  (
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:ClipRRect
                  (
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(file!, fit: BoxFit.cover,)
                  ),
                ),
              CustomTextFormFieldNote(controller: controller, hint: 'Take a note',),
              const SizedBox(height: 16,),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: 
                [
                  CustomButtonAuth(title: 'Add', onPressed: () async
                  {
                    isLoading = true;
                    setState(() { });
                    await addNote(context);
                    Navigator.of(context).pop();
                  }),
                  CustomButtonUpload(isSelected: url != null,
                  onPressed: () async
                  {
                    await getImage();
                  },)
                ],
              )
            ]
          ),
        ),
      ),
    );
  }

  Future<void> addNote(context) 
  {
    CollectionReference notes = FirebaseFirestore.instance.collection('categories').doc(widget.categoryId).collection('notes');

    return notes
        .add({
          'note': controller.text,
          'url' : url ?? 'none'
        })
        .then((value) {isLoading = false; setState(() { }); return ShowSnackBar(context , 'Note added successfully'); })
        .catchError((error) { isLoading = false; setState(() { }); return ShowSnackBar(context, 'Failed to add note');});
  }

  getImage() async
  {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null)
    {

      var imageName = basename(image.path);

      file = File(image.path);
      var storageRef = FirebaseStorage.instance.ref(FirebaseAuth.instance.currentUser!.uid).child(imageName);
      await storageRef.putFile(file!);
      url = await storageRef.getDownloadURL();
      print('======================================');
      print(url);
      print('======================================');
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