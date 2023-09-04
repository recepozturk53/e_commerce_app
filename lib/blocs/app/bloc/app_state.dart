part of 'app_bloc.dart';

enum AppStatus { unknown, authenticated, unauthenticated }

final class AppState extends Equatable {
  final AppStatus status;
  final UserModel userModel;

  const AppState({required this.status, this.userModel = UserModel.empty});

  const AppState.unknown() : this(status: AppStatus.unknown);
  const AppState.authenticated(UserModel userModel)
      : this(
          status: AppStatus.authenticated,
          userModel: userModel,
        );

  const AppState.unauthenticated()
      : this(
          status: AppStatus.unauthenticated,
        );

  @override
  List<Object> get props => [status, userModel];
}
