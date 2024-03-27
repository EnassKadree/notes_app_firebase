import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget 
{
  const CustomButtonAuth({super.key, required this.title, required this.onPressed});
  final String title; 
  final void Function()? onPressed;
  

  @override
  Widget build(BuildContext context) 
  {
    return MaterialButton
    (
      padding: const EdgeInsets.symmetric(vertical: 16),
      onPressed: onPressed, 
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16),)
    );
  }
}