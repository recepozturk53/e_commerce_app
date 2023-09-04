import 'dart:async';

import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<UserModel>? _userSubscription;
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authRepository.user!.listen(
      (user) => add(AppUserChanged(userModel: user)),
    );
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(event.userModel.isNotEmpty
        ? AppState.authenticated(event.userModel)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
