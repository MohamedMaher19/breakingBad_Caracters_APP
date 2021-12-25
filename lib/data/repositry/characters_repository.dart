import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/models/quotes.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import 'package:flutter/material.dart';

class CharactersRepository{

   final CharactersWebServices charactersWebServices ;

  CharactersRepository(this.charactersWebServices);

// عملت اوبجكت من الويب سيرفيس عشان اوصل للفانكشن ال فيه ال موجود فيها البيانات ال انا جبتها من النت
  // وبعد كدا باصيت الاوبجكت دا جوا الكونستركتر -----  وقمت عامل فانكشن getAllCharacters  ال نوعها ليست من النوع كاركتر ال كنت عامله في ال Model وجواها قمت حافظ البيانات ال جيت دي جوا متغير اسمه كاركتر
  // ثم في اخر سطر عملت للبيانات دي مابنج ورجعتها وبقت محفوظه جوا الفانكشن ال اسمها جت اوول كاركتر عشان هباصيها هناك لل كيوبت
   Future<List<Character>> getAllCharacters() async {

     final characters = await charactersWebServices.getAllCharacters();

     return characters.map((character) => Character.fromJson(character)).toList(); // هعمل ماابنج للبيانات ال جوال characters ونوع المابنج هو endpoint وهخليها تتوافق مع ال Character  ال ناا عملتها ف الموديل


   }

  Future<List<Quote>> getCharacterQuotes(String charName) async {

    final quotes = await charactersWebServices.getCharacterQuotes(charName);

    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();


  }

   }