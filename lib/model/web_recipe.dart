class WebRecipe {
  String thumbnail_url;
  String name;

  WebRecipe(
      {this.name,
      this.thumbnail_url});

  factory WebRecipe.fromData(Map<String, dynamic> json){
  return WebRecipe(
      thumbnail_url : json["thumbnail_url"],
      name : json["name"]
  );
  }
}
