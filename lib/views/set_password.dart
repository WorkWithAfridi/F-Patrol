import 'package:f_patrol/keys/app_keys.dart';
import 'package:f_patrol/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _setPassword() {
    if (_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Password reset successful");
      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set New Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: appKeys.setPasswordView.passwordOne,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
                validator: (value) => value!.length >= 6 ? null : "Password too short",
              ),
              TextFormField(
                key: appKeys.setPasswordView.passwordTwo,
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirm Password"),
                validator: (value) => value == _passwordController.text ? null : "Passwords do not match",
              ),
              const SizedBox(height: 20),
              ElevatedButton(key: appKeys.setPasswordView.resetPassword, onPressed: _setPassword, child: const Text("Reset Password")),
            ],
          ),
        ),
      ),
    );
  }
}
