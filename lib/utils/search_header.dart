import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';

class SearchHeader extends StatelessWidget {
  final String text;
  const SearchHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*.08,
      color: appColors.contaienrHeaderColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Container(
              padding: EdgeInsets.only(left: 20),
              width: size.width*.80,
              height: size.height*.06,
              decoration: BoxDecoration(
                color: appColors.textFieldColor,
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: Align(alignment: Alignment.centerLeft,child: Text(text,style: TextStyle(color: Color(0xffCCBEB4).withOpacity(.49), fontSize: 15, fontWeight: FontWeight.w400 ))),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(Icons.search, color: Color(0xff8C7A6B),),
          // ),

        ],
      ),

    );
  }
}
