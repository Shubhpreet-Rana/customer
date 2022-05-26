import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/profile_repository.dart';
import '../../../model/user.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<ProfileFetchEvent>(_fetchCurrentUserProfile);
  }

  FutureOr<void> _fetchCurrentUserProfile(ProfileFetchEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      final userProfile = await profileRepository.getUserProfileDetails();
      if (userProfile != null) emit(ProfileLoaded(userProfile: userProfile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
