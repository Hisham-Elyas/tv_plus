// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../core/exceptions/format_exceptions.dart';
import '../../../core/exceptions/platform_exceptions.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/networking/api_client.dart';
import '../../../core/networking/api_constants.dart';
import '../../home/controllers/category_controller.dart';
import '../models/login_model.dart';
import '../models/sinup_model.dart';
import '../models/user_model.dart';

abstract class AuthRemotData {
  Future signUp({required SinupModel sinupModel});
  Future logIn({required LoginModel loginModel});
  Future<UserModel> getUserInfo();
  Future<bool> updateUserInfo({required UserModel userModel});
  Future<bool> logeOut();
  Future<bool> forgotPassword({required String email});
  Future<bool> resetPasswordWOtp(
      {required String newPassword,
      required String otp,
      required String email});

  Future<bool> updateEmail({required String newEmail});
  Future<bool> updatePassword({required String newPassword});
  Future<bool> deleteAccount();
}

class AuthRemotDataImpHttp extends GetxController implements AuthRemotData {
  final ApiClent apiClent;

  bool get isAuthenticated => !_isExpired;
  bool _isExpired = true;
  String token = '';
  bool get isExpired => _isExpired;
  int? userId;
  @override
  void onInit() async {
    // get token from shared preferences
    await SharedPrefHelper.getString('TOKEN').then((value) {
      token = value;
      // debugPrint("Token: $token");
    });
    if (token.isNotEmpty) {
      _isExpired = Jwt.isExpired(token);
      final DateTime? expiryDate = Jwt.getExpiryDate(token);
      debugPrint("expiryDate: $expiryDate");
    }
    if (_isExpired) {
      token = '';
      debugPrint("Token is expired: $_isExpired");
      SharedPrefHelper.removeData('TOKEN');
      SharedPrefHelper.removeData('user_info');
      SharedPrefHelper.removeData('user_id');
    } else {
      debugPrint("Token is not expired: $_isExpired");
      Get.find<CategoryController>();
      SharedPrefHelper.getInt('user_id').then((value) {
        debugPrint("User ID: $value");
        userId = value;
      });
    }

    super.onInit();
  }

  AuthRemotDataImpHttp({required this.apiClent});

  @override
  Future<bool> signUp({required SinupModel sinupModel}) async {
    try {
      final response = await apiClent.postData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.registerEndpoint,
        body: {
          "username": sinupModel.userName,
          "email": sinupModel.email,
          "password": sinupModel.password,
          // "phone": sinupModel.phone,
          // "phone": sinupModel.phone,
        },
      );
      print(response.body);

      if (response.statusCode == 201) {
        // save user data in shared preferences
        UserModel userModel = UserModel(
          //  phone: sinupModel.phone,
          email: sinupModel.email,
          userName: sinupModel.userName,
          userId: response.body['userId'].toString(),
        );
        await SharedPrefHelper.setData('user_info', userModel.toMap());
        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to sign up.';
        }
        final data = response.body as Map<String, dynamic>;
        // print(data);
        String message = data['error'] ?? 'Failed to sign up.';
        // print(message);
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<bool> logIn({required LoginModel loginModel}) async {
    try {
      final response = await apiClent.postData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.loginEndpoint,
        body: {
          "email": loginModel.email,
          "password": loginModel.password,
        },
      );
      if (response.statusCode == 200) {
        token = response.body['token'];
        await SharedPrefHelper.setData('TOKEN', response.body['token']);

        final tokendata = Jwt.parseJwt(response.body['token']);
        debugPrint("Token Data: $tokendata");
        // save user data in shared preferences
        await SharedPrefHelper.setData('user_id', tokendata['userId']);

        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to log in.';
        }
        // print(response.body);
        final data = response.body as Map<String, dynamic>;
        // print(data);
        // print(data.toString());
        String message = data['error']?.toString() ?? 'Failed to log in.';
        print(message);
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<bool> updateUserInfo({required UserModel userModel}) async {
    try {
      final response = await apiClent.putData(
        uri:
            '${ApiConstants.apiBaseUrl + ApiConstants.updateUserDetailsEndpoint}/${userModel.userId}',
        body: {
          "username": userModel.userName,
          // "phone": userModel.phone,
          // "phone": userModel.phone,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        print("User Model: ${userModel.toMap()}");
        // save user data in shared preferences
        await SharedPrefHelper.setData('user_info', userModel.toMap());
        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to update user info.';
        }
        final data = response.body as Map<String, dynamic>;
        String message = data['error'] ?? 'Failed to update user info.';
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<bool> updatePassword({required String newPassword}) async {
    try {
      final response = await apiClent.putData(
        uri:
            '${ApiConstants.apiBaseUrl + ApiConstants.updateUserPasswordEndpoint}/$userId',
        body: {'password': newPassword},
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to update password.';
        }
        final data = response.body as Map<String, dynamic>;
        String message = data['error'] ?? 'Failed to update password.';
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<bool> updateEmail({required String newEmail}) async {
    try {
      final response = await apiClent.putData(
        uri:
            '${ApiConstants.apiBaseUrl + ApiConstants.updateUserEmailEndpoint}/$userId',
        body: {'email': newEmail},
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to update email.';
        }
        final data = response.body as Map<String, dynamic>;
        String message = data['error'] ?? 'Failed to update email.';
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      final response = await apiClent.deleteData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.sendResetOtp,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        token = '';
        SharedPrefHelper.removeData('TOKEN');
        SharedPrefHelper.removeData('user_info');
        SharedPrefHelper.removeData('user_id');
        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to delete account.';
        }
        final data = response.body as Map<String, dynamic>;
        String message = data['error'] ?? 'Failed to delete account.';
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<UserModel> getUserInfo() async {
    try {
      if (userId == null) {
        await SharedPrefHelper.getInt('user_id').then((value) {
          debugPrint("User ID: $value");
          userId = value;
        });
      }
      final response = await apiClent.getData(
        uri:
            '${ApiConstants.apiBaseUrl + ApiConstants.getUserDataEndpoint}/$userId',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return UserModel(
            email: response.body["user"]['email'],
            userName: response.body["user"]['username'],
            // phone: response.body["user"]['phone'],
            userId: response.body["user"]['id'].toString());
      } else {
        if (response.body == null) {
          throw 'Failed to fetch user info.';
        }
        final data = response.body as Map<String, dynamic>;
        String message = data['error'] ?? 'Failed to fetch user info.';
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again.";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<bool> logeOut() async {
    try {
      token = '';
      SharedPrefHelper.removeData('TOKEN');
      SharedPrefHelper.removeData('user_info');
      SharedPrefHelper.removeData('user_id');
      return true;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw "Someting went weong. pleas try agin.";
    }
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    try {
      final response = await apiClent.postData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.sendResetOtp,
        body: {'email': email},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to send password reset email.';
        }
        final data = response.body as Map<String, dynamic>;
        String message =
            data['error'] ?? 'Failed to send password reset email.';
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again.";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<bool> resetPasswordWOtp(
      {required String newPassword,
      required String otp,
      required String email}) async {
    try {
      final response = await apiClent.postData(
        uri: ApiConstants.apiBaseUrl + ApiConstants.sendResetOtp,
        body: {"email": email, "otp": otp, "newPassword": newPassword},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        if (response.body == null) {
          throw 'Failed to send password reset email.';
        }
        final data = response.body as Map<String, dynamic>;
        String message =
            data['error'] ?? 'Failed to send password reset email.';
        throw message;
      }
    } on TimeoutException {
      throw "Request timed out, please try again.";
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      print(e.toString());
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}

// class AuthRemotDataImpFirebase implements AuthRemotData {
//   late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   late final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   @override
//   Future<UserModel> getUserInfo() async {
//     try {
//       DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseAuth.currentUser!.uid)
//           .get();

//       if (documentSnapshot.exists) {
//         Map<String, dynamic> data =
//             documentSnapshot.data() as Map<String, dynamic>;

//         // Access user_info map
//         Map<String, dynamic> userInfo = data['user_info'];

//         print("User Name: ${userInfo['name']}");
//         print("User Email: ${userInfo['email']}");
//       } else {
//         print("User not found");
//       }

//       final doc = await firebaseFirestore
//           .collection('users')
//           .doc(firebaseAuth.currentUser!.uid)
//           .get();

//       if (!doc.exists) {
//         showCustomSnackBar(
//             message: UserDataNotFound.tr,
//             title: UserInfoError.tr,
//             isError: true);
//         throw "User data not found.";
//       }
//       final userval = doc.data()!['user_info'];
//       await SharedPrefHelper.setData('user_info', jsonEncode(userval));
//       return UserModel.fromMap(userval);
//     } on FirebaseAuthException catch (e) {
//       throw HFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw HFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const HFormatException();
//     } on PlatformException catch (e) {
//       throw HPlatformException(e.code).message;
//     } catch (e) {
//       throw "Someting went weong. pleas try agin";
//     }
//   }

//   @override
//   Future<bool> logIn({required LoginModel loginModel}) async {
//     try {
//       await firebaseAuth.signInWithEmailAndPassword(
//         email: loginModel.email,
//         password: loginModel.password,
//       );

//       return true;
//     } on FirebaseAuthException catch (e) {
//       throw HFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw HFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const HFormatException();
//     } on PlatformException catch (e) {
//       throw HPlatformException(e.code).message;
//     } catch (e) {
//       throw "Someting went weong. pleas try agin";
//     }
//   }

//   @override
//   Future<bool> logeOut() async {
//     try {
//       await firebaseAuth.signOut();
//       showCustomSnackBar(
//         message: LoggedOutSuccessfully.tr,
//         title: Success.tr,
//         isError: false,
//       );
//       await SharedPrefHelper.removeData('user_info');
//       return true;
//     } catch (e) {
//       showCustomSnackBar(
//         message: FailedToLogOut.tr,
//         title: LogoutError.tr,
//         isError: true,
//       );
//       return false;
//     }
//   }

//   @override
//   Future<bool> signUp({required SinupModel sinupModel}) async {
//     try {
//       final UserCredential userCredential =
//           await firebaseAuth.createUserWithEmailAndPassword(
//               email: sinupModel.email, password: sinupModel.password);

//       final UserModel userModel = UserModel(
//           phone: sinupModel.phone,
//           email: sinupModel.email,
//           userName: sinupModel.userName,
//           userId: userCredential.user!.uid);

//       await firebaseFirestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set({'user_info': userModel.toMap()}, SetOptions(merge: true));

//       await SharedPrefHelper.setData(
//           'user_info', jsonEncode(userModel.toMap()));

//       showCustomSnackBar(
//         message: AccountCreatedSuccessfully.tr,
//         title: SignUpSuccess.tr,
//         isError: false,
//       );

//       return true;
//     } on FirebaseAuthException catch (e) {
//       print(e.toString());
//       throw HFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       print(e.toString());
//       throw HFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const HFormatException();
//     } on PlatformException catch (e) {
//       print(e.toString());
//       throw HPlatformException(e.code).message;
//     } catch (e) {
//       print(e.toString());
//       throw "Someting went weong. pleas try agin";
//     }
//   }

//   @override
//   Future<bool> updateEmail({required String newEmail}) async {
//     try {
//       User? user = firebaseAuth.currentUser;
//       if (user == null) {
//         showCustomSnackBar(
//           message: NoUserSignedIn.tr,
//           title: AuthError.tr,
//           isError: true,
//         );
//         return false;
//       }

//       if (!user.emailVerified) {
//         showCustomSnackBar(
//           message: VerifyEmailBeforeUpdate.tr,
//           title: VerificationRequired.tr,
//           isError: true,
//         );
//         await Future.delayed(
//           const Duration(seconds: 3),
//           () async {
//             await resendEmailVerification();
//           },
//         );
//         return false;
//       }

//       await user.updateEmail(newEmail);
//       await firebaseFirestore
//           .collection('users')
//           .doc(user.uid)
//           .update({'user_info.email': newEmail});

//       showCustomSnackBar(
//         message: EmailUpdatedSuccessfully.tr,
//         title: UpdateSuccess.tr,
//         isError: false,
//       );

//       return true;
//     } on FirebaseAuthException catch (e) {
//       throw HFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw HFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const HFormatException();
//     } on PlatformException catch (e) {
//       throw HPlatformException(e.code).message;
//     } catch (e) {
//       throw "Someting went weong. pleas try agin";
//     }
//   }

//   @override
//   Future<bool> updatePassword(
//       {required String oldPassword, required String newPassword}) async {
//     try {
//       User? user = firebaseAuth.currentUser;
//       if (user == null || user.email == null) {
//         showCustomSnackBar(
//           message: NoUserSignedIn.tr,
//           title: AuthError.tr,
//           isError: true,
//         );
//         return false;
//       }

//       if (!user.emailVerified) {
//         showCustomSnackBar(
//           message: VerifyEmailBeforePasswordUpdate.tr,
//           title: VerificationRequired.tr,
//           isError: true,
//         );
//         await Future.delayed(
//           const Duration(seconds: 3),
//           () async {
//             await resendEmailVerification();
//           },
//         );
//         return false;
//       }

//       AuthCredential credential = EmailAuthProvider.credential(
//         email: user.email!,
//         password: oldPassword,
//       );

//       await user.reauthenticateWithCredential(credential);
//       await user.updatePassword(newPassword);

//       showCustomSnackBar(
//         message: PasswordUpdatedSuccessfully.tr,
//         title: Success.tr,
//         isError: false,
//       );

//       return true;
//     } on FirebaseAuthException catch (e) {
//       throw HFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw HFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const HFormatException();
//     } on PlatformException catch (e) {
//       throw HPlatformException(e.code).message;
//     } catch (e) {
//       throw "Someting went weong. pleas try agin";
//     }
//   }

//   @override
//   Future<bool> forgotPassword({required String email}) async {
//     try {
//       await firebaseAuth.sendPasswordResetEmail(email: email);

//       showCustomSnackBar(
//         message: PasswordResetLinkSent.tr,
//         title: ResetPassword.tr,
//         isError: false,
//       );

//       return true;
//     } on FirebaseAuthException catch (e) {
//       throw HFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw HFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const HFormatException();
//     } on PlatformException catch (e) {
//       throw HPlatformException(e.code).message;
//     } catch (e) {
//       throw "Someting went weong. pleas try agin";
//     }
//   }

//   Future<void> resendEmailVerification() async {
//     User? user = firebaseAuth.currentUser;
//     if (user != null && !user.emailVerified) {
//       await user.sendEmailVerification();
//       showCustomSnackBar(
//         message: VerificationEmailSent.tr,
//         title: EmailSent.tr,
//         isError: false,
//       );
//     } else {
//       showCustomSnackBar(
//         message: AlreadyVerified.tr,
//         title: AlreadyVerifiedTitle.tr,
//         isError: false,
//       );
//     }
//   }

//   @override
//   Future<bool> updateUserInfo({required UserModel userModel}) async {
//     try {
//       User? user = firebaseAuth.currentUser;
//       if (user == null) {
//         showCustomSnackBar(
//           message: NoUserSignedIn.tr,
//           title: AuthError.tr,
//           isError: true,
//         );
//         return false;
//       }

//       // Update Firestore user data
//       await firebaseFirestore.collection('users').doc(userModel.userId).update({
//         'user_info': userModel.toMap(),
//       });

//       // Optionally, update shared preferences or other local storage
//       await SharedPrefHelper.setData(
//           'user_info', jsonEncode(userModel.toMap()));
//       showCustomSnackBar(
//         message: UserInfoUpdatedSuccessfully.tr,
//         title: UpdateSuccess.tr,
//         isError: false,
//       );

//       return true;
//     } catch (e) {
//       log(e.toString());
//       showCustomSnackBar(
//         message: FailedToUpdateUserInfo.tr,
//         title: UpdateError.tr,
//         isError: true,
//       );
//       return false;
//     }
//   }

//   @override
//   Future<bool> deleteAccount() async {
//     try {
//       User? user = firebaseAuth.currentUser;
//       if (user == null) {
//         showCustomSnackBar(
//           message: NoUserSignedIn.tr,
//           title: AuthError.tr,
//           isError: true,
//         );
//         return false;
//       }

//       // Delete user data from Firestore
//       await firebaseFirestore.collection('users').doc(user.uid).delete();

//       // Delete the user account from Firebase Authentication
//       await user.delete();
//       SharedPrefHelper.removeData('user_info');

//       showCustomSnackBar(
//         message: AccountDeletedSuccessfully.tr,
//         title: Success.tr,
//         isError: false,
//       );

//       return true;
//     } on FirebaseAuthException catch (e) {
//       throw HFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw HFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const HFormatException();
//     } on PlatformException catch (e) {
//       throw HPlatformException(e.code).message;
//     } catch (e) {
//       throw "Someting went weong. pleas try agin";
//     }
//   }
// }
