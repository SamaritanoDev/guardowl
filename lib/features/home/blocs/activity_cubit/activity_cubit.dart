import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardowl/features/assistant/models/activity_model.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());

  void setActivities(List<ActivityModel> activities) {
    emit(ActivityLoaded(activities));
  }

  void setError(String error) {
    emit(ActivityError(error));
  }
}
