import 'package:get/get.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/enums.dart';
import '../data/models/category_model.dart';
import '../data/repos/category_repo.dart';

class CategoryController extends GetxController {
  final CategoryRepoImpHttp categoryRepo = Get.find();

  late StatusRequest statusReq;

  List<CategoryWithChannels> _categorys = [];

  @override
  void onInit() {
    getAllCategorys();
    super.onInit();
  }

  Future<void> getAllCategorys() async {
    statusReq = StatusRequest.loading;
    update();
    final resalt = await categoryRepo.getAllCategory();
    resalt.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      _categorys = r;
      statusReq = StatusRequest.success;
      update();
    });
  }

  List<CategoryWithChannels> get getCategorysList {
    if (statusReq == StatusRequest.loading) {
      return dummyListcategorys;
    } else {
      return _categorys;
    }
  }

  Future<List<CategoryWithChannels>> get getCategorys async {
    if (_categorys.isEmpty) {
      await getAllCategorys();
      return _categorys;
    } else {
      return _categorys;
    }
  }
}
