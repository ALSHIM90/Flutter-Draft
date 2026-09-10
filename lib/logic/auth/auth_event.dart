abstract class AuthEvent {
  const AuthEvent();
}

class SignUpRequestedEvent extends AuthEvent {
  final String parentName;
  final String email;
  final String password;

  const SignUpRequestedEvent({
    required this.parentName,
    required this.email,
    required this.password,
  });
}
