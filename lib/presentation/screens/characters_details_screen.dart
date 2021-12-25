import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/buisness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetilsScreen extends StatelessWidget {

  final Character character ;

  const CharacterDetilsScreen({Key? key, required this.character}) : super(key: key);


  Widget buildSliverAppBar(){

    return SliverAppBar( // هنا هتحكم في الصوره والاسم ال موجود علي الصوره وهعمل فيهم شغل
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGery,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
          textAlign: TextAlign.start,

        ),
        background: Hero( // استعملت الهيرو عشان اعمل الانيميشن ال عملت في الصفحه ال قبلها لما هاجي اضغط علي الصوره وتدخلني للتفاصيل
          tag: character.charId,
          child: Image.network(character.image, fit : BoxFit.cover),
        ),

      ),

    );

  }

  Widget characterInfo(String title , String value){

    return RichText( // بتديلي مميزات ذياده في text
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text:  TextSpan(children: [

          TextSpan(
            text:title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )
          ),
          TextSpan(
              text:value,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
              )
          ),

        ])  );

  }


  Widget buildDivider(double endIndent){

    return Divider(
      height: 30,
      endIndent:endIndent ,
      color: MyColors.myYellow,
      thickness: 2,

    );

  }



  Widget checkIfQuotesAreLoaded(CharactersState state){
    if(state is QuotesLoaded){
      return displayRandomQuoteOrEmptySpace(state);


    }else{
      return showProgressIndicator();

    }
  }

  Widget displayRandomQuoteOrEmptySpace(state){

    var quotes = (state).quotes;
    if(quotes.length !=0){
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);

      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,

          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(quotes[randomQuoteIndex].quote),

            ],
            isRepeatingAnimation: true,
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      );

//(quotes[randomQuoteIndex].quote)
    }else{

      return Container();

    }
  }

  Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );

  }




  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);

    return Scaffold(

      backgroundColor:MyColors.myGery,
      body:CustomScrollView( // دا بيتيح ليا شويه حركات في عرض التفاصيل انها تطلع لحد فوق والكلمه تطلع لحد ال app bar  وكدا

      slivers: [
        buildSliverAppBar(),
         SliverList(delegate: SliverChildListDelegate(
           [
                // هنسق التفاصيل ال موجوده تحت الصوره
             Container(
               margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
               padding: const EdgeInsets.all(9),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // مهم جدا الملحوظه ال هنا في استعمال ال join لان البيانات ال راجعه من الوظائف عباره عن لسته وانا عايز اعرضهم بشكل معين يكون بينهم فواصل زي دي (/)
                      characterInfo('Job : ' , character.jobs.join('/')),
                      buildDivider(285),
                   characterInfo('Appeared in : ' , character.categoryForTwoSeries),
                   buildDivider(220),
                   characterInfo('Seasons : ' , character.apperanceOfSeasons.join('/')),
                   buildDivider(240),
                   characterInfo('Status : ' , character.statusIfDeadOrAlive),
                   buildDivider(260),
                   // هعمل شرط عشان لو الممثل مش مشترك في المسلسل التاني ميجيبش الحاجه فاضيه
                   character.betterCallSaulApperance.isEmpty ?
                   Container() :
                   characterInfo('Better Call Saul Seasons : ' , character.betterCallSaulApperance.join('/')),
                   character.betterCallSaulApperance.isEmpty ?
                   Container() :
                   buildDivider(150),
                   characterInfo('Actor/Actress : ' , character.acotrName),
                   buildDivider(205),
                   const SizedBox(height: 20,),

                   BlocBuilder<CharactersCubit , CharactersState>(builder: (context , state){

                     return checkIfQuotesAreLoaded(state);
                   })
                 ],
               ),
             ),
             const SizedBox(height: 400,)
           ]
         )) //  sliver list هي ال هتتحكم في المكونات ال تحت الصوره
      ],


      ) ,


    );
  }
}
