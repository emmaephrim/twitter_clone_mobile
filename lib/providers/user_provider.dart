// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<void> updateName(String name) async {
    await _firestore.collection("users").doc(state.id).update({"name": name});
    state = state.copyWith(user: state.user.copyWith(name: name));
  }

  Future<void> updateProfilePic(File image) async {
    Reference ref = _storage.ref().child('users').child(state.id);
    TaskSnapshot snapshot = await ref.putFile(image);
    String pictureUrl = await snapshot.ref.getDownloadURL();

    await _firestore.collection("users").doc(state.id).update({
      "profilePic": pictureUrl,
    });
    state = state.copyWith(user: state.user.copyWith(profilePic: pictureUrl));
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
