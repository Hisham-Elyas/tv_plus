// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faisal_tv/core/exceptions/firebase_auth_exceptions.dart';
import 'package:faisal_tv/core/exceptions/format_exceptions.dart';
import 'package:faisal_tv/core/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/exceptions/firebase_exceptions.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/localization/constants.dart';
import '../../../core/networking/api_client.dart';
import '../../../core/networking/exception.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../models/login_model.dart';
import '../models/login_response_model.dart' as login_response_model;
import '../models/sinup_model.dart';
import '../models/user_model.dart';

abstract class AuthRemotData {
  Future signUp({required SinupModel sinupModel});
  Future logIn({required LoginModel loginModel});
  Future<UserModel> getUserInfo();
  Future<bool> updateUserInfo({required UserModel userModel});
  Future<bool> logeOut();
  Future<bool> forgotPassword({required String email});
  Future<bool> updateEmail({required String newEmail});
  Future<bool> updatePassword(
      {required String oldPassword, required String newPassword});
  Future<bool> deleteAccount();
}

class AuthRemotDataImpHttp implements AuthRemotData {
  final ApiClent apiClent;

  AuthRemotDataImpHttp({required this.apiClent});
  @override
  Future<login_response_model.LoginResponseModel> logIn(
      {required LoginModel loginModel}) async {
    final resalt = await apiClent.posData(
        body: loginModel.toJson(),
        uri: 'http://hishaam1057-001-site1.mtempurl.com/api/users/login');

    if (resalt.statusCode == 200) {
      // debugPrint(resalt.statusCode.toString());
      //   print(resalt.body);
      return login_response_model.LoginResponseModel.fromJson(
          jsonEncode(resalt.body));
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

  @override
  Future<UserModel> getUserInfo() {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateEmail({required String newEmail}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updatePassword(
      {required String oldPassword, required String newPassword}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> forgotPassword({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAccount() {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateUserInfo({required UserModel userModel}) {
    throw UnimplementedError();
  }
}

class AuthRemotDataImpFirebase implements AuthRemotData {
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserInfo() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Access user_info map
        Map<String, dynamic> userInfo = data['user_info'];

        print("User Name: ${userInfo['name']}");
        print("User Email: ${userInfo['email']}");
      } else {
        print("User not found");
      }
      // print("==================================");

      final doc = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      if (!doc.exists) {
        showCustomSnackBar(
            message: UserDataNotFound.tr,
            title: UserInfoError.tr,
            isError: true);
        throw "User data not found.";
      }
      final userval = doc.data()!['user_info'];
      await SharedPrefHelper.setData('user_info', jsonEncode(userval));
      return UserModel.fromMap(userval);
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  @override
  Future<bool> logIn({required LoginModel loginModel}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: loginModel.email,
        password: loginModel.password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  @override
  Future<bool> logeOut() async {
    try {
      await firebaseAuth.signOut();
      showCustomSnackBar(
        message: LoggedOutSuccessfully.tr,
        title: Success.tr,
        isError: false,
      );
      await SharedPrefHelper.removeData('user_info');
      return true;
    } catch (e) {
      showCustomSnackBar(
        message: FailedToLogOut.tr,
        title: LogoutError.tr,
        isError: true,
      );
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

      showCustomSnackBar(
        message: AccountCreatedSuccessfully.tr,
        title: SignUpSuccess.tr,
        isError: false,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      print(e.toString());
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw "Someting went weong. pleas try agin";
    }
  }

  @override
  Future<bool> updateEmail({required String newEmail}) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user == null) {
        showCustomSnackBar(
          message: NoUserSignedIn.tr,
          title: AuthError.tr,
          isError: true,
        );
        return false;
      }

      if (!user.emailVerified) {
        showCustomSnackBar(
          message: VerifyEmailBeforeUpdate.tr,
          title: VerificationRequired.tr,
          isError: true,
        );
        await Future.delayed(
          const Duration(seconds: 3),
          () async {
            await resendEmailVerification();
          },
        );
        return false;
      }

      await user.updateEmail(newEmail);
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update({'user_info.email': newEmail});

      showCustomSnackBar(
        message: EmailUpdatedSuccessfully.tr,
        title: UpdateSuccess.tr,
        isError: false,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  @override
  Future<bool> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user == null || user.email == null) {
        showCustomSnackBar(
          message: NoUserSignedIn.tr,
          title: AuthError.tr,
          isError: true,
        );
        return false;
      }

      if (!user.emailVerified) {
        showCustomSnackBar(
          message: VerifyEmailBeforePasswordUpdate.tr,
          title: VerificationRequired.tr,
          isError: true,
        );
        await Future.delayed(
          const Duration(seconds: 3),
          () async {
            await resendEmailVerification();
          },
        );
        return false;
      }

      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      showCustomSnackBar(
        message: PasswordUpdatedSuccessfully.tr,
        title: Success.tr,
        isError: false,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

      showCustomSnackBar(
        message: PasswordResetLinkSent.tr,
        title: ResetPassword.tr,
        isError: false,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  Future<void> resendEmailVerification() async {
    User? user = firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      showCustomSnackBar(
        message: VerificationEmailSent.tr,
        title: EmailSent.tr,
        isError: false,
      );
    } else {
      showCustomSnackBar(
        message: AlreadyVerified.tr,
        title: AlreadyVerifiedTitle.tr,
        isError: false,
      );
    }
  }

  @override
  Future<bool> updateUserInfo({required UserModel userModel}) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user == null) {
        showCustomSnackBar(
          message: NoUserSignedIn.tr,
          title: AuthError.tr,
          isError: true,
        );
        return false;
      }

      // Update Firestore user data
      await firebaseFirestore.collection('users').doc(userModel.userId).update({
        'user_info': userModel.toMap(),
      });

      // Optionally, update shared preferences or other local storage
      await SharedPrefHelper.setData(
          'user_info', jsonEncode(userModel.toMap()));
      showCustomSnackBar(
        message: UserInfoUpdatedSuccessfully.tr,
        title: UpdateSuccess.tr,
        isError: false,
      );

      return true;
    } catch (e) {
      log(e.toString());
      showCustomSnackBar(
        message: FailedToUpdateUserInfo.tr,
        title: UpdateError.tr,
        isError: true,
      );
      return false;
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user == null) {
        showCustomSnackBar(
          message: NoUserSignedIn.tr,
          title: AuthError.tr,
          isError: true,
        );
        return false;
      }

      // Delete user data from Firestore
      await firebaseFirestore.collection('users').doc(user.uid).delete();

      // Delete the user account from Firebase Authentication
      await user.delete();
      SharedPrefHelper.removeData('user_info');

      showCustomSnackBar(
        message: AccountDeletedSuccessfully.tr,
        title: Success.tr,
        isError: false,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  // /// Handles Firebase Authentication Errors and returns user-friendly messages.
  // String _handleFirebaseAuthError(FirebaseAuthException e) {
  //   log(e.message.toString());
  //   switch (e.code) {
  //     case 'user-not-found':
  //     case 'wrong-password':
  //       return IncorrectEmailOrPassword.tr;
  //     case 'email-already-in-use':
  //       return EmailAlreadyInUse.tr;
  //     case 'invalid-email':
  //       return InvalidEmailFormat.tr;
  //     case 'weak-password':
  //       return WeakPassword.tr;
  //     case 'too-many-requests':
  //       return TooManyRequests.tr;
  //     case 'requires-recent-login':
  //       return RequiresRecentLogin.tr;
  //     case 'user-disabled':
  //       return UserDisabled.tr;
  //     case 'operation-not-allowed':
  //       return OperationNotAllowed.tr;
  //     case 'network-request-failed':
  //       return NetworkRequestFailed.tr;
  //     case 'credential-already-in-use':
  //       return CredentialAlreadyInUse.tr;
  //     default:
  //       return UnexpectedError.tr;
  //   }
  // }
}
