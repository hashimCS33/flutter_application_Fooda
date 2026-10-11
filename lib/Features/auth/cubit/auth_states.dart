abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthSuccess extends AuthStates {}

class AuthSignupSuccess extends AuthStates {}

class AuthError extends AuthStates {
  final String message;
  AuthError(this.message);
}

class AuthLoading extends AuthStates {}
