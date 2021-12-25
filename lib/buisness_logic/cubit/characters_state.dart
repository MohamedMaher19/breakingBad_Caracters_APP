part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
// بعمل هنا كلاسز كل كلاس يعبر عن ال state بتاعتي
// اي كلاس عايز يبقي state لازم يورث من CharactersState  زي السطر رقم 9 ودا البلوك عاملهولي لوحده اول ماعملت ملف للكيوبت
class CharactersLoaded extends CharactersState{

  final List<Character> characters;

  CharactersLoaded(this.characters);// كدا الكونستراكتور دا جواه الليسته ال اسمها character ... طيب الليسته دي هجيبها منين بقي ؟
// اللسته دي هعملها في الملف التاني بتاع ال cubit
}
// اقدر اعمل state تانيه باي حاله تانيه انا عايزها لو مثلا حصل ايرور


class QuotesLoaded extends CharactersState { // معملتش كيوبت جديد لان الموضوع مش مستاهل ف عملت في نفس الكيوبت

  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}