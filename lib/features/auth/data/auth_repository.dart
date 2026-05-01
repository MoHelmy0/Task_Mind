import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_mind/features/auth/models/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
      GoogleSignIn(),
    ));

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  AuthRepository(this._auth, this._firestore, this._googleSignIn);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  CollectionReference get _users => _firestore.collection('users');

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred';
    }
  }

  Future<UserCredential> signUp(String email, String password, String name) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        UserModel userModel = UserModel(
          uid: credential.user!.uid,
          name: name,
          email: email,
          createdAt: DateTime.now(),
        );
        await _users.doc(credential.user!.uid).set(userModel.toMap());
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred';
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw 'Google Sign-In cancelled';

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        final doc = await _users.doc(userCredential.user!.uid).get();
        if (!doc.exists) {
          UserModel userModel = UserModel(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? 'User',
            email: userCredential.user!.email ?? '',
            createdAt: DateTime.now(),
          );
          await _users.doc(userCredential.user!.uid).set(userModel.toMap());
        }
      }

      return userCredential;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
