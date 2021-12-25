import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/constants/strings.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:flutter/material.dart';


// الشغل هنا كله للشكل بتاع الشخصيه الواحده ال هتتكرر في باقي الشخصات


class CharacterItem extends StatelessWidget {
  final Character character;
      // هاخد هنا اوبجيكت من الموديل ال كنت عامله ال فيه كل التفاصيل ال المفروض هجيبها زي الاسم وال id والمسلسل وكدا

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell( // استعملت الانكويل عشان استغل ال on tap لما هضغط علي صورة الشخصيه يدخلني جوا ويظهر التفاصيل للشخصيه
        onTap: ()=> Navigator.pushNamed(context, characterDetailsScreen , arguments: character),
        child: GridTile( // للاطار الواحد للشخصيه الواحده
          child: Hero(
            tag:character.charId , // الهيرو بيحتاج حاجه يونيك عشان كدا استعملت معاه ال char id للممثلين
            child: Container(
              color: MyColors.myGery,
              child: character.image.isNotEmpty? // حالة شرطيه يعني لو مكنش دي هنعمل دي
                  FadeInImage.assetNetwork(     // علي بال ما الصوره تحمل .. حملي الصوره بتاع الانتظار للتحميل ال نا جايبها من ع النت

                  width: double.infinity,
                      height: double.infinity,
                      placeholder:'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,)

                  : Image.asset(
                      'assets/images/tiger.jpg',
                    ),
            ),
          ),
          footer: Container( // الاسم ال هيبقي مكتوب بتاع الشخصيه وشويه تظبيط ليه وللخلفيه بتاعته
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text('${character.name}', style: TextStyle(
              height: 1.3,
              fontSize: 17,
              color: MyColors.myYellow,
              fontWeight: FontWeight.bold,

            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
