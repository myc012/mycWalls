import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService{
  FirebaseAuth _auth=FirebaseAuth.instance;

  Kullanici? _userFromfirebaseUser(User user){
    return user != null ? Kullanici(uid: user.uid) : null;
  }

  Future signInEmailAndPass(String email, String password) async {
    try{
      UserCredential authResult = await _auth.signInWithEmailAndPassword
      (email: email, password: password);
      User? firebaseUser = authResult.user;
      return _userFromfirebaseUser(firebaseUser!);
    }catch(e){
      print(e.toString());
    }
  }
  Future signUpWithEmailandPass(String email, String password) async{
    try{
      UserCredential authResult = await _auth.createUserWithEmailAndPassword
      (email: email, password: password);
      User? firebaseUser = authResult.user;
      return _userFromfirebaseUser(firebaseUser!);
    }catch(e){
      print(e.toString());
    }
  }
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}