import 'package:flutter/material.dart';

class CustomTextFormFieldAuth extends StatelessWidget 
{
  const CustomTextFormFieldAuth({super.key, required this.controller, this.hint});
  final TextEditingController controller;
  final hint;

  @override
  Widget build(BuildContext context) 
  {
    return TextFormField
    (
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
        filled: true,
        fillColor: Colors.grey[200],
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
        borderRadius: BorderRadius.circular(50), 
        borderSide: BorderSide(color: color ?? Colors.blueGrey, width: 1)
      );
  }
}