import 'package:dio/dio.dart';
import 'package:music_dezeer/constants.dart';
import 'package:music_dezeer/data/models/album_model.dart';
import 'package:music_dezeer/data/models/artist_model.dart';
import 'package:music_dezeer/data/models/tracks_model.dart';

class DataRepository {
  late Dio dio;
  static DataRepository? instance = DataRepository();
  DataRepository() {
    dio = Dio(BaseOptions(
      baseUrl: BASE_URl,
      receiveDataWhenStatusError: true,
    ));
  }

  static getInstance() {
    return instance;
  }

  Future<List<AlbumModel>> getAlbums() async {
    List<AlbumModel> albums = [];
    await dio
        .get(
      ALBUMS_URL,
    )
        .then((value) {
      value.data['data'].forEach((album) {
        albums.add(AlbumModel.fromMap(album));
      });
    });
    return albums;
  }

  Future<List<TrackModel>> getTracksOfAlbum({required String baseUrl}) async {
    Dio dioHere =
        Dio(BaseOptions(baseUrl: baseUrl, receiveDataWhenStatusError: true));
    List<TrackModel> tracks = [];

    await dioHere.get('').then((value) {
      print(value.data['data'].length);
      List<dynamic> res = value.data['data'];
      res.forEach((element) {
        tracks.add(TrackModel.fromMap(element));
        print(tracks.length);
      });
      print(tracks.length);
    });
    return tracks;
  }

  Future<List<ArtistModel>> getArtists() async {
    List<ArtistModel> artists = [];
    await dio
        .get(
      ARTISTS_URL,
    )
        .then((value) {
      value.data['data'].forEach((artist) {
        print(artist);
        artists.add(ArtistModel.fromMap(artist));
      });
    });
    return artists;
  }

  Future<List<TrackModel>> getTracksTab() async {
    List<TrackModel> tracks = [];
    await dio
        .get(
      TRACKS_URL,
    )
        .then((value) {
      value.data['data'].forEach((track) {
        tracks.add(TrackModel.fromMap(track));
      });
    });
    return tracks;
  }
}
