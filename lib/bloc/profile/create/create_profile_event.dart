part of 'create_profile_bloc.dart';

abstract class CreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileEvent extends CreateEvent {}

class CreateProfileRequested extends CreateEvent {
  CreateProfileRequested(this.fName, this.lName,this.mobile,this.address,this.gender,this.imagePath,this.lat,this.lang);

  final String fName;
  final String lName;
  final String mobile;
  final String address;
  final int gender;
  final String imagePath;
  final double lat;
  final dynamic lang;
}

