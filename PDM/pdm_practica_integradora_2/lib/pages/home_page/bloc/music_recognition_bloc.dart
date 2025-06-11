import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica_2/secrets.dart';
import 'package:record/record.dart';

part 'music_recognition_event.dart';
part 'music_recognition_state.dart';

class MusicRecognitionBloc
    extends Bloc<MusicRecognitionEvent, MusicRecognitionState> {
  MusicRecognitionBloc() : super(MusicRecognitionInitial()) {
    on<RecordSong>(_recodSong);
  }
  FutureOr<void> _recodSong(event, emit) async {
    final record = Record();
    bool canRecord = await record.hasPermission();
    if (canRecord) {
      Directory tempDir = await getTemporaryDirectory();
      await record.start(path: tempDir.path + "/nose.m4a");
      emit(Recording());
      await Future.delayed(
        const Duration(seconds: 10),
        () async {
          await record.stop();
        },
      );
      emit(LoadingSong());
      File recording = await File(tempDir.path + "/nose.m4a");
      Uint8List recodingBytes = await recording.readAsBytes();
      String base64recording = base64.encode(recodingBytes);
      var response = await http.post(
        Uri.parse('https://api.audd.io/'),
        body: jsonEncode(<String, String>{
          'api_token': AUDD_API_TOKEN,
          'audio': base64recording,
          'return': 'apple_music,spotify',
        }),
      );
      final Map response_parsed = json.decode(utf8.decode(response.bodyBytes));
      if (response_parsed["status"] == "error") {
        emit(Error());
      } else {
        emit(SongLoaded(song_info: response_parsed));
      }
      emit(MusicRecognitionInitial());
    }
  }
}
