import 'package:flutter/material.dart';
import 'package:manage_my_horse/UI/Home/widget/container_button.dart';
import 'package:manage_my_horse/UI/Home/widget/header.dart';
import 'package:manage_my_horse/UI/Search/search_screen.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List <Map<String, String>> buttonContent=[
    {'image': 'assets/icons/award.png', 'text': 'Awards'},
    {'image': 'assets/icons/food.png', 'text': 'Food'},
    {'image': 'assets/icons/health.png', 'text': 'Health'},
    {'image': 'assets/icons/photo.png', 'text': 'Photos'},
  ];
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: titleTextStyle,),
        centerTitle: true,
        backgroundColor: appColors.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),

            Text('Paula Brocklehurst', style: H1TextStyle,),

            Text('paula@gmmh.co.nz', style: TextStyle(color: Color(0xffE5D7CB), fontSize: 12),),

            SizedBox(height: 20,),


            Container(
              width: size.width*.9,
              height: size.height*.4,
              decoration: BoxDecoration(
                color: appColors.containerColor.withOpacity(0.17),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      containerButton(image: 'assets/icons/award.png', text: 'Awards', onPress: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search()))),
                      containerButton(image: 'assets/icons/food.png', text: 'Food', onPress: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search())))
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      containerButton(image: 'assets/icons/health.png', text: 'Health',onPress: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search()))),
                      containerButton(image: 'assets/icons/photo.png', text: 'Photos', onPress: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search())),),
                    ],
                  )
                ],
              )
            ),

            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.all(3),
              height: size.height*.08,
              width: size.width*.8,
              decoration: BoxDecoration(
                border: Border.all(color: appColors.borderColor,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search()));
                },
                child: Text('Membership',style: buttonTextStyle,),
                style: ElevatedButton.styleFrom(backgroundColor: appColors.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))
                )),
              ),
            ),
            SizedBox(height: 10,),


            Container(
              padding: EdgeInsets.all(3),
              height: size.height*.08,
              width: size.width*.8,
              decoration: BoxDecoration(
                border: Border.all(color: appColors.borderColor,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search()));
                },
                child: Text('My Horses',style: buttonTextStyle,),
                style: ElevatedButton.styleFrom(backgroundColor: appColors.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))
                )),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
