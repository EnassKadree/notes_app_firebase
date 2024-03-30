import 'package:flutter/material.dart';

class CustomButtonUpload extends StatelessWidget 
{
  const CustomButtonUpload({super.key, required this.onPressed, required this.isSelected});
  final void Function()? onPressed;
  final bool isSelected;
  

  @override
  Widget build(BuildContext context) 
  {
    return MaterialButton
    (
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      onPressed: onPressed, 
      color: isSelected? Colors.green : Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(isSelected? 'Uploaded' : 'Upload', style: const TextStyle(color: Colors.white, fontSize: 16),)
    );
  }
}