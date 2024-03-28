import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/logo_auth.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:firebase_course/homepage.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {

  const VerifyEmailPage({super.key});
  static const id = 'verify email';

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> 
{
  bool clicked = false;
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Center
      (
        child: Padding
        (
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column
          (
            children: 
            [
              SizedBox(height: MediaQuery.of(context).size.height/15,),
              const LogoAuth(size: 150), 
              const SizedBox(height: 32,),
              const Text('You should verify your account to continue', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 32,),
              CustomButtonAuth
              (
                title: 'Verify account', 
                onPressed: ()
                {
                  if(!FirebaseAuth.instance.currentUser!.emailVerified)
                  {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    clicked = true;
                    setState(() {});
                  }
                }
              ),
              if(clicked)
                const VerifyText()
              else
                const SizedBox(height: 32),
              Row
              (
                children: 
                [
                  const Text('verified it? ', style: TextStyle(fontSize: 18),),
                  GestureDetector
                  (
                    onTap: ()
                    {
                      setState(() { });
                      if(FirebaseAuth.instance.currentUser!.emailVerified)
                      {
                        Navigator.of(context).pushNamedAndRemoveUntil(HomePage.id, (route) => false);
                      }
                      else
                      {
                        print(FirebaseAuth.instance.currentUser!);
                        ShowSnackBar(context, 'Sorry! your email is not verified');
                      }
                    },
                    child: const Text('click here', style: TextStyle(color: Colors.orange, fontSize: 18),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyText extends StatelessWidget 
{
  const VerifyText({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Column
    (
      children: 
      [
        const SizedBox(height: 32,),
        Text
        (
          'We have send a link to your email address, please click it to verify your email',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.brown[400]),
        ),
        const SizedBox(height: 32,),
      ],
    );
  }
}
