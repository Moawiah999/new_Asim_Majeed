import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';

class Button extends StatelessWidget {
  final String image;
  final String name;
  final String gender;
  final String age;
  final String breed;
  final VoidCallback onPress;

  const Button({
    super.key,
    required this.image,
    required this.name,
    required this.age,
    required this.gender,
    required this.breed,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: size.width * 1,
        height: size.height * 0.09,
        decoration: BoxDecoration(
          color: appColors.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added this line
            children: [
              Container(
                width: size.width * 0.1,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  color: appColors.containerColor.withOpacity(0.17),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.asset(image),
              ),
              SizedBox(width: 15,),

              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '$name\n',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: breed,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Jaldi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),

              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '$gender\n',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Jaldi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: age,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Jaldi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              SizedBox(
                height: 25,
                width: 25,
                child: Container(
                  child: Image.asset(
                    'assets/icons/notification.png',
                    color: Color(0xff33312F),
                  ),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: appColors.containerColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
