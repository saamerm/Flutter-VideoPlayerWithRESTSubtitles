class VideoDetails {
  final String snippet;
  final String speaker;
  final double time;
VideoDetails._({this.snippet, this.speaker, this.time});
factory VideoDetails.fromJson(Map<String, dynamic> json) {
    return new VideoDetails._(
      snippet: json['snippet'],
      speaker: json['speaker'],
      time: json['time'],
    );
  }
}