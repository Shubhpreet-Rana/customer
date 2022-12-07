part of 'feedback_bloc.dart';

abstract class FeedbackEvent {}

class FeedBackRequestedEvent extends FeedbackEvent {
  final String providerId;
  final String rating;
  final String description;

  FeedBackRequestedEvent({
    required this.providerId,
    required this.rating,
    this.description = "",
  });
}
