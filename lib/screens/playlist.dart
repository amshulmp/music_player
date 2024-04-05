import 'package:flutter/material.dart';
import 'package:music_player/models/playlistprovider.dart';
import 'package:music_player/models/songmodel.dart';
import 'package:music_player/utilities/drawer.dart';
import 'package:music_player/utilities/routes.dart';
import 'package:provider/provider.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return 
    
      Consumer<Playlistprovider>(
        builder: (BuildContext context, value, Widget? child) {

          final List<Song> playlist = value.playlist;
           final currentsong = playlist[value.currentsongindex ?? 0];
          return Scaffold(
              appBar: AppBar(
        title: const Text("S O N G S"),
      ),
      drawer: const MyDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (BuildContext context, int index) {
                  final Song track = playlist[index];
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ListTile(
                      
                      onTap: () {
                        Provider.of<Playlistprovider>(context, listen: false).currentsongindex = index;
                        Navigator.pushNamed(context, Routes.player);
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      tileColor: Theme.of(context).colorScheme.onError,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(track.imagepath),
                      ),
                      title: Text(track.songName),
                      subtitle: Text(track.artist),
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: value.currentsongindex!=null ? Container(
              color: Theme.of(context).colorScheme.secondary,

               height: MediaQuery.of(context).size.height*0.07,
             padding: const EdgeInsets.all(10),
             child: Row(
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 10),
                   child: GestureDetector(
                    onTap: () {
                       Navigator.pushNamed(context, Routes.player);
                    },
                     child: SizedBox(
                      
                      width: MediaQuery.of(context).size.width*0.57,
                       child: Text(
                        textAlign: TextAlign.left,
                                currentsong.songName,
                                style:  TextStyle(
                                    color: Theme.of(context).colorScheme.onError,
                                  fontWeight: FontWeight.bold,
                          
                                ),
                              ),
                     ),
                   ),
                 ),
                        IconButton(
                        onPressed: () {
                          value.previous();
                        },
                        icon:  Icon(Icons.skip_previous_rounded,
                          color: Theme.of(context).colorScheme.onError,),
                      ),
                       IconButton(
                        onPressed: () {
                          value.pauseorresume();
                        },
                        icon: Icon(value.isplaying
                            ? Icons.pause
                            : Icons.play_arrow,color:    Theme.of(context).colorScheme.onError,),
                      ),
                       IconButton(
                        onPressed: () {
                          value.playnext();
                        },
                        icon:  Icon(Icons.skip_next_rounded,
                          color: Theme.of(context).colorScheme.onError,),
                      ),

              ],
             ),
            ):null,
          );
        },
      );
 
  }
}
