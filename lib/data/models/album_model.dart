import 'dart:convert';

import 'package:music_dezeer/data/models/artist_model.dart';

class AlbumModel {
  final String title;
  final int id;
  final String cover;
  final String type;
  final int position;
  final String tracklist;
  final ArtistModel artist;

  AlbumModel(this.title, this.id, this.cover, this.type, this.position,
      this.tracklist, this.artist);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'cover_medium': cover,
      'type': type,
      'position': position,
      'tracklist': tracklist,
      'artist': artist.toMap(),
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      map['title'],
      map['id'],
      map['cover_medium'],
      map['type'],
      map['position'],
      map['tracklist'],
      ArtistModel.fromMap(map['artist']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumModel.fromJson(String source) =>
      AlbumModel.fromMap(json.decode(source));
}
