import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manage_my_horse/UI/Details/widget/text_field.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../utils/search_header.dart';

class Details extends StatefulWidget {
  final int hId;
  const Details({super.key ,required this.hId});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  var horseName;
  var sireName;
  var damName;
  var colour;
  var gender;
  var age;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        title: Text('Details', style: titleTextStyle,),
        centerTitle: true,
        backgroundColor: appColors.appBarColor,
        iconTheme: IconThemeData(
          color: appColors.iconColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.menu, color: appColors.iconColor,),
          )
        ],
      ),

      body: horseName != null ? SingleChildScrollView(
        child: Column(
          children: [
            SearchHeader(text: 'Horses —> $horseName',),
            const SizedBox(height: 10,),
            Container(
              color: appColors.contaienrHeaderColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: size.height * .15,
                        child: CircleAvatar(
                          backgroundColor: appColors.borderColor,
                          radius: 80,
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/images/Mack.png'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),

                    Text('Name', style: bodyTextStyle,),
                    customTextField(text:horseName ?? ''),

                    const SizedBox(height: 10,),

                    Text('Sire', style: bodyTextStyle,),
                    customTextField(text: sireName?? ''),

                    const SizedBox(height: 10,),

                    Text('Dam', style: bodyTextStyle,),
                    customTextField(text: damName ?? ''),

                    const SizedBox(height: 10,),

                    Text('Age', style: bodyTextStyle,),
                    customTextField(text: '$age years' ?? ''),

                    const SizedBox(height: 10,),

                    Text('Colour', style: bodyTextStyle,),
                    customTextField(text: colour ?? ''),

                    const SizedBox(height: 10,),

                    Text('Gender', style: bodyTextStyle,),
                    customTextField(text: gender! ?? ''),

                    const SizedBox(height: 10,),

                  ],
                ),
              ),
            )


          ],
        ),
      ): const Center(child: CircularProgressIndicator(),)
    );
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://mmh-dev.managemyhorse.co.nz/dev01/001/horses/${widget.hId}'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final data = jsonDecode(response.body);
      horseName=data['main_name']?? '';
      colour= data['colour']?? '';
      sireName = data['sire'] != null ? data['sire']['main_name'] ?? '' : '';
      // Check if the 'dam' property exists before accessing the 'main_name' property
      damName = data['dam'] != null ? data['dam']['main_name'] ?? '' : '';
      gender= data['gender']?? '';
      final dob=data['dob'];

      if(dob !=null) {
        final DateTime birthDate = DateFormat('yyyy').parse(data['dob']);
        final DateTime now = DateTime.now();
        age = now.year - birthDate.year;
      }else{
        age= '';
      }
      if(mounted){
        setState(() {
        });
      }

    } else {
      // If the server returns an error, throw an exception.
      throw Exception('Failed to load data');
    }
  }

}
