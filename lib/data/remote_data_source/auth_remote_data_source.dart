import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRemoteDataSource {
  AuthRemoteDataSource();

  final collection = FirebaseFirestore.instance.collection('users');

  Stream<UserModel?> currentUserStream() {
    return FirebaseAuth.instance.userChanges().asyncExpand<UserModel?>(
      (currentUser) {
        if (currentUser == null) {
          return Stream.value(null);
        }
        return collection.doc(currentUser.uid).snapshots().map((doc) {
          final userData = doc.data();
          if (userData == null) {
            return null;
          }
          return UserModel.fromJson(userData).copyWith(id: doc.id);
        });
      },
    );
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logInUser({
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword({
    required String email,
  }) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> logOutUser() {
    return FirebaseAuth.instance.signOut();
  }

  Future<void> updateUserTokens({required Map<String, dynamic> data}) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await collection.doc(currentUser.uid).update(data);
    }
  }
}
