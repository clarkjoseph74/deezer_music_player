import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_dezeer/data/models/artist_model.dart';
import 'package:music_dezeer/data/models/tracks_model.dart';
import 'package:music_dezeer/data/repository/data_repository.dart';

part 'artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  ArtistCubit() : super(ArtistInitial()) {
    getArtists();
    getTabTracks();
  }
  static ArtistCubit get(BuildContext context) => BlocProvider.of(context);

  DataRepository _dataRepository = DataRepository.getInstance();
  List<ArtistModel> artists = [];
  getArtists() async {
    artists = [];
    emit(GetArtistsLoading());
    _dataRepository.getArtists().then((value) {
      value.forEach((element) {
        artists.add(element);
      });
      emit(GetArtistsSuccess());
    }).catchError((err) {
      print(err);
      emit(GetArtistsFailed());
    });
  }

  List<TrackModel> tracks = [];
  getArtistTracks({required String baseUrl}) async {
    tracks = [];
    emit(GetATracksLoading());

    await _dataRepository.getTracksOfAlbum(baseUrl: baseUrl).then((value) {
      print(value[0].title);
      value.forEach((track) {
        tracks.add(track);
      });
      emit(GetATracksSuccess());
    }).catchError((err) {
      print(err);
      emit(GetATracksFailed());
    });
  }

  List<TrackModel> tapTracks = [];
  getTabTracks() async {
    tapTracks = [];
    emit(GetTabTracksLoading());
    _dataRepository.getTracksTab().then((value) {
      value.forEach((element) {
        tapTracks.add(element);
      });
      print(tapTracks.length);
      emit(GetTabTracksSuccess());
    }).catchError((err) {
      print(err);
      emit(GetTabTracksFailed());
    });
  }
}
