import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  //object of firebase Authentication
  //with this object need to sign up, sign out, take current user etc
  static FirebaseAuth _auth = FirebaseAuth.instance;
  //here object of firebase user as getter method
  //it will return current user if user exist
  static User? get currentUser => _auth.currentUser;

  static Future<User?> loginAdmin(String email, String pass) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    //have to return a user
    return credential.user;
  }

  static Future<void> logoutAdmin(){
    return _auth.signOut();
  }
}