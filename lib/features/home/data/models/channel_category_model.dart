class ChannelCategory {
  final String categoryName;
  final String logo; // New property for the logo
  final List<Channel> channels;

  ChannelCategory({
    required this.categoryName,
    required this.logo,
    required this.channels,
  });

  // Factory constructor to create a ChannelCategory from a map
  factory ChannelCategory.fromMap(String key, List<Map<String, String>> list) {
    List<Channel> channelList =
        list.map((map) => Channel.fromMap(map)).toList();
    String categoryLogo = channelList.isNotEmpty ? channelList.first.logo : '';

    return ChannelCategory(
      categoryName: key,
      logo: categoryLogo,
      channels: channelList,
    );
  }
}

class Channel {
  final String name;
  final String logo;
  final String videoUrl;

  Channel({
    required this.name,
    required this.logo,
    required this.videoUrl,
  });

  // Factory constructor to create a Channel from a map
  factory Channel.fromMap(Map<String, String> map) {
    return Channel(
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
    );
  }

  // Convert a Channel to a map
  Map<String, String> toMap() {
    return {
      'name': name,
      'logo': logo,
      'videoUrl': videoUrl,
    };
  }
}
