import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manage_my_horse/UI/Details/widget/pedigree_container.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';
import 'package:http/http.dart' as http;

import '../../../utils/search_header.dart';
import '../main_detail.dart';

class Pedigree extends StatefulWidget {
  final int hId;
  const Pedigree({super.key, required this.hId});

  @override
  State<Pedigree> createState() => _PedigreeState();
}

class _PedigreeState extends State<Pedigree> {




  List<dynamic> horseData = [];
  var id;
  var horseName;




  @override
  void initState() {
    super.initState();
    id =widget.hId;
    fetchData();
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedigree', style: titleTextStyle,),
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

      body: horseName!= null ?  SingleChildScrollView(
        child: Column(
          children: [
            SearchHeader(text: 'Horses —> $horseName'),
            Container(
              height: size.height*.7,
              color: appColors.contaienrHeaderColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),

                child: Container(
                  height: size.height*.65,
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: appColors.borderColor, width: 2),
                    borderRadius:const  BorderRadius.all(Radius.circular(12)),
                  ),

                  child: Container(
                    height: size.height,
                    decoration: BoxDecoration(
                      color: appColors.textFieldColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child:SingleChildScrollView(
                      controller: ScrollController(initialScrollOffset: size.width/2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0, count = 1; i < horseData.length; i += count, count *= 2)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                  color: appColors.navBarColor.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    for (int j = i; j < i + count && j < horseData.length; j++)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: PedigreeContainer(
                                          name: horseData[j]['name'],
                                          breedAbvr: horseData[j]['breed_abvr'],
                                          colour: horseData[j]['colour'],
                                          breedingSeason: horseData[j]['breeding_season'],

                                          color: horseData[j]['gender'] == 'Stallion' || horseData[j]['gender'] == 'Gelding' ? const  Color(0xffB7EAFF).withOpacity(.74): const Color(0xffFFBFBF).withOpacity(.85) ,
                                          onTap: () async {
                                            id = horseData[j]['id'];
                                            print(id);
                                            if(horseData[j]['name']!= 'Unknown') {
                                              await Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainDetail(id: id!)),
                                              );
                                            }

                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                  ),
                ),
              ),
            )

          ],
        ),
      ): Center(child: CircularProgressIndicator(),),
    );
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://mmh-dev.managemyhorse.co.nz/dev01/001/horses/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      horseName= data['main_name'];
      horseData.clear();

      // Iterate through the data and extract the required fields
      for (int i = 0; i < min(data['pedigree'].length, 15); i++) {
        final horse = data['pedigree'][i];
        final name = horse['name'] ?? '';
        final horseId = horse['id']?? '';
        final colour = horse['colour']?? '';
        final breedAbrv = horse['breed_abrv'] ?? '';
        final breedingSeason = horse['breeding_season']?? '';
        final gender = horse['gender']?? '';

        // Add the extracted data to the horseData list
        horseData.add({
          'name': name,
          'id': horseId,
          'colour': colour,
          'breed_abrv': breedAbrv,
          'breeding_season': breedingSeason,
          'gender': gender,
        });
      }


      if(mounted){
        setState(() {});
      }


    } else {
      // If the server returns an error, throw an exception.
      throw Exception('Failed to load data');
    }
  }

}


