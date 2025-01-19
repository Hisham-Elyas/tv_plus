class ChannelAndCommentator {
  final String channel;
  final String commentator;

  ChannelAndCommentator({
    required this.channel,
    required this.commentator,
  });

  factory ChannelAndCommentator.fromJson(Map<String, dynamic> json) {
    return ChannelAndCommentator(
      channel: json['Channel'] ?? '',
      commentator: json['Commentator'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Channel': channel,
      'Commentator': commentator,
    };
  }
}
