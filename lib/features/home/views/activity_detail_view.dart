import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';
import 'package:guardowl/features/home/widgets/search_widgets.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityModel activity;

  const ActivityDetailView({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textSubTitleCard = textTheme.titleSmall?.copyWith(color: color.secondary);

    final textTitleCard = textTheme.titleSmall?.copyWith(
      color: color.primary,
    );

    return Scaffold(
      backgroundColor: color.onPrimary,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: MyAppBarArrow(title: 'Detail activity'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingAppBar),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyCardImage(
                urlImage: activity.photo,
                titleDestination: activity.nameActivity,
                location: 'Location',
                place: activity.nameDestination,
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              LabelText(
                label: 'Activity: ',
                value: activity.nameActivity,
                style: textTitleCard!,
              ),
              const SizedBox(height: 10),
              LabelText(
                label: 'Best season: ',
                value: activity.season,
                style: textSubTitleCard!,
              ),
              const SizedBox(height: 10),
              LabelText(
                label: 'Horurs: ',
                value: activity.schedule,
                style: textTitleCard,
              ),
              const SizedBox(height: 5),
              LabelText(
                label: 'Location: ',
                value: activity.nameDestination,
                style: textTitleCard,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: color.secondary,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      activity.address,
                      style: textSubTitleCard,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(activity.typeActitvity, style: textTitleCard),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle style;
  const LabelText({
    super.key,
    required this.label,
    required this.value,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: style,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        Expanded(
          child: Text(
            value,
            style: style,
          ),
        ),
      ],
    );
  }
}
