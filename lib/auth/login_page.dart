// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/auth/register_page.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_text_field_auth.dart';
import 'package:firebase_course/components/logo_auth.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:firebase_course/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget 
{
  const LoginPage({super.key});
  static const  id = 'login page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: isLoading? const Center(child: CircularProgressIndicator(color: Colors.orange,),) :
        Form
        (
          key: formKey,
          child: ListView
          (
            children: 
            [
              SizedBox(height: MediaQuery.of(context).size.height/15,),
              const LogoAuth(),
              const Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              const Text('Login to continue using the app', style: TextStyle(fontSize: 16, color: Colors.grey),),
              const SizedBox(height: 18,),
              const Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              CustomTextFormFieldAuth(hint: 'Enter your email', controller: emailController,),
              const SizedBox(height: 16,),
              const Text('Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              CustomTextFormFieldAuth(hint: 'Enter your password', controller: passwordController,),
              const SizedBox(height: 10,),
              GestureDetector
              (
                onTap: () async
                {
                  
                    if(emailController.text == '')
                    {
                      ShowSnackBar(context, 'Please enter your email first');
                      return;
                    }
                    else
                    {
                      try
                      {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                        ShowSnackBar(context, 'We send a reset password link to your email, you can reset your password there');
                        return;
                      }
                      catch(e)
                      {
                        ShowSnackBar(context, 'Something went wrong!');
                      }
                    }
                },
                child: const Text('Forgot password?', textAlign: TextAlign.end, style: TextStyle(fontSize: 14),),
              ),
              const SizedBox(height: 16,),
              CustomButtonAuth
              (
                title: 'Login', 
                onPressed: () async
                {
                  if(formKey.currentState!.validate())
                  {
                    isLoading = true;
                    setState(() { });
                    await signIn(context);
                  }
                },
              ),
              const SizedBox(height: 32,),
              MaterialButton
              (
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () async
                {
                  isLoading = true;
                  setState(() { });
                  await signInWithGoogle();
                  isLoading = false;
                  setState(() { });
                  Navigator.of(context).pushReplacementNamed(HomePage.id);
                }, 
                color: Colors.red[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    const Text('Login with Google  ', style: TextStyle(color: Colors.white, fontSize: 16),),
                    Image.asset('assets/images/4.png', height: 20,)
                  ],
                )
              ), 
              const SizedBox(height: 28,),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  const Text('Don\'t have an account?  '),
                  InkWell
                  (
                    onTap: (){Navigator.of(context).pushReplacementNamed(RegisterPage.id);},
                    child:const Text('Register', style: TextStyle(color: Colors.orange),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async 
  {
    try 
    {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: emailController.text,
        password: passwordController.text
      );
      if(FirebaseAuth.instance.currentUser!.emailVerified)
      {
        isLoading = false;
        setState(() { });
        Navigator.of(context).pushReplacementNamed(HomePage.id);
      }
    } 
    on FirebaseAuthException catch (e) 
    {
      isLoading = false;
      setState(() { });
      if (e.code == 'user-not-found') 
      {
        ShowSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') 
      {
        ShowSnackBar(context, 'Wrong password provided for that user.');
      }
      else
      {
        ShowSnackBar(context, 'Something went wrong! try again later');
      }
    }
  }


  Future signInWithGoogle() async 
  {
  // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser == null)
    { isLoading = false; setState(() { }); return; }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}