import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';


class containerButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onPress;

  const containerButton({Key? key, required this.image, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(3),
        height: size.height*.15,
        width: size.width*.4,
        decoration: BoxDecoration(
          border: Border.all(color: appColors.borderColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12),
          )
        ),
        child: Container(
          decoration: BoxDecoration(
              color: appColors.buttonColor,
              borderRadius: BorderRadius.all(Radius.circular(8),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Image.asset(image),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(text, style: containerButtonTextStyle,),

                   Icon(Icons.arrow_forward),
                 ],
               )
             ],
            ),
          ),
        ),
      ),
    );
  }
}
