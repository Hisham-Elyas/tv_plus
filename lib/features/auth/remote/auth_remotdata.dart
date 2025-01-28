import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/networking/api_client.dart';
import '../../../core/networking/exception.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../models/login_model.dart';
import '../models/login_response_model.dart';
import '../models/sinup_model.dart';
import '../models/user_model.dart';

abstract class AuthRemotData {
  Future signUp({required SinupModel sinupModel});
  Future logIn({required LoginModel loginModel});

  Future<bool> logeOut();
}

class AuthRemotDataImpHttp implements AuthRemotData {
  final ApiClent apiClent;

  AuthRemotDataImpHttp({required this.apiClent});
  @override
  Future<LoginResponseModel> logIn({required LoginModel loginModel}) async {
    final resalt = await apiClent.posData(
        body: loginModel.toJson(),
        uri: 'http://hishaam1057-001-site1.mtempurl.com/api/users/login');

    if (resalt.statusCode == 200) {
      // debugPrint(resalt.statusCode.toString());
      //   print(resalt.body);
      return LoginResponseModel.fromJson(jsonEncode(resalt.body));
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> logeOut() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signUp({required SinupModel sinupModel}) async {
    final resalt = await apiClent.posData(
        body: sinupModel.toJson(),
        uri: 'http://hishaam1057-001-site1.mtempurl.com/api/users/signup');
    // print(resalt.body);
    // print(resalt.statusCode);
    if (resalt.statusCode == 201) {
      return true;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}

class AuthRemotDataImpFirebase implements AuthRemotData {
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<bool> logIn({required LoginModel loginModel}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);
      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> logeOut() async {
    try {
      await firebaseAuth.signOut();

      return true;
    } on FirebaseException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'Auth Error', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> signUp({required SinupModel sinupModel}) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: sinupModel.email, password: sinupModel.password);
      final UserModel userModel = UserModel(
          phone: sinupModel.phone,
          email: sinupModel.email,
          userName: sinupModel.userName,
          userId: userCredential.user!.uid);

      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'user_info': userModel.toMap()}, SetOptions(merge: true));

      await SharedPrefHelper.setData(
          'user_info', jsonEncode(userModel.toMap()));
      return true;
    } on FirebaseException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'Auth Error', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }
}
