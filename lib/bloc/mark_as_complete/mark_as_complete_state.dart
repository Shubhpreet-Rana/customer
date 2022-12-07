part of 'mark_as_complete_bloc.dart';

abstract class MarkAsCompleteState extends Equatable {
  const MarkAsCompleteState();
  @override
  List<Object?> get props => [];
}

class MarkAsCompleteInitialState extends MarkAsCompleteState {
  const MarkAsCompleteInitialState();
}

class MarkAsCompleteLoadingState extends MarkAsCompleteState {
  const MarkAsCompleteLoadingState();
}

class MarkAsCompleteSuccessfulState extends MarkAsCompleteState {
  const MarkAsCompleteSuccessfulState();
}
