class ActivityModel {
  ActivityModel({
    required this.typeActitvity,
    required this.photo,
    required this.nameActivity,
    required this.nameDestination,
    required this.season,
    required this.schedule,
    required this.address,
  });

  String typeActitvity;
  String photo;
  String nameActivity;
  String nameDestination;
  String season;
  String schedule;
  String address;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        typeActitvity: json["typeActitvity"],
        photo: json["photo"],
        nameActivity: json["nameActivity"],
        nameDestination: json["nameDestination"],
        season: json["season"],
        schedule: json["schedule"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "typeActitvity": typeActitvity,
        "photo": photo,
        "nameActivity": nameActivity,
        "nameDestination": nameDestination,
        "season": season,
        "schedule": schedule,
        "address": address,
      };
}
