import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService(this._firebaseAuth);

  Stream<User> get user => _firebaseAuth.authStateChanges();

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<String> registerWithEmailPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
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

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
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
