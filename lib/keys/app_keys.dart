import 'package:flutter/foundation.dart';

class SignInViewKeys {
  final email = const Key('emailField');
  final password = const Key('passwordField');
  final signin = const Key('signinButton');
  final signup = const Key('signupButton');
  final forgotPassword = const Key('forgotPasswordButton');
}

class SignUpViewKeys {
  final name = const Key('nameField');
  final password = const Key('passwordField');
  final email = const Key('emailButton');
  final signup = const Key('signupButton');
}

class ForgotPasswordViewKeys {
  final email = const Key('emailField');
  final submit = const Key('submitButton');
}

class SetPasswordViewKeys {
  final passwordOne = const Key('passwordOne');
  final passwordTwo = const Key('passwordTwo');
  final resetPassword = const Key('resetButton');
}

class AppKeys {
  final signInView = SignInViewKeys();
  final forgotPasswordView = ForgotPasswordViewKeys();
  final signUpView = SignUpViewKeys();
  final setPasswordView = SetPasswordViewKeys();
}

final appKeys = AppKeys();
