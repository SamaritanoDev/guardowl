part of 'activity_cubit.dart';

class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {
  const ActivityLoading();
}

class ActivityLoaded extends ActivityState {
  final List<ActivityModel> activities;

  const ActivityLoaded(this.activities);

  @override
  List<Object> get props => [activities];
}

class ActivityError extends ActivityState {
  final String error;

  const ActivityError(this.error);

  @override
  List<Object> get props => [error];
}
