part of 'feedback_bloc.dart';

@immutable
abstract class AddFeedbackEvent extends Equatable {
  @override
  List<Object> get props => [];
}




class FeedBackRequested extends AddFeedbackEvent {
  final String? providerId;
  final String? rating;
  final String? feed;

  FeedBackRequested({this.providerId,this.rating,this.feed});
}
