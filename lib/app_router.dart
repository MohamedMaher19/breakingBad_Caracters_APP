import 'package:breaking_bad/buisness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/repositry/characters_repository.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import 'package:breaking_bad/presentation/screens/characters_details_screen.dart';
import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    // الفانكشن generateRoute دي المسؤله عن الراوتنج
    // وعملت اوبجكت من الكلاس ال اسمه AppRouter في صفحه ال main عشان اقدر اوصل للفانكشن ال موجوده هنا

    switch (settings.name) {

      case charactersScreen: // في حاله دي هيحصل بيلد لل كلاس بتاع ال CharactersScreen()
        return MaterialPageRoute(
          builder: (_) => BlocProvider( // هنا حطيت البلوك بروفايدر اول حاجه في ال tree عشان اقدر استعمل ال كاركتر كيوبت ال انا عملته
            create: (BuildContext contxt) =>
                CharactersCubit(charactersRepository),
            child: CharactersScreen(),
          ),

        );

      case characterDetailsScreen:        // في حاله دي هيحصل بيلد لل كلاس بتاع ال CharacterDetilsScreen()

      final character = settings.arguments as Character ; // عملت متغير عشان اباصيه للصفحه ال هتعرض تفاصيل الشخصيه وخليته يساوي arguments ال موجوده في الموديل ال انا عامله ال فيه التفاصيل كلها

        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (BuildContext contxt) =>
              CharactersCubit(charactersRepository) ,
            child: CharacterDetilsScreen(character: character,),
          // بباصي للصفحه بتاع عرض الشخصيه لواحدها المتغير ال اسمه كاركتر ال هو اصلا اوبجكت من الموديل الكبير لاني هستخدمه في صفحه character item مع ال Inkwell
        // وكمان هروح للصفحه بتاع ال character item عشان اظبط حته ان لما اضغط علي الشخصيه ايه ال هيحصل باستعمال ال InKwell
        ));
    }
  }
}

