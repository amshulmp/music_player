import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/playlistprovider.dart';
import 'package:music_player/utilities/box.dart';
import 'package:provider/provider.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Playlistprovider>(
      builder: (BuildContext context, value, Widget? child) {
        final playlist = value.playerplaylist;
        final currentsong = playlist[value.currentsongindex ?? 0];
        String formatDuration(Duration duration) {
          String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
          String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
          return '$minutes:$seconds';
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("N O W  P L A Y I N G"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Box(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            currentsong.imagepath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          currentsong.songName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(currentsong.artist),
                        trailing: IconButton(
                          onPressed: () {
                            // Implement favorite functionality
                          },
                          icon: const Icon(Icons.favorite),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(formatDuration(value.currentduration)),
                    IconButton(
                      onPressed: () {
                        // Implement shuffle functionality
                      },
                      icon: const Icon(Icons.shuffle),
                    ),
                    IconButton(
                      onPressed: () {
                      
                      },
                      icon: const Icon(Icons.repeat),
                    ),
                    Text(formatDuration(value.totalduration)),
                  ],
                ),
               Slider(
                      min: 0,
                      max: value.totalduration.inSeconds.toDouble(),
                      value:  value.currentduration.inSeconds.toDouble(),
                      activeColor: Colors.amber,
                      onChanged: (newValue) {
                      
                      },
                      onChangeEnd: (newValue) {
                        final newPosition = Duration(seconds: newValue.toInt());
                        value.seek(newPosition);
                      },
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Box(
                      child: IconButton(
                        onPressed: () {
                          value.previous();
                        },
                        icon: const Icon(Icons.skip_previous_rounded),
                      ),
                    ),
                    Box(
                      child: IconButton(
                        onPressed: () {
                          value.pauseorresume();
                        },
                        icon: Icon(value.isplaying
                            ? Icons.pause
                            : Icons.play_arrow),
                      ),
                    ),
                    Box(
                      child: IconButton(
                        onPressed: () {
                          value.playnext();
                        },
                        icon: const Icon(Icons.skip_next_rounded),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
        );
      },
    );
  }
}
