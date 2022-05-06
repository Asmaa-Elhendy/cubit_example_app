import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cubit_film_app/model/all_characters_model.dart';
import 'package:cubit_film_app/view_model/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  CharactersModel charactersModel;
  CharacterDetailsScreen(this.charactersModel);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.mygrey,
      body: CustomScrollView(
        slivers: [
          customAppBar(width, height),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin: EdgeInsets.fromLTRB(width*.06, height*.1, width*.1, height*.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   characterInfo('Name',charactersModel.name,width,width*.7),
                    characterInfo('Appeared in ',charactersModel.category.toString().split('.').last,width,width*.6),
                    characterInfo('Job',charactersModel.occupation.join(' / '),width,width*.75),
                    characterInfo('Birthday',charactersModel.birthday.toString(),width,width*.65),
                    characterInfo('Status',charactersModel.status.toString(),width,width*.7),
                    SizedBox(height: height*.4,),
                    Center(
                      child: DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 7.0,
                              color: Colors.white,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FlickerAnimatedText('Totally Completed'),
                          ],

                        ),
                      ),
                    ),

                  ],
                ),
              )
            ]
          ))
        ],
      ),
    );
  }

  Widget customAppBar(double width, double height) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: height * .8,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: charactersModel.charId,
          child: Image.network(
            charactersModel.img,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          charactersModel.nickname,
          style: TextStyle(color: MyColors.mywhite,fontSize: 19),
        ),
      ),
    );
  }
}

Widget characterInfo(String title,String data,double width,double endindent){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(   // or rich text
        children: [
          Text('$title :',style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.mywhite,fontSize: 16),),
          SizedBox(width: width*.03,),
          Expanded(child: Text(data,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: MyColors.mywhite,fontSize: width*.037,fontWeight: FontWeight.w600),))
        ],
      ),
      Divider(thickness: 3.5,color: MyColors.myyellow,endIndent: endindent,),

    ],
  );
}