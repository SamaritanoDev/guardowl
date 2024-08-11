import 'package:flutter/material.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';

class ActivitiesList extends StatelessWidget {
  final List<ActivityModel> activities;

  const ActivitiesList({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Card(
          child: ListTile(
            leading: Image.network(activity.photo,
                width: 100, height: 100, fit: BoxFit.cover),
            title: Text(activity.nameActivity),
            subtitle: Text(activity.address),
          ),
        );
      },
    );
  }
}
