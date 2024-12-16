class User {
  late String username;
  late String password;
  late String email;
  late String cpf;

  
  User(this.username, this.password, this.email, this.cpf);

  
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['username'] = username;
    json['password'] = password;
    json['email'] = email;
    json['cpf'] = cpf;

    return json;
  }
}
