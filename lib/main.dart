import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'view/login_view.dart';
import 'view/home_view.dart';
import 'view_model/task_view_model.dart';
import 'view_model/authentication_view_model.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthViewModel()..checkLoginState(),
        ),

        ChangeNotifierProvider(
          create: (_) => TaskViewModel(),
        ),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthViewModel>(
          builder: (context, authVM, _) {

            if (kDebugMode) {
              print("Login State: ${authVM.isLoggedIn}");
            }

            if (authVM.isLoggedIn) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }

          },
        ),
      ),
    );
  }
}