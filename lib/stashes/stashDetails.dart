class StashDetails {
  StashDetails(this.id, this.latitude, this.longitude, this.found, this.hint);

  double latitude;
  double longitude;
  int id;
  bool found;
  String hint;

  factory StashDetails.fromJson(Map<String, dynamic> json){
    return StashDetails(
      json["id"],
      json["latitude"],
      json["longitude"],
      json["found"],
      json["hint"],
    );
  }

  static List<StashDetails> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StashDetails.fromJson(json)).toList();
  }


}