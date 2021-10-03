import 'dart:convert';

class SongArtist {
  final String name;
  final String? picture;
  SongArtist({
    required this.name,
    required this.picture,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'picture_medium': picture,
    };
  }

  factory SongArtist.fromMap(Map<String, dynamic> map) {
    return SongArtist(
      name: map['name'],
      picture: map['picture_medium'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SongArtist.fromJson(String source) =>
      SongArtist.fromMap(json.decode(source));
}
