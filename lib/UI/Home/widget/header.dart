import 'package:flutter/material.dart';
import '../../../utils/text.dart';
import 'package:manage_my_horse/utils/colors.dart';


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*.25,
      decoration: BoxDecoration(
          gradient:appColors.headerrColor
      ),
      child:  Center(
        child: SizedBox(
          height: size.height * .20,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: appColors.borderColor, width: 2),
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/funnySmile.jpg'),
              radius: 80,
            ),
          ),
        ),
      ),
    );
  }
}
