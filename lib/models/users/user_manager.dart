// @dart=2.9
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kubico/models/users/user_address.dart';
import 'package:kubico/models/users/user_model.dart';
import 'package:kubico/utils/firebase_errors.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    retriviewUsers();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel user;
  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  bool _obscuredText = true;
  bool get obscuredText => _obscuredText;

  set obscuredText(bool value) {
    _obscuredText = value;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> sigIn(
      {@required UserModel user,
      @required Function onFail,
      @required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
              email: user.email, password: user.password);

      await retriviewUsers(firestoreUser: userCredential.user);

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<void> googleSigin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    if (googleSignIn != null) {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuth.idToken,
          accessToken: googleSignInAuth.accessToken);
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(authCredential);
        await retriviewUsers(firestoreUser: userCredential.user);

        User user = auth.currentUser;

        if (userCredential.additionalUserInfo.isNewUser) {
          this.user.id = user.uid;
          this.user.name = user.displayName;
          this.user.phone = user.phoneNumber;
          this.user.email = user.email;
          await this.user.saveData();
        }
      } catch (error) {
        debugPrint('Erro ao logar ==> $error');
      }
    }
  }

  Future<void> signUp(
      {@required UserModel userModel,
      @required Function onFail,
      @required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password);

      userModel.id = userCredential.user.uid;
      userModel.address = UserAddress(
        street: 'default',
        district: 'default',
        city: 'default',
        province: 'default',
        country: 'Angola',
        latitude: 1.1,
        longitude: 1.1,
      );

      user = userModel;

      await user.saveData();

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<void> retriviewUsers({User firestoreUser}) async {
    final User currentUser = firestoreUser ?? auth.currentUser;
    if (currentUser != null) {
      await firestore.collection("users").get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          user = UserModel.fromDocument(result);
          notifyListeners();
        });
      });
    }
  }

  Future<void> signOut() async {
    auth.signOut();
    //await GoogleSignIn().disconnect();
    user = null;
    notifyListeners();
  }
}
