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
        return 'Goals';
      case ScorerType.assists:
        return 'Assists';
      // case ScorerType.yellowCards:
      //   return 'Yellow Cards';
      // case ScorerType.redCards:
      //   return 'Red Cards';
    }
  }

  String get labelWithIcon {
    switch (this) {
      case ScorerType.goals:
        return '⚽ Goals';
      case ScorerType.assists:
        return '🎯 Assists';
      // case ScorerType.yellowCards:
      //   return '🟨 Yellow Cards';
      // case ScorerType.redCards:
      //   return '🟥 Red Cards';
    }
  }
}
