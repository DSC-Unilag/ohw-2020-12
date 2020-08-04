import 'dart:convert';


import 'package:recipesaver/constants.dart';
import 'package:http/http.dart' as http;
import 'package:recipesaver/model/web_recipe.dart';

class WebServices {

//  Future<List> fetchRecipe() async{

//    try {
//      http.Response response = await http.get(api_url, headers: reqheader);
////      print(jsonDecode(response.body));
//      if (response.statusCode == 200) {
////        var result = response.body as List;
////        print(result.toString());
//      List<dynamic> body = jsonDecode(response.body);
////      print(body,);
////      Iterable list = result["recipes"];
////      var recipe = body.map((dynamic item) => WebRecipe.fromData(item)).toList();
////      print(recipe);
//      return body.toList();
//      } else {
//        throw Exception("failed to get recipes");
//      }
//    }catch(e){
//      return e.message;
//    }
//  }

//  var dio = Dio();

  Future<List<WebRecipe>> fetchRecipe() async{
    Map<String, String> reqheader = {
      'x-rapidapi-key': "bd79790a3dmsh10a85af00de492ep11daffjsnc22035e49ae9",
      'x-rapidapi-host' : 'tasty.p.rapidapi.com',
      'useQueryString' : 'true'
    };
//    http.head(reqheader.toString());
    final response = await http.get(api_url, headers: reqheader);
    print(response);

    if(response.statusCode == 200){
      final result = jsonDecode(response.body);
      print("Here" + result.toString());
      Iterable list = result["results"];
      return list;
    }else{
      throw Exception("failed to get recipe");
    }
  }
}