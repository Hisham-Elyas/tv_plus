import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/helpers/check_internet.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/helpers/snackbar_error_message.dart';
import '../../../../core/networking/exception.dart';
import '../models/category_model.dart';
import '../remote/category_channel_remote_data.dart';

abstract class CategoryRepo {
  Future getAllCategory();
}

class CategoryRepoImpHttp implements CategoryRepo {
  final CategoryRemoteDateImplHttp categoryRemote;

  CategoryRepoImpHttp({required this.categoryRemote});
  @override
  Future<Either<StatusRequest, List<CategoryWithChannels>>>
      getAllCategory() async {
    if (await checkInternet()) {
      try {
        final remotData = await categoryRemote.getAllCategory();

        log('from Server  ==>  Get All Category With Channels');

        return right(remotData);
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return left(StatusRequest.serverFailure);
      }
    } else {
      showNetworkError();
      return left(StatusRequest.serverFailure);
    }
  }
}
