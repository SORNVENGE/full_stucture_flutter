class LoginSignup {
  
  String username;
  String password;
  String email;


  LoginSignup(
      {this.username,
      this.password,
      this.email,});

  factory LoginSignup.fromMap(Map<String, dynamic> json) {
    return LoginSignup(
      username: json['username'],
      password: json['password'],
      email: json['email'],
    );
  }
}
