class User{
  String id;
  String fullname;
  String username;
  String email;
  String password;

  User({this.fullname, this.email, this.password, this.id, this.username});

  User.fromData(Map<String, dynamic> data)
  : id = data["id"],
  fullname = data["fullname"],
  username = data["username"],
  email = data["email"],
  password = data["password"];

  Map<String, dynamic> toJson(){
    return{
      "id" : id,
      "fullname" : fullname,
      "username" : username,
      "email" : email,
      "password" : password
    };
  }
}