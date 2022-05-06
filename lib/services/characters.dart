import 'package:dio/dio.dart';

class CharactersService{
  Dio dio =Dio();
  String baseUrl='https://www.breakingbadapi.com/api/';

  Future<List<dynamic>> fetchAllCharacters()async{
    try {
      Response res = await dio.get('${baseUrl}characters');
      print(res.data.toString());
      return res.data;
    }catch(e){
      print(e.toString());
      return [];
    }

  }




}