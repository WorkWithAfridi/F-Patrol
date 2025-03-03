import 'package:f_patrol/keys/app_keys.dart';
import 'package:f_patrol/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Sign Up Successful");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: appKeys.signUpView.name,
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value!.isNotEmpty ? null : "Enter your name",
              ),
              TextFormField(
                key: appKeys.signUpView.email,
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => value!.contains('@') ? null : "Enter a valid email",
              ),
              TextFormField(
                key: appKeys.signUpView.password,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) => value!.length >= 6 ? null : "Password too short",
              ),
              const SizedBox(height: 20),
              ElevatedButton(key: appKeys.signUpView.signup, onPressed: _signUp, child: const Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}
