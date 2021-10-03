part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangePageState extends HomeState {}

class GetAlbumsLoading extends HomeState {}

class GetAlbumsSuccess extends HomeState {}

class GetAlbumsFailed extends HomeState {}

class GetTracksLoading extends HomeState {}

class GetTracksSuccess extends HomeState {}

class GetTracksFailed extends HomeState {}

class PlayingMusic extends HomeState {}

class StopingMusic extends HomeState {}
