class WebRecipe{
  List<String> ingredients;
  List<String> reviews;
  String id;
  String title;
  String instructions;
  String image;
  String createdAt;
  WebRecipe({this.id, this.title, this.createdAt, this.image, this.ingredients, this.instructions, this.reviews});

  factory WebRecipe.fromJson(Map<String, dynamic> json){
    return WebRecipe(
      ingredients: json["ingriedients"],
      reviews: json["json"],
      id: json["_id"],
      title: json["title"],
      instructions: json["instructions"],
      image: json["image"],
      createdAt: json["createdAt"]
    );
  }
}