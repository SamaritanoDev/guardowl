import 'dart:convert';

class DestinationsScore {
  String ubigeoPjfs;
  int distFiscal;
  String dptoPjfs;
  String provPjfs;
  String distPjfs;
  String group;
  String riskSegment;
  int quantity;
  double latitude;
  double longitude;
  String title;
  String photoUrl;

  DestinationsScore({
    required this.ubigeoPjfs,
    required this.distFiscal,
    required this.dptoPjfs,
    required this.provPjfs,
    required this.distPjfs,
    required this.group,
    required this.riskSegment,
    required this.quantity,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.photoUrl,
  });

  factory DestinationsScore.fromJson(Map<String, dynamic> json) =>
      DestinationsScore(
        ubigeoPjfs: json["ubigeo_pjfs"] ?? '',
        distFiscal: json["dist_fiscal"] ?? 0,
        dptoPjfs: json["dpto_pjfs"] ?? '',
        provPjfs: json["prov_pjfs"] ?? '',
        distPjfs: json["dist_pjfs"] ?? '',
        group: json["group"] ?? '',
        riskSegment: json["risk_segment"] ?? '',
        quantity: json["quantity"] ?? 0,
        latitude: (json["latitude"] ?? 0).toDouble(),
        longitude: (json["longitude"] ?? 0).toDouble(),
        title: json["title"] ?? '',
        photoUrl: json["photo_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ubigeo_pjfs": ubigeoPjfs,
        "dist_fiscal": distFiscal,
        "dpto_pjfs": dptoPjfs,
        "prov_pjfs": provPjfs,
        "dist_pjfs": distPjfs,
        "group": group,
        "risk_segment": riskSegment,
        "quantity": quantity,
        "latitude": latitude,
        "longitude": longitude,
        "title": title,
        "photo_url": photoUrl,
      };
}

List<DestinationsScore> destinationsScoreFromJson(String str) =>
    List<DestinationsScore>.from(
        json.decode(str).map((x) => DestinationsScore.fromJson(x)));

String destinationsScoreToJson(List<DestinationsScore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
