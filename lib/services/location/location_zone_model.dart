import 'dart:convert';

class LocationZone {
  final String id;
  final String title;
  final String riskGroup;
  final String riskSegment;
  final double latitude;
  final double longitude;

  const LocationZone({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.riskGroup,
    required this.riskSegment,
  });

  factory LocationZone.fromJson(Map<String, dynamic> json) {
    return LocationZone(
      id: json['id'],
      title: json['title'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      riskGroup: json['risk_group'],
      riskSegment: json['risk_segment'],
    );
  }

  RiskSegment get riskSegmentEnum {
    return switch (riskSegment.toUpperCase()) {
      'RIESGO MUY BAJO' => RiskSegment.low,
      'RIESGO BAJO' => RiskSegment.low,
      'RIESGO MEDIO' => RiskSegment.medium,
      'RIESGO ALTO' => RiskSegment.high,
      'RIESGO MUY ALTO' => RiskSegment.high,
      'ROUTE' => RiskSegment.route,
      _ => RiskSegment.route
    };
  }
}

enum RiskSegment { low, medium, high, route }

List<LocationZone> locationZoneFromJson(String str) {
  final decodeList = List<Map<String, dynamic>>.from(json.decode(str));

  final listWithId = List.generate(
    decodeList.length,
    (index) => {'id': index.toString(), ...decodeList[index]},
  );
  return List<LocationZone>.from(
      listWithId.map((x) => LocationZone.fromJson(x)));
}
