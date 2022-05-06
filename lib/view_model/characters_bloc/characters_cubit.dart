import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cubit_film_app/model/all_characters_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'characters_controller.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharactersInitial());
  List<CharactersModel> characters=[];
  CharactersController charactersController =CharactersController();


  fetchallCharacters(){
 try{
   emit(loadingCharactersState());
   charactersController.fetchAllCharacters().then((characters) {
     this.characters=characters;
    emit(loadedCharactersState(characters: characters));
     return characters;
   });
 }catch(e){
   print(e);
   print('error************');
   emit(errorgCharactersState());
 }

  }

}
