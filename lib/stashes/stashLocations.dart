import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import 'package:logica_scavenger_hunt_frontend/stashes/stashDetails.dart';

class StashLocations extends StatefulWidget{
  const StashLocations({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _StashLocationsState();

}

class _StashLocationsState extends State<StashLocations> {
  List<StashDetails> _stashLocations = [];
  bool errorFlag = false;

  fetchLocations() async {
    try {
      var url = Uri.parse("http://10.0.2.2:3000/locations"); // Replace this url in production
      var response = await http.get(url);

      List<dynamic> jsonList = json.decode(response.body);
      List<Map<String, dynamic>> dataMapping = List<Map<String, dynamic>>.from(jsonList);
      errorFlag = false;

      if (response.statusCode == 200){
        setState(() {
          _stashLocations = StashDetails.fromJsonList(dataMapping);
        });
      }
      else {
        _stashLocations = [];
      }
    }
    catch (error) {
      print("Error: $error");
      _stashLocations = [];
      errorFlag = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column (children:[
        Container(height: 50,),
        Center(
          child: Container (
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(width: 5,),
              ),
              width: 300,
              height: 300,
              child: FlutterMap(
                  options: MapOptions(
                    maxBounds: LatLngBounds(const LatLng(41.860107, -87.685364), const LatLng(41.876706, -87.642458)),
                    initialCenter: const LatLng(41.870271, -87.662060),
                    initialZoom: 13.50,
                    maxZoom: 15, // Restricts how much a user can zoom in
                    // minZoom: 12,
                    // zoom: 3.2,
                    interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.pinchZoom | ~InteractiveFlag.drag),
                  ),
                  children: [
                    openStreetMapTileLayer,
                    markerTemplate,
                  ]
              )
          ),
        ),
        Container(height: 25,),
        Container(width: 250, height: 230, child: Center(child: submitStashes)),
        Container(height: 15,),
        errorFlag ? const Text("Error: Could not fetch stash locations.", style: TextStyle(color: Colors.red),) : Container(),
        Container(
          width: 370,
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/Leaderboard'),
                  child: const Text("View Leaderboard")
              ),
              Container(width: 10,),
              ElevatedButton(
                  onPressed: () => fetchLocations(),
                  child: const Text("Fetch Stash Locations")
              ),
            ],
          )
        )
      ])
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.example.app',
  );

  MarkerLayer get markerTemplate => MarkerLayer(
      markers: [
        for (var stash in _stashLocations) Marker(
            point: LatLng(stash.latitude, stash.longitude),
            width: 20,
            height: 20,
            child: Container(
              decoration: BoxDecoration(
                color: stash.found ? Colors.green : Colors.red,
                shape: BoxShape.circle
              ),
              child: Text(String.fromCharCode('A'.codeUnitAt(0) + stash.id - 1), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
            ),
        )
      ]
  );

  Widget get submitStashes => ListView.separated(
      itemBuilder: (BuildContext context, int index){
        return ExpansionTile(
          leading: _stashLocations[index].found ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank_sharp),
          title: Text(String.fromCharCode('A'.codeUnitAt(0) + _stashLocations[index].id - 1)),
          children: [
            Text("Latitude: ${_stashLocations[index].latitude}", textAlign: TextAlign.center,),
            Text("Longitude: ${_stashLocations[index].longitude}", textAlign: TextAlign.center,),
            Container(height: 10,),
            Text("'${_stashLocations[index].hint}'", textAlign: TextAlign.center, style: const TextStyle(fontStyle: FontStyle.italic),),
            Container(height: 10,),
            !_stashLocations[index].found ? TextButton(
                onPressed: () => Navigator.pushNamed(context, '/SubmitStash',
                arguments: _stashLocations[index]),
                child: Text("Submit Stash")
            ) : Text("Stash Found", style: const TextStyle(color: Colors.green),),
            Container(height: 10,),
          ],

        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: _stashLocations.length
  );


}