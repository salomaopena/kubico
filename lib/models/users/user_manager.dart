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
    _retriviewUsers();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel user;
  bool _loading = false;
  bool get loading => _loading;
  bool _googleLoading = false;
  bool get googleLoading => _googleLoading;

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

  set googleLoading(bool value) {
    _googleLoading = value;
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

      await _retriviewUsers(firestoreUser: userCredential.user);

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<UserCredential> signInWithGoogle(
      {Function onFail, Function onSuccess}) async {
    googleLoading = true;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      await _retriviewUsers(firestoreUser: userCredential.user);

      User u = auth.currentUser;

      if (userCredential.additionalUserInfo.isNewUser) {
        user.id = u.uid;
        user.name = u.displayName;
        user.phone = u.phoneNumber;
        user.email = u.email;

        user.address = UserAddress(
          street: 'default',
          district: 'default',
          city: 'default',
          province: 'default',
          country: 'Angola',
          latitude: 14.123456,
          longitude: -13.00098,
        );

        await user.saveData();

        user.saveToken();

      }
      googleLoading = false;
      onSuccess();
      return await userCredential;
    } on FirebaseAuthException catch (error) {
      googleLoading = false;
      onFail(error);
      return Future.error('Um erro inesperado aconteceu! $error');
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
        latitude: 14.123456,
        longitude: -13.00098,
      );

      user = userModel;

      await user.saveData();

      user.saveToken();

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<void> updateUser(
      {UserModel user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      this.user = user;
      await user.saveData();
      onSuccess();
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      onFail(error.message);
      loading = false;
    }
    loading = false;
  }


  Future<void> _retriviewUsers({User firestoreUser}) async {
    final User currentUser = firestoreUser ?? auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot docUser =
      await firestore.collection("users").doc(currentUser.uid).get();

      user = UserModel.fromDocument(docUser);

      user.saveToken();

      notifyListeners();
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut().whenComplete((){
          debugPrint('Log Out com sucesso! ');
        });
      }
      await auth.signOut();
      user = null;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      debugPrint('Erro ao fazer logout ${error}');
    }
  }


  Future<void> deleteAccount({Function onError}) async {
    try {
      User user = await auth.currentUser;
      await firestore.collection("users").doc(user.uid).delete();
      await user.delete();
      auth.signOut();
      await GoogleSignIn().signOut();
      this.user = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }

  Future<void> resetPassword(
      {String email, Function onSuccess, Function onError}) async {
    loading = true;
    await auth.sendPasswordResetEmail(email: email).whenComplete(() {
      onSuccess();
      loading = false;
    }).onError((error, StackTrace stackTrace) {
      loading = false;
      onError(error);
    });
  }
}
