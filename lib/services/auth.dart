import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reports_manager/models/auth.dart';

class AuthService {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService(this._firebaseAuth);

  Stream<User> get user => _firebaseAuth.authStateChanges();

  Future<void> signOut() => _firebaseAuth.signOut();

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<String> registerWithEmailPassword(RegistrationData data) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: data.email, password: data.password);
      User user = userCredential.user;
      DocumentReference usersRef = _db.collection('users').doc(user.uid);
      usersRef.set({'firstName': data.firstName, 'lastName': data.lastName});
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use')
        return 'The account already exists for that email.';
      else if (e.code == 'invalid-email')
        return 'The email address is not valid.';
      else if (e.code == 'operation-not-allowed')
        return 'Email/Password signin is not enabled.';
      else if (e.code == 'weak-password')
        return 'The password provided is too weak.';
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future<String> signInWithEmailPassword(SigninData data) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: data.email, password: data.password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email')
        return 'The email address is not valid.';
      else if (e.code == 'user-disabled')
        return 'This user is disabled.';
      else if (e.code == 'user-not-found')
        return 'No user found for that email.';
      else if (e.code == 'wrong-password')
        return 'Wrong password provided for that user.';
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await _firebaseAuth.signInWithCredential(authCredential);
      return null;
    } catch (e) {
      return e.message;
    }
  }
}
