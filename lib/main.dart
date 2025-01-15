import 'package:flutter/material.dart';
import 'package:logica_scavenger_hunt_frontend/stashes/submitStash.dart';
import 'package:logica_scavenger_hunt_frontend/stashes/stashLocations.dart';
import 'landingPage.dart';
import 'leaderboard/leaderboard.dart';
// import 'package:moon_design/moon_design.dart';


void main() {
  runApp(const StashScavengerHuntApp());
}

class StashScavengerHuntApp extends StatelessWidget {
  const StashScavengerHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGICA Stash Scavenger Hunting App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LandingPage(title: 'LOGICA Stash Scavenger Hunt'),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(title: 'LOGICA Stash Scavenger Hunt'),
        '/Leaderboard': (context) => const Leaderboard(title: 'Leaderboard'),
        // '/ControlPanel': (context) => const ControlPanel(title: 'Control Panel'),
        '/StashLocations': (context) => const StashLocations(title: 'Stash Locations'),
        '/SubmitStash': (context) => const SubmitStash(title: 'Submit Stash'),
      }
    );
  }
}


