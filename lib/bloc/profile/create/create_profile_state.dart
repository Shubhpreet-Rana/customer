part of 'create_profile_bloc.dart';

@immutable
abstract class CreateProfileState extends Equatable {}

class LoadingUpdate extends CreateProfileState {
  @override
  List<Object?> get props => [];
}
class CreatedSuccessfully extends CreateProfileState {
  final String success;
  CreatedSuccessfully(this.success);
  @override
  List<Object?> get props => [];
}

class NotCreated extends CreateProfileState {
  @override
  List<Object?> get props => [];
}

class CreatedFailed extends CreateProfileState {
  final String error;

  CreatedFailed(this.error);
  @override
  List<Object?> get props => [error];
}