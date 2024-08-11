import 'package:guardowl/features/assistant/models/activity_model.dart';

class ItineraryModel {
  List<Day> days;

  ItineraryModel({
    required this.days,
  });

  factory ItineraryModel.fromJson(Map<String, dynamic> json) => ItineraryModel(
        days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "days": List<dynamic>.from(days.map((x) => x.toJson())),
      };
}

class Day {
  int day;
  ActivityModel activity;

  Day({
    required this.day,
    required this.activity,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        day: json["day"],
        activity: ActivityModel.fromJson(json["activity"]),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "activity": activity.toJson(),
      };
}
