import 'package:dio/dio.dart';
import 'package:recipesaver/constants.dart';
import 'package:recipesaver/model/web_recipe.dart';

class WebServices{
  var dio = Dio();

  Future<List<WebRecipe>> fetchRecipe() async{
    final response = await dio.get(api_url);

    if(response.statusCode == 200){
      final result = response.data;
      Iterable list = result["recipes"];
      return list.map((web_recipe)=> WebRecipe.fromJson(web_recipe)).toList();
    }else{
      throw Exception("failed to get recipes");
    }
  }
}