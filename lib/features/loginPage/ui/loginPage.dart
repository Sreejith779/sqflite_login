import 'package:flutter/material.dart';
import 'package:sqflite_login/features/register/ui/registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
           textFormField("email",emailController,false),
              textFormField("password",passController,true),
              ElevatedButton(onPressed: (){
                if(formKey.currentState!.validate()){
                  print("Success");
                }else{
                  print("Failed");
                }
              }, child: Text("Login")),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
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
  }

  Widget textFormField(String? hintText,TextEditingController controller,bool obSecure){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obSecure,
        controller: controller,
        validator: (value){
if(value!.isEmpty){
  return "please enter $hintText";
}
if (hintText == "email" && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
