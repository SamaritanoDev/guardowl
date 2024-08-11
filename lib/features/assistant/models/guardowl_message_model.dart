import 'package:guardowl/features/assistant/models/activity_model.dart';
import 'package:guardowl/features/assistant/models/itinerary_model.dart';

class GuardOwlMessage {
  String message;
  List<ActivityModel> activities;
  ItineraryModel itinerary;

  GuardOwlMessage({
    required this.message,
    required this.activities,
    required this.itinerary,
  });

  factory GuardOwlMessage.fromJson(Map<String, dynamic> json) => GuardOwlMessage(
        message: json["message"],
        activities: List<ActivityModel>.from(json["activities"].map((x) => ActivityModel.fromJson(x))),
        itinerary: ItineraryModel.fromJson(json["itinerary"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "itinerary": itinerary.toJson(),
      };
}
