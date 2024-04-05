// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_player/models/songmodel.dart';

class Playlistprovider extends ChangeNotifier {
  int? _currentsongindex;
  final _audioPlayer = AudioPlayer();
  Duration _currentduration = Duration.zero;
  Duration _totalduration = Duration.zero;
  bool _isplaying = false;

  Playlistprovider() {
    listenduration();
    automaticallyAddAudioFiles(); 
  }

  void automaticallyAddAudioFiles() {
    try {
      List<String> audioExtensions = ['mp3', 'm4a', 'wav', 'aac', 'flac'];
      List<String> directoriesToSearch = [
        '/storage/emulated/0/Music',
        '/storage/emulated/0/Download',
      ];

      for (String dirPath in directoriesToSearch) {
        Directory directory = Directory(dirPath);

        if (directory.existsSync()) {
          List<FileSystemEntity> entities = directory.listSync(recursive: true);
          for (FileSystemEntity entity in entities) {
            if (entity is File &&
                audioExtensions.any((ext) => entity.path.toLowerCase().endsWith(ext))) {
              playlist.add(Song(
                songName: entity.path.split('/').last,
                artist: "Unknown Artist",
                imagepath: "assets/default_image.jpg", 
                songpath: entity.path,
              ));
            }
          }
        } else {
          print('Directory not found: $dirPath');
        }
      }

      notifyListeners();
    } catch (e) {
      print("Error adding audio files: $e");
    }
  }


  dynamic play() async {
    final String path = playerplaylist[_currentsongindex!].songpath;
    await _audioPlayer.stop();
    await _audioPlayer.play(DeviceFileSource(path));
    _isplaying = true;
    notifyListeners();
  }

  dynamic pause() async {
    await _audioPlayer.pause();
    _isplaying = false;
    notifyListeners();
  }

  dynamic resume() async {
    await _audioPlayer.resume();
    _isplaying = true;
    notifyListeners();
  }

  void pauseorresume() async {
    if (_isplaying) {
      await pause();
    } else {
      await resume();
    }
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playnext() {
    if (_currentsongindex != null) {
      if (_currentsongindex! < playerplaylist.length - 1) {
        currentsongindex = _currentsongindex! + 1;
      } else {
        currentsongindex = 0;
      }
    }
  }

  void previous() {
    if (_currentduration.inSeconds > 2) {
      seek(Duration.zero); 
    } else {
      if (_currentsongindex! > 0) {
        currentsongindex = _currentsongindex! - 1;
      } else {
        currentsongindex = playerplaylist.length - 1;
      }
    }
  }

 void listenduration() {
  _audioPlayer.onDurationChanged.listen((newduration) {
    _totalduration = newduration;
    notifyListeners();
  });

  _audioPlayer.onPositionChanged.listen((newposition) {
    _currentduration = newposition;
    notifyListeners();
  });

  _audioPlayer.onPlayerStateChanged.listen((state) {
    if (state == PlayerState.completed) {
      playnext();
      notifyListeners();
    }
  });
}

  final List<Song> playlist = [];

  List<Song> get playerplaylist => playlist;

  int? get currentsongindex => _currentsongindex;

  bool get isplaying => _isplaying;

  Duration get currentduration => _currentduration;

  Duration get totalduration => _totalduration;

  set currentsongindex(int? newindex) {
    _currentsongindex = newindex;
    if (newindex != null) {
      play();
    }
    notifyListeners();
  }
}
