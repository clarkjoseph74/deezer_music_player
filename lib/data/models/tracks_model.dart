import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:music_dezeer/data/models/artist_song.dart';

class TrackModel {
  final String title;
  final int id;
  final String link;
  final String preview;
  final int duration;
  final SongArtist songArtist;
  IconData icon = Icons.play_arrow;

  TrackModel(
    this.title,
    this.id,
    this.link,
    this.preview,
    this.duration,
    this.songArtist,
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'link': link,
      'preview': preview,
      'duration': duration,
      'artist': songArtist.toMap(),
    };
  }

  factory TrackModel.fromMap(Map<String, dynamic> map) {
    return TrackModel(
      map['title'],
      map['id'],
      map['link'],
      map['preview'],
      map['duration'],
      SongArtist.fromMap(map['artist']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackModel.fromJson(String source) =>
      TrackModel.fromMap(json.decode(source));
}
