import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../core/helpers/check_internet.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/helpers/snackbar_error_message.dart';
import '../../../core/networking/exception.dart';
import '../models/login_model.dart';
import '../models/login_response_model.dart';
import '../models/sinup_model.dart';
import '../remote/auth_remotdata.dart';

abstract class AuthRepo {
  Future signUp({required SinupModel sinupModel});
  Future logIn({required LoginModel loginModel});
  Future logeOut();
}

class AuthRepoImpFirebase implements AuthRepo {
  final AuthRemotDataImpFirebase authRemotData;

  AuthRepoImpFirebase({required this.authRemotData});

  @override
  Future<bool> logeOut() async {
    return await authRemotData.logeOut();
  }

  @override
  Future<bool> signUp({required SinupModel sinupModel}) async {
    if (await checkInternet()) {
      return await authRemotData.signUp(sinupModel: sinupModel);
    } else {
      showNetworkError();

      return false;
    }
  }

  @override
  Future<bool> logIn({required LoginModel loginModel}) async {
    if (await checkInternet()) {
      return await authRemotData.logIn(loginModel: loginModel);
    } else {
      showNetworkError();
      return false;
    }
  }
}

class AuthRepoImpHttp implements AuthRepo {
  final AuthRemotDataImpHttp authRemotData;

  AuthRepoImpHttp({required this.authRemotData});
  @override
  Future<Either<StatusRequest, LoginResponseModel>> logIn(
      {required LoginModel loginModel}) async {
    if (await checkInternet()) {
      try {
        final response = await authRemotData.logIn(loginModel: loginModel);
        debugPrint("AuthRepoImpHttp");
        debugPrint(response.toString());
        return right(response);
      } on ServerException catch (e) {
        showErrorMessage(e.message);
        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }

  @override
  Future logeOut() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signUp({required SinupModel sinupModel}) async {
    if (await checkInternet()) {
      try {
        await authRemotData.signUp(sinupModel: sinupModel);
        return true;
      } on ServerException catch (e) {
        showErrorMessage(e.message);
        return false;
      }
    } else {
      showNetworkError();

      return false;
    }
  }
}
