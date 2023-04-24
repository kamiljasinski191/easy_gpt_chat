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
}
