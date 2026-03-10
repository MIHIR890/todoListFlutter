import 'package:firebase_auth/firebase_auth.dart';

import '../services/authentication_service.dart';
import '../services/local_storage_service.dart';

class AuthRepository {

  final FirebaseService _service = FirebaseService();
  final LocalStorageService _storage = LocalStorageService();

  Future login(String email, String password) async {

    final result = await _service.login(email, password);

    await _storage.saveLogin();

    return result;
  }

  Future signup(String email, String password) async {

    final result = await _service.signup(email, password);

    await _storage.saveLogin();

    return result;
  }

  Future googleLogin() async {

    final result = await _service.signInWithGoogle();

    if(result != null){
      await _storage.saveLogin();
    }

    return result;
  }

  Future logout() async {

    await _service.logout();

    await _storage.logout();
  }

  Future<bool> checkLoginState() async {

    final firebaseUser = FirebaseAuth.instance.currentUser;

    if(firebaseUser != null){
      return true;
    }

    return await _storage.isLoggedIn();
  }
}