import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SignUpRequestedEvent>(_onSignUpRequested);
  }

  void _onSignUpRequested(
    SignUpRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      // محاكاة الاتصال بالسيرفر أو Firebase
      await Future.delayed(const Duration(seconds: 1));

      if (event.email.contains('@')) {
        emit(
          const AuthSuccessState(
            'Account created successfully! Welcome to EduPlay!',
          ),
        );
      } else {
        emit(const AuthFailureState('Please enter a valid email address.'));
      }
    } catch (e) {
      emit(AuthFailureState('Sign up failed: ${e.toString()}'));
    }
  }
}
