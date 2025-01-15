import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'leaderboardDetails.dart';

import 'package:http/http.dart' as http;

class Leaderboard extends StatefulWidget{
  const Leaderboard({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _LeaderboardState();

}

class _LeaderboardState extends State<Leaderboard> {
  List<LeaderboardDetails> _leaderBoardData = [];
  // String rawLeaderboardData = "";
  bool errorFlag = false;

  fetchLeaderboard() async {
    try {
      var url = Uri.parse("http://10.0.2.2:3000/leaderboard"); // Replace this url in production
      var response = await http.get(url);

      List<dynamic> jsonList = json.decode(response.body);
      List<Map<String, dynamic>> dataMapping = List<Map<String, dynamic>>.from(jsonList);
      // rawLeaderboardData = response.body;
      errorFlag = false;

      if (response.statusCode == 200){
        setState(() {
          _leaderBoardData = LeaderboardDetails.fromJsonList(dataMapping);
        });
      }
      else {
        _leaderBoardData = [];
      }
    }
    catch (error) {
      print("Error: $error");
      _leaderBoardData = [];
      errorFlag = true;
    }
  }

  @override
  void initState(){
    super.initState();
    _leaderBoardData = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column( // Note, add the column to a container to change the width
                    children: [
                      // Text(rawLeaderboardData),
                      Container(height: 20,),
                      DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                  'Rank',
                                  style: TextStyle(fontStyle: FontStyle.italic)
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                  'Name',
                                  style: TextStyle(fontStyle: FontStyle.italic)
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                  'Stashes Found',
                                  style: TextStyle(fontStyle: FontStyle.italic)
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                  'Completed',
                                  style: TextStyle(fontStyle: FontStyle.italic)
                              ),
                            ),
                          ),
                        ], rows: <DataRow> [
                        for (var entry in _leaderBoardData) DataRow(
                            cells: <DataCell>[
                              DataCell(Text(entry.rank.toString())),
                              DataCell(Text(entry.name)),
                              DataCell(Text(entry.stashesFound.toString())),
                              DataCell(Text(entry.dateCompleted.toString())),
                            ]
                        ),
                      ],
                      ),
                      Container(height: 20,),
                      ElevatedButton(
                        onPressed: () => fetchLeaderboard(),
                        child: Text("Fetch Leaderboard Data"),
                      ),
                      errorFlag ? Text("Error: Could not fetch leaderboard data.", style: TextStyle(color: Colors.red),) : Text(""),
                    ]
                ),
              ),

          ),
        )

    );
  }
}