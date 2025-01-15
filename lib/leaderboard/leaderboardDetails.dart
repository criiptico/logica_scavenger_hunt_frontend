class LeaderboardDetails {
  LeaderboardDetails(this.rank, this.name, this.stashesFound, this.dateCompleted);

  int rank;
  String name;
  int stashesFound;
  String dateCompleted;

  Map<String, dynamic> toJson() {
   return {
     "rank": rank,
    "name": name,
    "stashesFound": stashesFound,
    "dateCompleted": dateCompleted,
   };
  }

  factory LeaderboardDetails.fromJson(Map<String, dynamic> json){
    return LeaderboardDetails(
        json["rank"],
        json["name"],
        json["stashesFound"],
        json["dateCompleted"]
    );
  }

  static List<LeaderboardDetails> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeaderboardDetails.fromJson(json)).toList();
  }

}