part of 'emergency_phone_cubit.dart';

sealed class StateDataNumbers {
  const StateDataNumbers();
}

class InitialLoadingState extends StateDataNumbers {}

class LoadedState extends StateDataNumbers {
  final List<EmergencyNumbers> numbers;
  LoadedState({
    required this.numbers,
  });
}

class ErrorState extends StateDataNumbers {
  final Object error;

  ErrorState({required this.error});
}

class EmptyState extends StateDataNumbers {}

class EmergencyPhoneState extends Equatable {
  final List<EmergencyNumbers> numbers;
  final StateDataNumbers status;

  const EmergencyPhoneState({
    required this.numbers,
    required this.status,
  });

  EmergencyPhoneState copyWith({
    List<EmergencyNumbers>? numbers,
    StateDataNumbers? status,
  }) {
    return EmergencyPhoneState(
      numbers: numbers ?? this.numbers,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [numbers, status];
}
