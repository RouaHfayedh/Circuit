class Station {
  final nameDep;
  final lat;
  final lan;
  final nameDest;

  Station(this.nameDep, this.lat, this.lan, this.nameDest);

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(json['nameDep'], json['lat'], json['lan'], json['nameDest']);
    // Station(
    //   nameDep: json['albumId'],
    //   id: json['id'] as int,
    //   title: json['title'] as String,
    //   url: json['url'] as String,
    //   thumbnailUrl: json['thumbnailUrl'] as String,
    // );
  }
}
