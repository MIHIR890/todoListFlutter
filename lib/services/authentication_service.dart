import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();



  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }

  Future<User?> signup(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }
  Future<User?> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser =
    await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);

    return result.user;
  }


  Future<void> logout() async {

    await _auth.signOut();

    if(await _googleSignIn.isSignedIn()){
      await _googleSignIn.signOut();
    }
  }
}