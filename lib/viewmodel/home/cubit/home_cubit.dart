import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:meta/meta.dart';
import 'package:music_dezeer/data/models/album_model.dart';
import 'package:music_dezeer/data/models/tracks_model.dart';
import 'package:music_dezeer/data/repository/data_repository.dart';
import 'package:music_dezeer/view/b_nav_screens/album_screen.dart';
import 'package:music_dezeer/view/b_nav_screens/artists_screen.dart';
import 'package:music_dezeer/view/b_nav_screens/tracks_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    getALbums();
    playerInit();
  }

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  List<Widget> pages = [
    AlbumScreen(),
    ArtistsScreen(),
    TracksScreen(),
  ];
  int currentPage = 0;
  changePage(int index) {
    currentPage = index;
    emit(ChangePageState());
  }

  var _dataRepository = DataRepository.getInstance();
  List<AlbumModel> albums = [];
  getALbums() async {
    emit(GetAlbumsLoading());

    await _dataRepository.getAlbums().then((value) {
      print(value[0].title);
      value.forEach((album) {
        albums.add(album);
      });
      emit(GetAlbumsSuccess());
    }).catchError((err) {
      print(err);
      emit(GetAlbumsFailed());
    });
  }

  List<TrackModel> tracks = [];
  getAlbumTracks({required String baseUrl}) async {
    tracks = [];
    emit(GetTracksLoading());

    await _dataRepository.getTracksOfAlbum(baseUrl: baseUrl).then((value) {
      print(value[0].title);
      value.forEach((track) {
        tracks.add(track);
      });
      emit(GetTracksSuccess());
    }).catchError((err) {
      print(err);
      emit(GetTracksFailed());
    });
  }

  FlutterSoundPlayer? _audioPlayer;
  playerInit() {
    _audioPlayer = FlutterSoundPlayer();
    _audioPlayer!.openAudioSession();
  }

  playerDespose() {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future _playMusic(
      {required String url, required VoidCallback whenFinshed}) async {
    isPlaying = true;
    await _audioPlayer!
        .startPlayer(fromURI: url, codec: Codec.mp3, whenFinished: whenFinshed);
    emit(PlayingMusic());
  }

  Future _stopMusic() async {
    isPlaying = false;
    await _audioPlayer!.stopPlayer();
    emit(StopingMusic());
  }

  bool isPlaying = false;
  Future togglrPlayer({required String url, required TrackModel track}) async {
    if (_audioPlayer!.isStopped) {
      await _playMusic(
          url: url,
          whenFinshed: () {
            track.icon = Icons.play_arrow;
            emit(StopingMusic());
          });
      track.icon = Icons.pause;
      emit(PlayingMusic());
    } else {
      await _stopMusic();
      track.icon = Icons.play_arrow;
      emit(StopingMusic());
    }
  }

  @override
  Future<void> close() async {
    playerDespose();
    await _stopMusic();
    return super.close();
  }
}
