import 'dart:convert';

class DestinationsScore {
  String dptoPjfs;
  String provPjfs;
  String distPjfs;
  String grupo;
  String riskSegment;
  int quantity;
  double latitud;
  double longitud;
  String title;
  String photoUrl;

  DestinationsScore({
    required this.dptoPjfs,
    required this.provPjfs,
    required this.distPjfs,
    required this.grupo,
    required this.riskSegment,
    required this.quantity,
    required this.latitud,
    required this.longitud,
    required this.title,
    required this.photoUrl,
  });

  factory DestinationsScore.fromJson(Map<String, dynamic> json) =>
      DestinationsScore(
        dptoPjfs: json["dpto_pjfs"],
        provPjfs: json["prov_pjfs"],
        distPjfs: json["dist_pjfs"],
        grupo: json["GRUPO"],
        riskSegment: json["risk_segment"],
        quantity: json["quantity"],
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
        title: json["title"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "dpto_pjfs": dptoPjfs,
        "prov_pjfs": provPjfs,
        "dist_pjfs": distPjfs,
        "GRUPO": grupo,
        "risk_segment": riskSegment,
        "quantity": quantity,
        "latitud": latitud,
        "longitud": longitud,
        "title": title,
        "photo_url": photoUrl,
      };
}

List<DestinationsScore> destinationsScoreFromJson(String str) =>
    List<DestinationsScore>.from(
        json.decode(str).map((x) => DestinationsScore.fromJson(x)));

String destinationsScoreToJson(List<DestinationsScore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
