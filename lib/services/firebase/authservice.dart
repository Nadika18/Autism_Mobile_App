import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  bool ischild = false;
  bool isparent = true;
  final _firebaseAuth = FirebaseAuth.instance;
  User user;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  Future<User> childSignIn(String code, String passcode) async {
    ischild = true;
    var email = code + "@easytalk.com";
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: passcode);
    return FirebaseAuth.instance.currentUser;
  }

  Future<User> signInWithGoogle() async {
    isparent = true;
    final user = await googleSignIn.signIn();
    if (user == null) {
      return null;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      return (FirebaseAuth.instance.currentUser);
    }
  }

  Future<void> signOutWithGoogle() async {
    await _firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
