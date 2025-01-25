import 'package:get/get.dart';

import 'constants.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {
          Home: Home,
          Language: Language,
          Select_language: Select_language,
        },
        "ar": {
          Home: "الصفحة الرئيسية",
          Language: "اللغة",
          Select_language: 'اختر اللغة',
        },
      };
}
