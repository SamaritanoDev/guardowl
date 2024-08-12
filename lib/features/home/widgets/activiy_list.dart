import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';
import 'package:guardowl/features/home/views/activity_detail_view.dart';

class ActivitiesList extends StatelessWidget {
  final List<ActivityModel> activities;

  const ActivitiesList({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final textTitleStyle = textTheme.bodyMedium?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    final textSubTitleStyle = textTheme.titleSmall?.copyWith(
      color: color.outlineVariant,
    );

    return SliverList.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingAppBar),
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: ListTile(
              tileColor: color.primaryContainer,
              leading: Image.network(activity.photo, width: 100, height: 100, fit: BoxFit.cover),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityDetailView(
                        activity: activity,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: color.primary,
                ),
              ),
              title: Text(activity.nameActivity, style: textTitleStyle),
              subtitle: Text(activity.nameDestination, style: textSubTitleStyle),
            ),
          ),
        );
      },
    );
  }
}
