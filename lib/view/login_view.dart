import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/theme/colors.dart';
import 'package:todo_list_app/view/home_view.dart';
import 'package:todo_list_app/view_model/authentication_view_model.dart';

import 'sign_up_view.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login"),
),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
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
          
                  await authVM.login(
                    emailController.text,
                    passwordController.text,
                  );
          
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HomeScreen()));
                },
          
              child: Padding(
              padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [AppColors.buttonColor,AppColors.buttonColor])
            ),
            child: Center(child: authVM.loading
                ? const CircularProgressIndicator() : Text("SIGN IN",style: TextStyle(color: Colors.black,fontSize: 16,fontFamily : AutofillHints.familyName,fontWeight: FontWeight.bold),)),
          ),
                ),
              ),
          
              const SizedBox(height: 20),
              Text("OR"),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
          
                    Provider.of<AuthViewModel>(
                      context,
                      listen: false,
                    ).googleLogin();
          
                  },
                  icon: Image.asset(
                    'assets/icons/google_logo.png',
                    height: 24,
                  ),
                  label: const Text(
                    "Sign In with Google",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
          
              TextButton(
          
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SignupScreen()));
                },
          
                child:  Text("Create Account",style: TextStyle(color: Colors.grey),),
              )
            ],
          ),
        ),
      ),
    );
  }
}