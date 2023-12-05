import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manage_my_horse/UI/Details/widget/drop_down.dart';
import 'package:manage_my_horse/UI/Details/widget/progeny_card.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';
import 'package:http/http.dart' as http;

import '../../../utils/search_header.dart';

class Progeny extends StatefulWidget {
  final int hId;
  const Progeny({super.key, required this.hId});

  @override
  State<Progeny> createState() => _ProgenyState();
}

class _ProgenyState extends State<Progeny> {

  late Future<void> fetchAllData;

  var horseName;
  List<dynamic> progenyData = [];
  List<dynamic> damData = [];

  var selectedItem ;

  final List<String> dropdownItems = ['1st Dam', '2nd Dam', ];

  void updateSelectedItem(String value) async{
    selectedItem = value;
    if(selectedItem =='2nd Dam') {
      id = 268;
    }
    else{
      id= widget.hId;
    }
    await fetchData();
    setState(() {

    });
  }

  var id;
  @override
  void initState() {
    super.initState();
    id=widget.hId;
    selectedItem = dropdownItems.first; // Set the default value
    fetchAllData = fetchData();

  }
  @override
  Widget build(BuildContext context) {



    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Progeny', style: titleTextStyle,),
        centerTitle: true,
        backgroundColor: appColors.appBarColor, iconTheme: IconThemeData(
        color: appColors.iconColor,
      ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.menu, color: appColors.iconColor,),
          )
        ],
      ),

      body: horseName!= null? SingleChildScrollView(
        child: Column(
          children: [
            SearchHeader(text: 'Horses —> $horseName'),
            const SizedBox(height: 10,),

            Container(
              color: appColors.contaienrHeaderColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: [
                    Align(alignment: Alignment.centerLeft ,child: Text('Dam Selection', style: bodyTextStyle,)),

                    Container(
                      width: size.width*1,
                      height: size.height*.11,
                      decoration: BoxDecoration(
                        border: Border.all(color: appColors.borderColor, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 30.0),
                          child: Center(child: CustomDropdown(text: selectedItem,
                            dropdownItems: dropdownItems,
                            onOptionSelected: updateSelectedItem,
                          )
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                    Container(
                        padding: const EdgeInsets.all(8.0),
                        width: size.width*1,
                        decoration: BoxDecoration(
                          border: Border.all(color: appColors.borderColor, width: 2),
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),

                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: progenyData.isNotEmpty ? progenyData.length : 1,
                          itemBuilder: (context, index) {
                            if (progenyData.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0,top: 8.0),
                                child: ProgenyCard(
                                  image: 'assets/images/Mack.png',
                                  name: progenyData[index]['name'],
                                  gender: progenyData[index]['gender'],
                                  colour: progenyData[index]['colour'],
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'No Progeny Found',
                                  style: bodyTextStyle,
                                ),
                              );
                            }
                          },
                        )

                    )


                  ],
                ),
              ),
            )
          ],
        ),
      ): Center(child: CircularProgressIndicator(),),
    );
  }


  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://mmh-dev.managemyhorse.co.nz/dev.01/001/horses/$id/progeny'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data.
      final data = jsonDecode(response.body);

      horseName= data['main_name'];

      // Clear the horseData list to avoid duplicating data
      progenyData.clear();

      // Iterate through the data and extract the required fields
      for (int i = 0; i < data['progeny'].length; i++) {



        final horse = data['progeny'][i];
        final name = horse['main_name']?? '';
        final gender = horse['gender']?? '';
        final colour = horse['colour']?? '';

        // Add the extracted data to the horseData list
        progenyData.add({
          'name': name,
          'colour': colour,
          'gender': gender,
        });

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
