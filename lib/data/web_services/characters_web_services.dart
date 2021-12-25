import 'package:breaking_bad/constants/strings.dart';
import 'package:dio/dio.dart';
// هجيب البيانات من ال Api
class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      //     هنا هعمل تظبيط للاوبشنز بتاع الدايو عشان لو الداتا اتاخرت مثلا وا حصل اي حاجه وهحفظ الاعدادات دي داخل options

      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options); // هبعت الاوبشنز لل دايوو
  }

  // هكلم بقي السيرفر واقوله ابعتلي البيانات ال انا هحدد الاند بوينت بتاعتها ال اسمها character

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');

      print(response.data.toString());

      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  Future<List<dynamic>> getCharacterQuotes(String charName) async { // هنا حطيت متغير اسمه charname داخل الاقواس لاني هحتاج احدد مين الشخصيه صاحبة كل مقوله
    try {
      Response response = await dio.get('quote' , queryParameters: {'author': charName} ); // استعملت الطريقه دي بعكس ال فوق لانني في ال Api دا موجود علامه ؟ ال هي معناها ان في query ف لازم استعمل الطريقه دي عشان احدد انهي query موجوده لان ممكن يكون في اكتر من query

      print(response.data.toString());

      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
