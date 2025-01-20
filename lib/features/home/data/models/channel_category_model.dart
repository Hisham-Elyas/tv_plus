import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

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

  @override
  bool operator ==(covariant ChannelCategory other) {
    if (identical(this, other)) return true;

    return other.categoryName == categoryName &&
        other.logo == logo &&
        listEquals(other.channels, channels);
  }

  @override
  int get hashCode => categoryName.hashCode ^ logo.hashCode ^ channels.hashCode;
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

  @override
  bool operator ==(covariant Channel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.logo == logo &&
        other.videoUrl == videoUrl;
  }

  @override
  int get hashCode => name.hashCode ^ logo.hashCode ^ videoUrl.hashCode;
}
