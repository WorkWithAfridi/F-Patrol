import 'package:f_patrol/keys/app_keys.dart';
import 'package:f_patrol/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/*
Tips: 
1. Don’t test for toasts, as they are not in the same widget tree, therefore tests may fail!
2. Avoid testing time-dependent elements like animations, which might cause flakiness in tests. 
3. Make sure the widget tree is settled before proceeding with any assertions or interactions (`await $.pumpAndSettle()`).
4. Use clear, descriptive keys for elements (e.g., `appKeys.signInView.email`) to ensure reliability in finding widgets during tests.
5. Don't test for elements that appear after a delayed action unless you specifically wait for them (e.g., `Future.delayed()`).
6. Ensure your tests do not rely on a network connection or use mock data for consistency.
7. Always check that the state of your widget is correctly updated after interaction before making assertions.
8. Consider using `await $.pumpAndSettle()` when testing navigation or screen transitions to ensure the app has fully loaded.

Debugging Tips:
1. **Widget Not Found**: If a test fails due to a widget not being found, check that the widget's key is correctly defined in both the test and the app. Double-check any key names.
2. **UI is not rendering as expected**: If the UI is not displaying as expected, try adding `await $.pumpAndSettle()` after significant actions like navigation or data loading.
3. **Interactions Not Working**: If interaction elements like buttons or text fields aren't responding, ensure that the widgets are not being obstructed by other widgets or overlays.
4. **Test Flakiness**: If the test intermittently fails, add more waits (`await $.pumpAndSettle()`) before assertions to ensure that the app has time to settle, especially in cases of animations or API calls.
5. **Timeouts**: If the test times out during assertions, ensure the widget tree is fully settled by adding delays or using `await $.pumpAndSettle()`.
6. **Re-running Failed Tests**: If a test fails, rerun it with a debugger attached to inspect the current widget state and navigation paths.

Test Description:
This integration test simulates a complete user flow through the app. The steps include:
1. Launching the app and verifying the splash screen before the automatic navigation to the sign-in screen.
2. Testing the sign-in process with both invalid and valid credentials, verifying the error messages for invalid input, and ensuring navigation to the home screen after a successful sign-in.
3. Simulating the sign-up process by filling out a registration form and verifying that the user is redirected to the home screen after successful sign-up.
4. Testing the forgot password functionality by navigating to the reset password screen, submitting an email for password recovery, and setting a new password.
5. Ensuring that the user returns to the home screen after completing the password reset.

The test covers essential user flows for authentication, including sign-in, sign-up, and password reset functionalities.

*/

void main() {
  patrolTest('Complete app flow - integration test', ($) async {
    // Pump the app widget and wait for it to settle
    await $.pumpWidgetAndSettle(FPatrolApp());

    // Verify that the Splash Screen is displayed and wait for navigation to complete
    expect($('Splash Screen'), findsOne);
    await Future.delayed(const Duration(seconds: 3)); // Wait for auto-navigation

    // Ensure that the app has settled after the splash screen
    await $.pumpAndSettle();

    // Verify we are on the Sign In Screen by checking the appearance of 'Sign In' elements
    expect($('Sign In'), findsExactly(2)); // 1-> Appbar, 2-> SignIn button

    // Test the Sign In functionality with invalid credentials
    await $(appKeys.signInView.email).enterText('invalid_email');
    await $(appKeys.signInView.password).enterText('123');
    await $(appKeys.signInView.signin).tap();
    // Check for validation messages on the Sign In form
    expect($('Enter a valid email'), findsOne);
    expect($('Password too short'), findsOne);

    // Test Sign In with valid credentials
    await $(appKeys.signInView.email).enterText('user@example.com');
    await $(appKeys.signInView.password).enterText('securePassword123');
    await $(appKeys.signInView.signin).tap();
    // Wait for the navigation to the Home Screen to complete
    await $.pumpAndSettle();

    // Verify that we are on the Home Screen by checking for 'Welcome Home'
    expect($('Welcome Home'), findsOne);

    // Navigate to the Sign Up Screen by pressing the back button and tapping the Sign Up button
    await $.native.pressBack();
    await $(appKeys.signInView.signup).tap();
    await $.pumpAndSettle();
    // Verify the presence of 'Sign Up' elements on the screen
    expect($('Sign Up'), findsExactly(2)); // 1-> Appbar, 2-> SignUp button

    // Fill out and submit the Sign Up form
    await $(appKeys.signUpView.name).enterText('New User');
    await $(appKeys.signUpView.email).enterText('newuser@example.com');
    await $(appKeys.signUpView.password).enterText('newPassword123');
    await $(appKeys.signUpView.signup).tap();
    await $.pumpAndSettle();

    // After successful sign-up, verify that the Home Screen is displayed again
    expect($('Welcome Home'), findsOne);

    // Navigate to the Forgot Password Screen
    await $.native.pressBack();
    await $(appKeys.signInView.forgotPassword).tap();
    await $.pumpAndSettle();
    // Verify the Forgot Password screen is displayed
    expect($('Forgot Password'), findsOne);

    // Enter email to reset password and submit the request
    await $(appKeys.forgotPasswordView.email).enterText('user@example.com');
    await $(appKeys.forgotPasswordView.submit).tap();
    await $.pumpAndSettle();

    // On the Reset Password Screen, enter new password and confirm it
    await $(appKeys.setPasswordView.passwordOne).enterText('newSecurePass123');
    await $(appKeys.setPasswordView.passwordTwo).enterText('newSecurePass123');
    await $(appKeys.setPasswordView.resetPassword).tap();

    // After password reset, verify that the Home Screen is displayed once again
    expect($('Welcome Home'), findsOne);
  });
}
