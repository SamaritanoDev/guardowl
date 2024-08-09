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
      id: json.hashCode.toString(),
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
      _ => RiskSegment.low
    };
  }
}

enum RiskSegment { low, medium, high }

List<LocationZone> locationZoneFromJson(String str) => List<LocationZone>.from(
    json.decode(str).map((x) => LocationZone.fromJson(x)));
