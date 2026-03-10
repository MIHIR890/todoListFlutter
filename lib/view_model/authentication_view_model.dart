import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/repository/auth_repo.dart';

class AuthViewModel extends ChangeNotifier {

  final AuthRepository _repo = AuthRepository();

  bool loading = false;
  bool isLoggedIn = false;


  AuthViewModel() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      isLoggedIn = user != null;
      notifyListeners();
    });
  }

///Login with email and password
  Future login(String email, String password) async {

    loading = true;
    notifyListeners();

    final result = await _repo.login(email, password);

    if(result != null){
      isLoggedIn = true;
    }
    loading = false;
    notifyListeners();
  }

  Future signup(String email, String password) async {

    loading = true;
    notifyListeners();

    await _repo.signup(email, password);

    isLoggedIn = true;

    loading = false;
    notifyListeners();
  }

  ///login with google
  Future googleLogin() async {

    notifyListeners();

    final user = await _repo.googleLogin();

    if (user == null) {
      return;
    }

    isLoggedIn = true;

    notifyListeners();
  }

  ///logging out

  Future<void> logout() async {

    await _repo.logout();

    isLoggedIn = false;

    notifyListeners();
  }
/// check login state
  Future<void> checkLoginState() async {
    final firebaseUser = FirebaseAuth.instance.currentUser?.uid;

    if (firebaseUser != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = await _repo.checkLoginState();
    }

    notifyListeners();
  }
}