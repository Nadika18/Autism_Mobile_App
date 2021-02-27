import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  User user;
  var logincode;
  var childLoginInfo;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  Future<DocumentSnapshot> childSignIn(String code) async {
  logincode = code;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var ref = _firestore.collection("children").doc(code);
  childLoginInfo = (await ref.get()).data();
  return ref.get();
  }

  Future<User> signInWithGoogle() async {
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
