part of 'mark_as_complete_bloc.dart';

abstract class MarkAsCompleteEvent {
  const MarkAsCompleteEvent();
}

class MarkAsCompleteRequestEvent extends MarkAsCompleteEvent {
  const MarkAsCompleteRequestEvent({
    required this.amount,
    required this.description,
    required this.bookingId,
    required this.status,
  });

  final String amount;
  final String description;
  final int status;
  final int bookingId;
}
