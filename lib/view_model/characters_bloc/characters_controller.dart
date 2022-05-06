//view model // repository

import 'package:cubit_film_app/model/all_characters_model.dart';
import 'package:cubit_film_app/services/characters.dart';

class CharactersController{

CharactersService charactersService=CharactersService();

  Future<List<CharactersModel>> fetchAllCharacters()async {
  var  characters=  await charactersService.fetchAllCharacters();
  return  characters.map((e) => CharactersModel.fromMap(e)).toList() ;
  }
}