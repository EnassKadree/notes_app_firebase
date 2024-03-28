import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key, this.size = 70});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center
            (
              child: Container
              (
                padding: const EdgeInsets.all(16),
                height: size ,
                width: size ,
                decoration: BoxDecoration
                (
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(45)
                ),
                child: Image.asset('assets/images/logo.png')
              ),
            );
  }
}