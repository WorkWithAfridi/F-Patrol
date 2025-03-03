import 'package:f_patrol/keys/app_keys.dart';
import 'package:f_patrol/views/set_password.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitEmail() {
    if (_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Email verified. Proceed to set new password.");
      Navigator.push(context, MaterialPageRoute(builder: (_) => SetPasswordScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: appKeys.forgotPasswordView.email,
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => value!.contains('@') ? null : "Enter a valid email",
              ),
              const SizedBox(height: 20),
              ElevatedButton(key: appKeys.forgotPasswordView.submit, onPressed: _submitEmail, child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
