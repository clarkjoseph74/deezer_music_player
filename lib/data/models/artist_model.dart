import 'dart:convert';

class ArtistModel {
  final String name;
  final int id;
  final String picture;
  final String type;
  final String tracks;
  ArtistModel({
    required this.name,
    required this.id,
    required this.picture,
    required this.type,
    required this.tracks,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'picture_medium': picture,
      'type': type,
      'tracklist': tracks,
    };
  }

  factory ArtistModel.fromMap(Map<String, dynamic> map) {
    return ArtistModel(
      name: map['name'],
      id: map['id'],
      picture: map['picture_medium'],
      type: map['type'],
      tracks: map['tracklist'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ArtistModel.fromJson(String source) =>
      ArtistModel.fromMap(json.decode(source));
}
