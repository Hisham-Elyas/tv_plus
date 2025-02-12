class CategoryWithChannels {
  final int categoryId;
  final String categoryName;
  final int count;
  final List<Channel> channels;

  CategoryWithChannels({
    required this.categoryId,
    required this.categoryName,
    required this.count,
    required this.channels,
  });

  factory CategoryWithChannels.fromJson(Map<String, dynamic> json) {
    return CategoryWithChannels(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      count: json['count'],
      channels: (json['channels'] as List<dynamic>)
          .map((channelJson) => Channel.fromJson(channelJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'count': count,
      'channels': channels.map((channel) => channel.toJson()).toList(),
    };
  }

  /// Converts a list of JSON objects into a list of CategoryWithChannels objects
  static List<CategoryWithChannels> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CategoryWithChannels.fromJson(json)).toList();
  }
}

class Channel {
  final int id;
  final int groupId;
  final String tvgId;
  final String tvgName;
  final String tvgLogo;
  final String name;
  final String url;
  final String createdAt;
  final String customName;

  Channel({
    required this.id,
    required this.groupId,
    required this.tvgId,
    required this.tvgName,
    required this.tvgLogo,
    required this.name,
    required this.url,
    required this.createdAt,
    required this.customName,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      groupId: json['group_id'],
      tvgId: json['tvg_id'],
      tvgName: json['tvg_name'],
      tvgLogo: json['tvg_logo'],
      name: json['name'],
      url: json['url'],
      createdAt: json['created_at'],
      customName: json['customName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'tvg_id': tvgId,
      'tvg_name': tvgName,
      'tvg_logo': tvgLogo,
      'name': name,
      'url': url,
      'created_at': createdAt,
      'customName': customName,
    };
  }
}
