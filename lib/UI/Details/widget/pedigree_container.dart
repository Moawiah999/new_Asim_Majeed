import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';

class PedigreeContainer extends StatelessWidget {
  final String name;
  final String? colour;
  final String? breedAbvr;
  final String? breedingSeason;
  final VoidCallback onTap;
  final Color color;
  const PedigreeContainer({super.key, required this.name, this.colour, this.breedAbvr, this.breedingSeason, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: appColors.borderColor, width: 2),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(name, style: detailTextTextStyle,),
                const SizedBox(height: 5,),
                const DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                const SizedBox(height: 5,),

                if(breedAbvr !=null)
                  Text(breedAbvr!, style: detailTextTextStyle,),
                if(colour != null)
                  Text(colour!, style: detailTextTextStyle,),
                if(breedingSeason!=null)
                  Text(breedingSeason!, style: detailTextTextStyle,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
