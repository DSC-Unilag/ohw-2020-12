class Recipe{
  String url;
  String title;
  String description;
  String postid;
  String ownerid;
  String time;
  String ingredients;
  String user;
  String cusine;
  String utensils;

  Recipe({this.title, this.ownerid, this.user, this.postid, this.ingredients, this.url, this.description, this.time, this.cusine, this.utensils});

  Recipe.fromData(Map<String, dynamic> json)
  : url = json["url"],
  title = json["title"],
  postid = json["postid"],
  user = json["user"],
  description = json["description"],
  time = json["time"],
  ownerid = json["ownerid"],
  ingredients = json["ingredients"],
  cusine = json["cusine"],
  utensils = json["utensils"];

  Map<String, dynamic> toJson(){
    return{
      "url" : url,
      "title" : title,
      "user" : user,
      "description" : description,
      "time" : time,
      "postid" : postid,
      "ownerid" : ownerid,
      "ingredients" : ingredients,
      "cusine" : cusine,
      "utensils" : utensils
    };
  }
}