import 'dart:developer';

import '../../../../core/networking/api_client.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/exception.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDate {
  Future getAllCategory();
}

class CategoryRemoteDateImplHttp implements CategoryRemoteDate {
  final ApiClent apiClent;

  CategoryRemoteDateImplHttp({required this.apiClent});
  @override
  Future<List<CategoryWithChannels>> getAllCategory() async {
    final resalt = await apiClent.getData(
        uri: ApiConstants.apiBaseUrl +
            ApiConstants.categories +
            ApiConstants.allCategoriesWithChannels);
    if (resalt.statusCode == 200) {
      final List<CategoryWithChannels> category =
          CategoryWithChannels.fromJsonList(resalt.body);
      return category;
    } else {
      log(resalt.body.toString());
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
