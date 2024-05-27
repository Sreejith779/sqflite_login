import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_login/features/homePage/ui/homePage.dart';
import 'package:sqflite_login/features/register/ui/registerPage.dart';

import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  LoginBloc loginBloc = LoginBloc();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
       if(state is LoginSuccessActionState){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
         Navigator.push(context, MaterialPageRoute(builder: (context)=>
             UserDetailsScreen(user: {},)));

       }else if(state is LoginFailedActionState){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed"),
         backgroundColor: Colors.redAccent,));
       }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textFormField("email", emailController, false),
                  textFormField("password", passController, true),
                  ElevatedButton(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final email = emailController.text.trim();
                      final password = passController.text.trim();
                      loginBloc.add(LoginUserEvent(email: email, password: password));


                    } else {
                      print("Failed");
                    }
                  }, child: Text("Login")),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) =>
                          RegisterPage()));
                    },
                    child: RichText(

                      text: const TextSpan(
                        children: [
                          TextSpan(text: "Don't have an account?",
                              style:
                              TextStyle(
                                  color: Colors.black
                              )
                          ),
                          TextSpan(text: " Register",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w600
                              ))

                        ],

                      ),),
                  )

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textFormField(String? hintText, TextEditingController controller,
      bool obSecure) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obSecure,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "please enter $hintText";
          }
          if (hintText == "email" &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
        decoration: InputDecoration(

            hintText: hintText,

            border: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.circular(15)
            )
        ),
      ),
    );
  }
}
