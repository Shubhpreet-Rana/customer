import 'dart:async';

import 'package:app/data/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateEvent, CreateProfileState> {
  CreateProfileBloc({required this.profileRepository}) : super(NotCreated()) {
    on<CreateProfileRequested>(_createUser);
    on<ProfileEvent>((event, emit) => emit(NotCreated()));
  }

  final ProfileRepository profileRepository;

  Future<FutureOr<void>> _createUser(
    CreateProfileRequested event,
    Emitter<CreateProfileState> emit,
  ) async {
    emit(LoadingUpdate());
    try {
      final res = await profileRepository.createProfile(
          fName: event.fName,
          lName: event.lName,
          gender: event.gender,
          address: event.address,
          imagePath: event.imagePath,
          mobile: event.mobile);
      if (res['status'] == 1) {
        emit(CreatedSuccessfully(res['message']));
      } else {
        emit(CreatedFailed(res['message']));
        emit(NotCreated());
      }
    } catch (e) {
      emit(CreatedFailed(e.toString()));
      emit(NotCreated());
    }
  }
}
