import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manage_my_horse/UI/Details/screens/detail_screen.dart';
import 'package:manage_my_horse/UI/Details/screens/pedigree_screen.dart';
import 'package:manage_my_horse/UI/Details/screens/progeny_screen.dart';
import 'package:manage_my_horse/UI/Details/screens/registrations_screen.dart';
import 'package:manage_my_horse/utils/colors.dart';

class MainDetail extends StatefulWidget {
  final int id;
  const MainDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<MainDetail> createState() => _MainDetailState();
}

class _MainDetailState extends State<MainDetail> {
  int _current=0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final pages= [
      Details(hId: widget.id),
      Registrations(hId: widget.id),
      Pedigree(hId: widget.id),
      Progeny(hId: widget.id),
    ];
    var size= MediaQuery.of(context).size;
    return  Scaffold(
      body: Builder(
          builder: (context){
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CarouselSlider(items: pages, options: CarouselOptions(
                    height: size.height*.90,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
                  ),
                    carouselController: _controller,
                  ),
              
              
                  DotIndicator(dotCount: pages.length, selectedDotIndex: _current,
                    onDotTapped: (index) {
                    setState(() {
                      _controller.animateToPage(index);
                      _current = index;
                    });
                  },)
                ]),
            );
          },

      ),
    );
  }
}




class DotIndicator extends StatefulWidget {
  final int dotCount;
  final int selectedDotIndex;
  final ValueChanged<int> onDotTapped;

  const DotIndicator({
    Key? key,
    required this.dotCount,
    required this.selectedDotIndex,
    required this.onDotTapped,
  }) : super(key: key);

  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant DotIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.dotCount, (index) {
        return GestureDetector(
          onTap: () {
            widget.onDotTapped(index);
          },
          child: Dot(
            isSelected: index == widget.selectedDotIndex,
            animationValue: _controller.value,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final bool isSelected;
  final double animationValue;

  const Dot({super.key, required this.isSelected, required this.animationValue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: appColors.containerColor,
                width: 2.0,
              ),
            ),
          ),
        ),
        if (isSelected)
          Center(
            child: Container(
              margin: const EdgeInsets.all(11.0),
              width: 8.0,
              height: 8.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffDDCFC4), // Change the selected item color to blue (you can replace it with your desired color)
              ),
            ),
          ),
      ],
    );
  }
}