class Photo {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photo(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'albumId': int albumId,
        'id': int id,
        "title": String title,
        "url": String url,
        "thumbnailUrl": String thumbnailUrl
      } =>
        Photo(
            albumId: albumId,
            id: id,
            title: title,
            url: url,
            thumbnailUrl: thumbnailUrl),
      _ => throw const FormatException('Não foi possível carregar esta foto')
    };
  }
}
