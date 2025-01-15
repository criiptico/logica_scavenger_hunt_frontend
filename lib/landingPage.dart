import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_register/handleForms.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});
  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const HandleForms(),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/Leaderboard'),
                  child: const Text("View Leaderboard")
              ),
              // For testing purposes only
              // ElevatedButton(
              //     onPressed: () => Navigator.pushNamed(context, '/StashLocations'),
              //     child: const Text("View Stash Locations")
              // ),
            ],
          )
      ),
    );
  }
}