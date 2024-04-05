import 'package:flutter/material.dart';
import 'package:music_player/models/playlistprovider.dart';
import 'package:music_player/screens/player.dart';
import 'package:music_player/screens/playlist.dart';
import 'package:music_player/screens/settings.dart';
import 'package:music_player/screens/splash.dart';
import 'package:music_player/utilities/routes.dart';
import 'package:music_player/utilities/sharedpreference.dart';
import 'package:music_player/utilities/themeprovider.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDarkMode = await SharedPreferencesHelper.getmodeStatus();

  runApp(
  MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => Themeprovider(initialDarkMode: isDarkMode),),
      ChangeNotifierProvider(create: (context)=>Playlistprovider(),)
  ],
   child: const Root(),)
  );
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      theme: Provider.of<Themeprovider>(context).themeData,
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.player: (context) => const Player(),
        Routes.playlist: (context) => const PlayList(),
        Routes.settings: (context) => const Settings(), 
      },
    );
  }
}
