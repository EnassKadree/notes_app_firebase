import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center
            (
              child: Container
              (
                padding: const EdgeInsets.all(16),
                height: 70,
                width: 70,
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