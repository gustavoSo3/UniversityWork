part of 'music_recognition_bloc.dart';

@immutable
abstract class MusicRecognitionState {}

class MusicRecognitionInitial extends MusicRecognitionState {}

class Recording extends MusicRecognitionState {}

class LoadingSong extends MusicRecognitionState {}

class SongLoaded extends MusicRecognitionState {
  final Map<dynamic, dynamic> song_info;

  SongLoaded({required this.song_info});
  List<Object> get props => [this.song_info];
}

class Error extends MusicRecognitionState {}
