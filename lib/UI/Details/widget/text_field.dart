import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';

class customTextField extends StatelessWidget {
  final String text;
  const customTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*.08,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(color: appColors.borderColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12),
          )
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
            color: appColors.textFieldColor,
            borderRadius: BorderRadius.all(Radius.circular(8),
            )
        ),
        child: Align(alignment: Alignment.centerLeft,child: Text(text, style: textFieldTextStyle,)),
      ),
    );
  }
}
