import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logica_scavenger_hunt_frontend/stashes/stashDetails.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class SubmitStash extends StatefulWidget{
  const SubmitStash({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _SubmitStashState();

}

class _SubmitStashState extends State<SubmitStash> {
  bool submitting = false;
  late bool stashFound = false; // This would be reflected as such the response from the server

  void readNFC() {
    print("Reading NFC...");
    setState(() {
      submitting = !submitting; // if submitting is true, loading wheel appears
      stashFound = !stashFound; // When this is true, display the Stash Found text or display an invalid error
      submitting = !submitting; // Loading wheel disappears
    });
  }


  @override
  Widget build(BuildContext context) {
    final submittingStash = ModalRoute.of(context)!.settings.arguments as StashDetails;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column (
          children: [
            Container(height: 50,),
            Text("Tap the NFC button once the NFC tag is placed directly under your phone.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Container(height: 10,),
            submitting ?
            Column(
              children: [
                Container(height: 100,),
                LoadingAnimationWidget.twoRotatingArc(color: Colors.deepPurple, size: 100),
                Container(height: 100,),
                Text("Submitting Stash ${String.fromCharCode(submittingStash.id + 64)}...")
              ],
            )
             : IconButton(
              onPressed: readNFC,
              icon: Icon(Icons.nfc),
              iconSize: 250,
            ),
            stashFound ? Text("Stash Found", style: TextStyle(color: Colors.green),) : Text(""),

          ],
        )
    );
  }
}