import 'package:flutter/material.dart';
import 'package:music_player/utilities/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.playlist);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.music_note,
                      size: MediaQuery.of(context).size.height * 0.2,
                       color:  Theme.of(context).colorScheme.inversePrimary,
                    ),
                    Text(
                      "My Player",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                        color:  Theme.of(context).colorScheme.inversePrimary,
                      ),
                    )
                  ],
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          ),
        ));
  }
}
