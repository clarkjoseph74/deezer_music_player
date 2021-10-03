part of 'artist_cubit.dart';

@immutable
abstract class ArtistState {}

class ArtistInitial extends ArtistState {}

class GetATracksLoading extends ArtistState {}

class GetATracksFailed extends ArtistState {}

class GetATracksSuccess extends ArtistState {}

class GetArtistsLoading extends ArtistState {}

class GetArtistsSuccess extends ArtistState {}

class GetArtistsFailed extends ArtistState {}

class GetTabTracksLoading extends ArtistState {}

class GetTabTracksSuccess extends ArtistState {}

class GetTabTracksFailed extends ArtistState {}
