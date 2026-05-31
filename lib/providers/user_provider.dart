// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:twitter_clone/models/user.dart';

final userProvider = StateNotifierProvider.autoDispose<UserNotifier, LocalUser>(
  (ref) {
    return UserNotifier();
  },
);

class LocalUser {
  final String id;
  final FirebaseUser user;

  LocalUser({required this.id, required this.user});

  LocalUser copyWith({String? id, FirebaseUser? user}) {
    return LocalUser(id: id ?? this.id, user: user ?? this.user);
  }
}

class UserNotifier extends StateNotifier<LocalUser> {
  UserNotifier()
    : super(
        LocalUser(
          id: "error",
          user: FirebaseUser(
            email: "error",
            name: "error",
            profilePic: "https://gravatar.com/avatar/?d=mp",
          ),
        ),
      );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email) async {
    DocumentReference response = await _firestore
        .collection("users")
        .add(
          FirebaseUser(
            email: email,
            name: "No name",
            profilePic: "https://gravatar.com/avatar/?d=mp",
          ).toMap(),
        );

    DocumentSnapshot snapshot = await response.get();

    state = LocalUser(
      id: response.id,
      user: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>),
    );
  }

  Future<void> login(String email) async {
    QuerySnapshot response = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    if (response.docs.isEmpty) {
      print("No firestore user associated  to authenticate email $email");
    }
    if (response.docs.length != 1) {
      print("More than one firestore user associated with email: $email");
    }

    state = LocalUser(
      id: response.docs[0].id,
      user: FirebaseUser.fromMap(
        response.docs[0].data() as Map<String, dynamic>,
      ),
    );
  }

  void logout() {
    state = LocalUser(
      id: "error",
      user: FirebaseUser(
        email: "error",
        name: "error",
        profilePic: "https://gravatar.com/avatar/?d=mp",
      ),
    );
  }
}
