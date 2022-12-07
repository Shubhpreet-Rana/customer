part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitialState extends FeedbackState {
  const FeedbackInitialState();
}

class FeedbackLoadingState extends FeedbackState {
  const FeedbackLoadingState();
}

class FeedbackSuccessState extends FeedbackState {
  const FeedbackSuccessState();
}
