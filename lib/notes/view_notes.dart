// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_course/notes/add_note.dart';
import 'package:firebase_course/notes/edit_note.dart';
import 'package:flutter/material.dart';

class ViewNotes extends StatefulWidget
{
  const ViewNotes({super.key, required this.category, required this.categoryId});
  final String category;
  final String categoryId; 

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> 
{


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
        
        onPressed: (){Navigator.of(context).push
          (MaterialPageRoute(builder: (context) => 
            AddNote(categoryId: widget.categoryId, category: widget.category)));}
      ),
      appBar: AppBar(title: Text(widget.category),),
      body: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: StreamBuilder
        (
          stream: FirebaseFirestore.instance.collection('categories').doc(widget.categoryId).collection('notes').snapshots(), 
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasData) 
            {
              return GridView.builder
              (
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4/3, crossAxisSpacing: 5, mainAxisSpacing: 5), 
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index)
                {
                  return GestureDetector
                  (
                    onTap: ()
                    {
                      Navigator.of(context).push
                        (MaterialPageRoute
                          (builder: (context) => 
                          EditNote
                          (
                            category: widget.category, 
                            categoryId: widget.categoryId, 
                            note: snapshot.data!.docs[index]['note'], 
                            noteId: snapshot.data!.docs[index].id
                          )));
                    },
                    onLongPress: () async
                    {
                      showDialog
                      (
                        context: context, builder: (context)
                        {
                          return AlertDialog
                          (
                            title: const Text('Delete note', style: TextStyle(color: Colors.orange),),
                            content: const Text('are sure to delete this note?'),
                            actions: 
                            [
                              TextButton
                              (
                                onPressed: () async
                                {
                                  FirebaseFirestore.instance.collection('categories')
                                    .doc(widget.categoryId).collection('notes')
                                      .doc(snapshot.data!.docs[index].id).delete();
                                  Navigator.of(context).pushReplacement
                                  (MaterialPageRoute(builder: (context) => ViewNotes(category: widget.category, categoryId: widget.categoryId)));
                                }, child: const Text('Delete', style: TextStyle(color: Colors.orange),)
                              ),
                              TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Cancel', style: TextStyle(color: Colors.grey[700]),)),
                            ],
                          );
                        }
                      );
                    },
                    child: Card
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: Text(snapshot.data!.docs[index]['note'])
                      ),
                    ),
                  );
                },
              );
            }
            else
            {
              return const Center(child: CircularProgressIndicator(color: Colors.orange,),);
            }
          }
        )
      )
    );
  }
}