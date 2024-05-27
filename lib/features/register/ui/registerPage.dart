import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_login/features/loginPage/ui/loginPage.dart';

import '../bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  RegisterBloc registerBloc = RegisterBloc();

  @override
  void initState() {
  registerBloc.add(RegisterInitialEvent());
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: registerBloc,
        listener: (BuildContext context, RegisterState state){
          if(state is RegisterSuccessActionState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Register Successfully")));
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textFormField("Name", nameController, false),
                  textFormField("Email", emailController, false),
                  textFormField("Password", passController, true),
                  textFormField(
                      "Confirm Password", confirmPassController, true),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final password = passController.text.trim();
                        registerBloc.add(RegisterUserEvent(name: name, email: email, password: password));
                        print("Successfully Registered");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      } else {
                        print("Registration Failed");
                      }
                    },
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => const LoginPage()));
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Have an account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: " Login",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textFormField(String hintText, TextEditingController controller,
      bool obscureText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          if (hintText == "Email" &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          if (hintText == "Confirm Password" && value != passController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
}
