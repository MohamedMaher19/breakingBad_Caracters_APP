import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/models/quotes.dart';
import 'package:breaking_bad/data/repositry/characters_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

  final CharactersRepository charactersRepository ;
  List <Character> characters = []; // هعمل المتغير ال من النوع ليست دا عشان حفظ فيه البيانات ال جايه من الريبورزتري

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());


  // هنا عمل الفنكشن ال هستقبل فيها البيانات ال جايه من الريبوزتري

  List<Character> getAllCharacters(){

charactersRepository.getAllCharacters().then((characters) { // هنا بقوله بعد ما جبت الداتا هعمل ايه بقي عشان كدا استعملت .then
  emit(CharactersLoaded(characters)); //  هنا بعمل تشغيل لل state ال كنت عملتها ف ملف الاستيت وكنت عمل جواها المتغير characters
  this.characters = characters ; // هنا بقوله ان المتغير ال عملته فوق خليته يساوي ال كاركترز ال موجوده جوا الفانكشن ال فيها البيانات ال جايه من الريبوزتري

});
// وبعدين عملتلها ريتيرن تحت اهوه
return characters;
  }

// وفي الاخير كدا الفانكشن ال عملناها في الكيوبت بقت جاهزه اناها تكلم ال ui وتبعتله البيانات
// ولكن في البدايه هروح لصفحه app router عشان استعمل فيها ال blocProviderr واعمل خلق للكيوبت داخل الاسكرين ال انا هستعملها
// يلا بينا علي شاشة ال app router

//------------------------------------------------------------------------------
void getQuotes(String charName){

  charactersRepository.getCharacterQuotes(charName).then((quotes) {
    emit(QuotesLoaded(quotes));
     });
    }
  }