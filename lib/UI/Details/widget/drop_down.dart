import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';

import '../../../utils/text.dart';

class CustomDropdown extends StatelessWidget {
  final String text;
  final List<String>? dropdownItems;
  final Function(String)? onOptionSelected;


  const CustomDropdown({Key? key, required this.text, this.dropdownItems, this.onOptionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.08,
      padding: const EdgeInsets.fromLTRB(3.0, 3.0, 10.0, 3.0),
      decoration: BoxDecoration(
        border: Border.all(color: appColors.borderColor, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              decoration: BoxDecoration(
                color: appColors.textFieldColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(text, style: textFieldTextStyle),
              ),
            ),
          ),
          Transform.rotate(
            angle: -90 * 3.141592653589793 / 180,
            child: PopupMenuButton<String>(
              color: appColors.containerColor,
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: appColors.iconColor),
              itemBuilder: (BuildContext context) {
                return dropdownItems!.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item, style: bodyTextStyle,),
                  );
                }).toList();
              },
              onSelected: (String value) {
                if (onOptionSelected != null) {
                  onOptionSelected!(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}
