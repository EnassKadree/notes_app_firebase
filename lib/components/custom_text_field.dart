// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class CustomTextFormFieldNote extends StatelessWidget 
{
  const CustomTextFormFieldNote({super.key, required this.controller,required this.hint});
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) 
  {
    return TextFormField
    (
      maxLines: 25,
      validator: (val)
      {
        if(val == '')
        {
          return 'field required';
        }
      },
      controller: controller,
      decoration: InputDecoration
      (
        hintStyle: const TextStyle(fontSize: 14),
        filled: false,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: buildOutLineBorder(),
        enabledBorder: buildOutLineBorder(),
        focusedBorder: buildOutLineBorder(Colors.orange),
        errorBorder: buildOutLineBorder(Colors.red[700])
      ),
    );
  }

  OutlineInputBorder buildOutLineBorder([color]) {
    return OutlineInputBorder 
      (
        borderRadius: BorderRadius.circular(10), 
        borderSide: BorderSide(color: color ?? Colors.blueGrey, width: 1)
      );
  }
}