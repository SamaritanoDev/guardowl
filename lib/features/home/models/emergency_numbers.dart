import 'dart:convert';

class EmergencyNumbers {
  String entityName;
  String number;
  String location;

  EmergencyNumbers({
    required this.entityName,
    required this.number,
    required this.location,
  });

  factory EmergencyNumbers.fromJson(Map<String, dynamic> json) =>
      EmergencyNumbers(
        entityName: json["entityName"] ?? '',
        number: json["number"] ?? '',
        location: json["location"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "entityName": entityName,
        "number": number,
        "location": location,
      };
}

List<EmergencyNumbers> emergencyNumbersFromJson(String str) =>
    List<EmergencyNumbers>.from(
        json.decode(str).map((x) => EmergencyNumbers.fromJson(x)));

String emergencyNumbersToJson(List<EmergencyNumbers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
