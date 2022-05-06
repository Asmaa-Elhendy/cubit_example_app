part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class loadedCharactersState extends CharactersState{

  List<CharactersModel> characters=[];
  loadedCharactersState({required this.characters});
}

class loadingCharactersState extends CharactersState{

}
class errorgCharactersState extends CharactersState{

}
