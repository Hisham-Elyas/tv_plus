import 'package:get/utils.dart';

import '../localization/constants.dart';

enum StatusRequest {
  loading,
  success,

  serverFailure,
  emptyCache,
  // failure,
  // offLineFailure,
  noData,
  none
}

enum ScorerType {
  goals,
  assists,
  // yellowCards,
  // redCards,
}

extension ScorerTypeExtension on ScorerType {
  String get apiValue {
    switch (this) {
      case ScorerType.goals:
        return 'goals';
      case ScorerType.assists:
        return 'assists';
      // case ScorerType.yellowCards:
      //   return 'yellowCards';
      // case ScorerType.redCards:
      //   return 'redCards';
    }
  }

  String get label {
    switch (this) {
      case ScorerType.goals:
        return Goals.tr;
      case ScorerType.assists:
        return Assists.tr;
      // case ScorerType.yellowCards:
      //   return 'Yellow Cards';
      // case ScorerType.redCards:
      //   return 'Red Cards';
    }
  }

  String get labelWithIcon {
    switch (this) {
      case ScorerType.goals:
        return EmojiGoals.tr;
      case ScorerType.assists:
        return EmojiAssists.tr;
      // case ScorerType.yellowCards:
      //   return '🟨 Yellow Cards';
      // case ScorerType.redCards:
      //   return '🟥 Red Cards';
    }
  }
}
