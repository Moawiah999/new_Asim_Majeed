import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';


class ProgenyCard extends StatelessWidget {
  final String image;
  final String name;
  final String gender;
  final String colour;

  const ProgenyCard({
    super.key,
    required this.image,
    required this.name,
    required this.gender,
    required this.colour,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.12,
      decoration: BoxDecoration(
        color: appColors.containerColor.withOpacity(0.17),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: size.width * 0.18,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                color: appColors.containerColor.withOpacity(0.17),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Image.asset(image),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: cardNameTextStyle, overflow: TextOverflow.ellipsis,),
                  Text(gender, style: cardBodyTextStyle),
                  Text(colour, style: cardBodyTextStyle),
                ],
              ),
            ),
            SizedBox(
              height: 25,
              width: 25,
              child: Container(
                child: Image.asset('assets/icons/notification.png', color: Color(0xff33312F)),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: appColors.containerColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
