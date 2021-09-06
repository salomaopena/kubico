// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kubico/models/users/user_model.dart';
import 'package:kubico/utils/firebase_errors.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
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

      await _loadCurrentUser(firestoreUser: userCredential.user);

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
        await _loadCurrentUser(firestoreUser: userCredential.user);

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

  Future<Address> convertCoordinateToAddress(Coordinates coordinates) async {
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
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
      user = userModel;

      await user.saveData();

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(getErrorString(error.code));
    }
    loading = false;
  }

  Future<void> _loadCurrentUser({User firestoreUser}) async {
    final User currentUser = firestoreUser ?? auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection("users").doc(currentUser.uid).get();
      user = UserModel.fromDocument(docUser);

      notifyListeners();
    }
  }

  Future<void> signOut() async {
    auth.signOut();
    //await GoogleSignIn().disconnect();
    user = null;
    notifyListeners();
  }

/*Future<void> _loadCurrentUser({User? user}) async {
    final User currentUser = user ?? auth.currentUser!;
    if (currentUser != null) {
      final DocumentSnapshot<Map<String, dynamic>> docUser =
      await firestore.collection("users").doc(currentUser.uid).get();
      this.user = UserModel.fromDocument(docUser);
      debugPrint(this.user!.nome);
      notifyListeners();
    }
    //notifyListeners();
  }*/
}
