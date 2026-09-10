abstract class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String message;
  const AuthSuccessState(this.message);
}

class AuthFailureState extends AuthState {
  final String errorMessage;
  const AuthFailureState(this.errorMessage);
}
