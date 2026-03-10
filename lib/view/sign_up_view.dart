import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/theme/colors.dart';
import 'package:todo_list_app/view_model/authentication_view_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: emailController,
              decoration: InputDecoration(

                fillColor: Colors.grey.shade100,

                counterStyle: TextStyle(
                  color: Colors.white,       // Change this to your desired color
                  fontWeight: FontWeight.bold,
                ),
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.white,
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'Email-id',
                hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 20,
                  color: Colors.black,
                ),

              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(

                fillColor: Colors.grey.shade100,

                counterStyle: TextStyle(
                  color: Colors.white,       // Change this to your desired color
                  fontWeight: FontWeight.bold,
                ),
                labelStyle: TextStyle(color: Colors.black),
                focusColor: Colors.white,
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'Password',
                hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                prefixIcon: Icon(
                  Icons.password_outlined,
                  size: 20,
                  color: Colors.black,
                ),

              ),
            ),

            const SizedBox(height: 30),

            InkWell(

              onTap: () async {

                await authVM.signup(
                    emailController.text,
                    passwordController.text);

                Navigator.pop(context);
              },

              child:   Padding(
            padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [AppColors.buttonColor,AppColors.buttonColor])
          ),
          child: Center(child: authVM.loading
              ? const CircularProgressIndicator() : Text("SIGN UP",style: TextStyle(color: Colors.black,fontSize: 16,fontFamily : AutofillHints.familyName,fontWeight: FontWeight.bold),)),
        ),
      ),
    ),
          ],
        ),
      ),
    );
  }
}