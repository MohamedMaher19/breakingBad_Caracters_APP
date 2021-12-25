 class Character {
late int charId ;
late String name ;
late String nickName ;
late String image ;
late List <dynamic> jobs;
late String statusIfDeadOrAlive ;
late List <dynamic> apperanceOfSeasons ;
late String acotrName ;
late String categoryForTwoSeries;
late List<dynamic>betterCallSaulApperance ;

Character.fromJson(Map<String , dynamic>json ){


  charId = json["char_id"];
  name = json["name"];
  nickName = json["nickname"];
  image = json["img"];
  jobs = json["occupation"];
  statusIfDeadOrAlive = json["status"];
  apperanceOfSeasons = json["appearance"];
  acotrName = json["portrayed"];
  categoryForTwoSeries = json["category"];
  betterCallSaulApperance = json["better_call_saul_appearance"];







}

 }