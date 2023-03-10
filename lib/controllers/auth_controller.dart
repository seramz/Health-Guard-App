import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import '../models/objects.dart';
import '../utils/alert_helper.dart';

class AuthController {
  //------------firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  //------------create the user collection refference
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //------------signup function
  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      //---------send email and password to the firebase and create a user
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        //---------------check if the user credential object is not null
        if (value.user != null) {
          //----------------save other user data in cloud firestore
          await saveUserData(value.user!.uid, name, email);
          //----------------if user created successfully show an alert
          // ignore: use_build_context_synchronously
          AlertHelper.showAlert(
              context, DialogType.SUCCES, "Success", "Registration Success!");
        }
      });
    } on FirebaseAuthException catch (e) {
      //----------show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  //-------------save user data in firestore cloud
  Future<void> saveUserData(String uid, String name, String email) async {
    return users
        .doc(uid)
        .set(
          {
            'uid': uid,
            'name': name,
            'email': email,
          },
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("user data saved"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //-------------fetch user data saved in cloud firestore
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      //---------firebase query that fetch user data
      DocumentSnapshot snapshot = await users.doc(uid).get();

      //---------mapping fetch data to user model
      UserModel model =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //-------------sign in function
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      //---------send email and password to the firebase and check if the user is exist or not
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      //----------show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  //-------------signout function
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //-------------send password reset email
  Future<void> sendPassResetEmail(BuildContext context, String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      //-------------show dialog when the email is sent
      AlertHelper.showAlert(context, DialogType.SUCCES, "Reset Email Sent!",
          "Please check your inbox");
    });
  }
}
