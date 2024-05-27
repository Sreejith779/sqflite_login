class DbModel{
  final int id;
  final String name;
  final String email;
  final String password;

  DbModel({required this.id,required this.name, required this.email, required this.password});
}

class LoginModel{

  final String email;
  final String password;

  LoginModel({required this.email, required this.password});
}