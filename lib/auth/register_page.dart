// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_course/auth/login_page.dart';
import 'package:firebase_course/components/custom_button_auth.dart';
import 'package:firebase_course/components/custom_text_field_auth.dart';
import 'package:firebase_course/components/logo_auth.dart';
import 'package:firebase_course/helper/snackbar.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget 
{
  const RegisterPage({super.key});
  static const  id = 'register page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> 
{
  bool isLoading = false; 
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body: isLoading? const Center(child: CircularProgressIndicator(color: Colors.orange,),): 
      Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Form
        (
          key: formKey,
          child: ListView
          (
            children: 
            [
              SizedBox(height: MediaQuery.of(context).size.height/15,),
              const LogoAuth(),
              const Text('Register', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              const Text('Create a new account', style: TextStyle(fontSize: 16, color: Colors.grey),),
              const SizedBox(height: 18,),
              const Text('Username', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              CustomTextFormFieldAuth(hint: 'Enter your username', controller: usernameController,),
              const SizedBox(height: 16,),
              const Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              CustomTextFormFieldAuth(hint: 'Enter your email', controller: emailController,),
              const SizedBox(height: 16,),
              const Text('Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              CustomTextFormFieldAuth(hint: 'Enter your password', controller: passwordController,),
              const SizedBox(height: 10,),
              const SizedBox(height: 16,),
              CustomButtonAuth(title: 'Register', onPressed: () async
              {
                if(formKey.currentState!.validate())
                {
                  isLoading = true;
                  setState(() { });
                  await signUp(context);
                }
              },),
              const SizedBox(height: 28,),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  const Text('Have an account?  '),
                  InkWell
                  (
                    onTap: (){Navigator.of(context).pushReplacementNamed(LoginPage.id);},
                    child:const Text('Login', style: TextStyle(color: Colors.orange),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async 
  {
    try 
    {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword
      (
        email: emailController.text,
        password: passwordController.text,
      );
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Navigator.of(context).pushReplacementNamed(LoginPage.id);
      ShowSnackBar(context, 'verify your account by clicking the link we send to your account then login');
    } 
    on FirebaseAuthException catch (e) 
    {
      isLoading = false;
      setState(() { });
      if (e.code == 'weak-password') 
      {
        ShowSnackBar(context, 'weak password, try something stronger');
      } else if (e.code == 'email-already-in-use') 
      {
        ShowSnackBar(context, 'email already in use');
      }
      else
      {
        ShowSnackBar(context, 'Something went wrong! try again later');
      }
    } catch (e) 
    {
      isLoading = false;
      setState(() { });
      ShowSnackBar(context, e.toString());
    }
  }

  @override
  void dispose()
  {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}