import 'package:f_patrol/keys/app_keys.dart';
import 'package:f_patrol/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/*
Tips: 
1. Dont test for toasts, as they are not in the same widget tree, therefore test may fail!

*/

void main() {
  patrolTest('Complete app flow - integration test', ($) async {
    await $.pumpWidgetAndSettle(FPatrolApp());

    // Verify Splash Screen and wait for navigation
    expect($('Splash Screen'), findsOne);
    await Future.delayed(const Duration(seconds: 3)); // Wait for auto-navigation

    await $.pumpAndSettle();

    // Verify we are on Sign In Screen
    expect($('Sign In'), findsExactly(2)); // 1-> Appbar, 2-> in button

    // Test Sign In with invalid credentials
    await $(appKeys.signInView.email).enterText('invalid_email');
    await $(appKeys.signInView.password).enterText('123');
    await $(appKeys.signInView.signin).tap();
    expect($('Enter a valid email'), findsOne);
    expect($('Password too short'), findsOne);

    // Test Sign In with valid credentials
    await $(appKeys.signInView.email).enterText('user@example.com');
    await $(appKeys.signInView.password).enterText('securePassword123');
    await $(appKeys.signInView.signin).tap();
    await $.pumpAndSettle();

    // Verify Home Screen
    expect($('Welcome Home'), findsOne);

    // Navigate to Sign Up Screen
    await $.native.pressBack();
    await $(appKeys.signInView.signup).tap();
    await $.pumpAndSettle();
    expect($('Sign Up'), findsExactly(2)); // 1-> Appbar, 2-> in button

    // Fill Sign Up Form
    await $(appKeys.signUpView.name).enterText('New User');
    await $(appKeys.signUpView.email).enterText('newuser@example.com');
    await $(appKeys.signUpView.password).enterText('newPassword123');
    await $(appKeys.signUpView.signup).tap();
    await $.pumpAndSettle();

    expect($('Welcome Home'), findsOne);

    // Navigate to Forgot Password Screen
    await $.native.pressBack();
    await $(appKeys.signInView.forgotPassword).tap();
    await $.pumpAndSettle();
    expect($('Forgot Password'), findsOne);

    // Reset Password
    await $(appKeys.forgotPasswordView.email).enterText('user@example.com');
    await $(appKeys.forgotPasswordView.submit).tap();

    await $.pumpAndSettle();

    await $(appKeys.setPasswordView.passwordOne).enterText('newSecurePass123');
    await $(appKeys.setPasswordView.passwordTwo).enterText('newSecurePass123');
    await $(appKeys.setPasswordView.resetPassword).tap();

    // Verify Home Screen again
    expect($('Welcome Home'), findsOne);
  });
}
