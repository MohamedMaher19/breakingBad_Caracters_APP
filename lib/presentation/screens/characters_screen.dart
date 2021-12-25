import 'package:breaking_bad/buisness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {

   late List<Character> allCharacters; // دي لسته فاضيه هستعملها في تخزين البيانات ال هتيجي
   late List<Character> searchedForCharacters; //  دي لسته ال حط فيها العناصر ال انا هعمل search عليها
   bool _isSearching = false ; // عشان اتحكم انا بعمل سيرش وال لا
   final _searchTextController = TextEditingController(); // الكونترولر دا ال هكتب فيه السيرش وهاخد منه الداتا ال هتتكتب جواه

 Widget _buildSearchField(){
   return TextField( // كل الاستايلز دول للمربع بتاع الكتابه ذات نفسه
     controller:_searchTextController ,
     cursorColor:MyColors.myGery ,
     decoration: const InputDecoration(
       hintText: 'Find a Character....',
       border: InputBorder.none,
       hintStyle: TextStyle(color: MyColors.myGery , fontSize: 18),

     ),
     style: TextStyle(color: MyColors.myGery , fontSize: 18 ),// الاستايل دا هيبقي للكتابه ذات نفسها لما بقي هيبدا يكتب او يغير فيها
     onChanged:(searchedCharacter){
     addSearchedForItemsToSearchedList(searchedCharacter) ;      //   الفانكشن دي وظيفتها انها هتشوف الحرف ال اليوزر دخله المتمثل في searchedCharacterال انا باصيته للفانكشن وتشوف الايتمز ال بيبداو بالحرف دا

     } ,
   );
 }
 void addSearchedForItemsToSearchedList(String searchedCharacter ){

   searchedForCharacters = allCharacters.where((character) => character.name.toLowerCase().startsWith(searchedCharacter)).toList();
   setState((){


   });

 }

 List<Widget> _buildAppBarActions(){    // عايز اظبط الشكل ال هيظهرلي لو انا بعمل سيرش او مش بعمل سيرش باستعمال الفانكشن دي

if (_isSearching){

  return[
    IconButton(onPressed: (){

      _clearSearch(); // بستدعي الفانكشن دي من تحت وهي بتفضي مكان الكتابه لما بضغط علي زرار الاكس
      Navigator.pop(context); // لما هضغط علي الاكس هيرجعلي للقايمه الاصليه بتاعتي
    },
        icon: Icon(Icons.clear , color: MyColors.myGery,))
  ];
}else{
return [
  IconButton(onPressed: _startSearch,
      icon: Icon(Icons.search , color: MyColors.myGery,))

];
}

 }
// اهم حته في السيرش
 void _startSearch(){ // السطر دا بقول للبرنامج كأني روحت ل صفحه تانيه عشان كدا عمال زرار ال back لوحده كأنه عمل route جديد
   ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching)); // وكمان هيمسحلي ال نا كنت كاتبه لما بضغط علي ال x

  setState(() {
  _isSearching= true ; // لان انا دلوقت بعمل سيرش فا هخليها ب true
});
 }
 void _stopSearching(){

   _clearSearch();
   setState(() {
     _isSearching = false; // عشان يرجعلي الايكون تاني بعد ماكنت بسيرش
   });
 }

 void _clearSearch(){

   setState(() {
     _searchTextController.clear(); // بمسح الداتا ال انا كنت كتبتها عشان اعمل سيرش لاني خلاص هوقف السيرش وهخرج وساعه الخروج بقوله امسح الداتا
   });

 }





   @override
  void initState() {
    super.initState();
     BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    // في السطر دا كدا ال ui بيطلب من الكيوبت انه يعطيه الداتا يقوم البوفايدر شغال ومصحي ال بلوك ال هو عمله فوق الاسكرينه
     // لانه اصلا بيبقي lazy لحد ما حد يطلبه فا خليت البروفايدر يوصل لل charactercubit  ومنها دخل لل getAllCharacters ال فيه الداتا
  }


  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>( // هستعمل البلوك بيلدر ال انا صحيته عن طريق سطر الكود ال كتبته بتاع ال بلوك بروفايدر
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
              // في حاله ان الاستيت لودد اذا هخلي المتغير ال انا عامله فوق يساوي ال characters
          // ال موجوده في ال state بتاع البلوك ال هي اصلا جواها البيانات كلها

          return buildLoadedListWidgets(); // لو الاستيت لودد أذا هرجع الفانكشن ال هتعبر عن اللست بتاع الكاركترز  دي وطبعا هعملها في مكان تاني عشان يبقي الدنيا مرتبه

        } else {
          return showLoadingIndicator();
        }
      },
    );
  }
  Widget showLoadingIndicator(){
     return Center(child: CircularProgressIndicator(
       color: MyColors.myYellow,
     ),);
  }

  Widget buildLoadedListWidgets(){
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGery,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }


  Widget buildCharactersList(){

     return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 2/3,
       crossAxisSpacing: 1,
       mainAxisSpacing: 1,
     ),
         shrinkWrap:true ,
         physics: const ClampingScrollPhysics(),
         padding: EdgeInsets.zero,
         // حل مشكله عدم تفعيل السيرش اني عملت شرط للايتمز ال هترجع لان عندي نوعين .. يا اما هترجع اللسته كامله يا اما هترجع اللسته لما عملت فلتره
         itemCount:_searchTextController.text.isEmpty ? allCharacters.length : searchedForCharacters.length,
         itemBuilder: (ctx , index){

       return CharacterItem( // دا كلاس عملته في ويدجت لوحده فيه تفاصيل الشخصيه الواحده هتظهر ف الصفحه الرءيسيه ازاي
         character:_searchTextController.text.isEmpty ? allCharacters[index] : searchedForCharacters[index],);
     });

  }



  Widget _buildAppBarTitle(){

   return const Text(
     'Characters',
     style: TextStyle(color: MyColors.myGery),

   );

  }


  Widget buildNoInternetWidget(){

   return Center(
     child: Container(
       color: Colors.white,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SizedBox(
             height: 20,
             
           ),
           Text(
             'Can\'t connect ... check your internet',
             style: TextStyle(
               fontSize: 20,
               color: MyColors.myGery,
             ),
           ),
           Image.asset('assets/images/nointernet.png')
         ],
       ) ,
     ),
   );
   
  }

  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching ? BackButton(color: MyColors.myGery,) : Container() ,// عشان اغير لون السهم ال بيرجع ورا
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(), // يا اما هيعرض الكلمه بتاع ال character  او هيعرض ال field ال انا هعمل سيرش فيه
        actions: _buildAppBarActions(), // هيعرض الايكن بتاع السيرش او الايكون بتاع ال x

        ),

      body: OfflineBuilder(
        connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
          ) {

        final bool connected = connectivity != ConnectivityResult.none;
        if (connected){
          return  buildBlockWidget();

        }else{

          return buildNoInternetWidget();
        }

      },
        child:showLoadingIndicator(),
      ),


      //
    );
  }
}

