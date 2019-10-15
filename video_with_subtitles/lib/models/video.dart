class Video {
  final String title;
  final String thumbnail;
  final String id;
Video._({this.title, this.thumbnail, this.id});
factory Video.fromJson(Map<String, dynamic> json) {
    return new Video._(
      title: json['title'],
      thumbnail: json['thumbnail'],
      id: json['id'],
    );
  }
}