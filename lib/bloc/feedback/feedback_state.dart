part of 'feedback_bloc.dart';
class AddFeedbackState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLoading extends AddFeedbackState {}

class Loading extends AddFeedbackState {}

class AddFeedbackSuccessfully extends AddFeedbackState {
  final String res;

  AddFeedbackSuccessfully(this.res);

  @override
  List<Object> get props => [res];
}

class AddFeedbackFailed extends AddFeedbackState {
  final String error;

  AddFeedbackFailed(this.error);

  @override
  List<Object> get props => [error];
}
