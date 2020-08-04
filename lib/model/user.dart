class User{
  String id;
  String fullname;
  String username;
  String email;
  String bio;
  String imageurl;
  String password;

  User({this.fullname, this.imageurl, this.email, this.password, this.id, this.username, this.bio});

  User.fromData(Map<String, dynamic> data)
  : id = data["id"],
  fullname = data["fullname"],
  username = data["username"],
  bio = data["bio"],
  email = data["email"],
  imageurl = data["imageurl"],
  password = data["password"];

  Map<String, dynamic> toJson(){
    return{
      "id" : id,
      "imageurl" : imageurl,
      "fullname" : fullname,
      "bio" :bio,
      "username" : username,
      "email" : email,
      "password" : password
    };
  }
}