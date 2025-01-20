// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(covariant ChannelAndCommentator other) {
    if (identical(this, other)) return true;

    return other.channel == channel && other.commentator == commentator;
  }

  @override
  int get hashCode => channel.hashCode ^ commentator.hashCode;
}
