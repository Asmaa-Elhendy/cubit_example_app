
import 'package:cubit_film_app/model/all_characters_model.dart';
import 'package:cubit_film_app/view_model/characters_bloc/characters_controller.dart';
import 'package:cubit_film_app/view_model/characters_bloc/characters_cubit.dart';
import 'package:cubit_film_app/view_model/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'character_details_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CharactersController charactersController = CharactersController();
  List<CharactersModel> allCharacters = [];
  List<CharactersModel> SearchedList = [];
  bool _isSearch = false;
  TextEditingController characterTextController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CharactersCubit>(context).fetchallCharacters();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: _isSearch
            ? TextFieldWidget()
            : Text(
                'Characters',
                style: TextStyle(color: MyColors.mygrey),
              ),
        backgroundColor: MyColors.myyellow,
        actions: actionAppBar(),
      ),
      body:  OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Center(
                    child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                  ),
                ),
              ),
         connected?     BlocBuilder<CharactersCubit, CharactersState>(
              builder: (BuildContext context, state) {
                if (state is loadingCharactersState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyColors.mygrey,
                    ),
                  );
                } else if (state is loadedCharactersState) {
                  allCharacters = state.characters;

                  return loadedWidget(
                      characterTextController.text.isEmpty
                          ? state.characters
                          : SearchedList,
                      width,
                      height);
                } else if (state is errorgCharactersState) {
                  return Center(
                    child: Image.asset("assets/images/error.png"),
                  );
                } else {
                  return Center(
                    child: Text('No'),
                  );
                }
              },
            ) :  Center(
           child: Image.asset("assets/images/error.png"),
         ),
            ],
          );
        },
        child: SizedBox(child: Text('tap to reload',style: TextStyle(color: Colors.white,fontSize: 40),),),
      ),





g


    );








  }

  Widget loadedWidget(
      List<CharactersModel> characters, double width, double height) {
    return Container(
      color: MyColors.mygrey,
      padding: EdgeInsets.all(width * .01),
      child: GridView.builder(
          itemCount: characters.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .65,
            crossAxisSpacing: width * .02,
            mainAxisSpacing: height * .01,
          ),
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            CharacterDetailsScreen(characters[index])));
              },
              child: Container(
                width: double.infinity,
                color: MyColors.mywhite,
                padding: EdgeInsets.all(width * .008),
                child: GridTile(
                  child: Hero(
                    tag: characters[index].charId,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(width * .0008),
                      color: MyColors.mywhite,
                      child: characters[index].img.isEmpty
                          ? Image.asset(
                              "assets/images/error.png",
                              fit: BoxFit.cover,
                            )
                          : FadeInImage.assetNetwork(
                              placeholder: "assets/images/loading.gif",
                              image: characters[index].img,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  footer: Container(
                    color: Colors.black54,
                    width: double.infinity,
                    height: height * .05,
                    child: Center(
                        child: Text(
                      characters[index].name,
                      maxLines: 2,
                      style: TextStyle(
                        color: MyColors.mywhite,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                  ),
                ),
              ),
            );
          }),
    );
  }

  List<Widget> actionAppBar() {
    if (_isSearch) {
      return [
        IconButton(
          onPressed: () {
            setState(() {
              characterTextController.clear();
              _isSearch = false;
            });
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          color: MyColors.mygrey,
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            ModalRoute.of(context)!
                .addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
              characterTextController.clear();
            }));
            setState(() {
              _isSearch = true;
            });
          },
          icon: Icon(Icons.search),
          color: MyColors.mygrey,
        )
      ];
    }
  }

  searchFunction() {
    SearchedList = allCharacters
        .where((character) => character.name
            .toLowerCase()
            .startsWith(characterTextController.text.toLowerCase()))
        .toList();
    setState(() {});
  }

  TextFieldWidget() {
    return TextField(
      controller: characterTextController,
      cursorColor: MyColors.mygrey,
      decoration: const InputDecoration(
        hintText: 'Find a Character...',
        border: InputBorder.none,
      ),
      onChanged: (text) {
        searchFunction();
      },
    );
  }
}
