import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manage_my_horse/UI/Details/widget/drop_down.dart';
import 'package:manage_my_horse/UI/Details/widget/text_field.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/search_header.dart';
import 'package:manage_my_horse/utils/text.dart';
import 'package:http/http.dart' as http;

class Registrations extends StatefulWidget {
  final int hId;
  const Registrations({super.key, required this.hId});

  @override
  State<Registrations> createState() => _RegistrationsState();
}

class _RegistrationsState extends State<Registrations> {
  var horseName;
  var ueln;
  var microChipNo;


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
        title: Text('Registration', style: titleTextStyle,),
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

      body: ueln !=null ? SingleChildScrollView(
        child: Column(
          children: [
            SearchHeader(text: 'Horses —> $horseName'),
            const SizedBox(height: 10,),

            Container(
              color: appColors.contaienrHeaderColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registrar', style: bodyTextStyle,),
                    SizedBox(
                        width: size.width*.85,
                        child: const CustomDropdown(text: 'New Zealand Warmblood Assoc.',)),
                    const SizedBox(height: 10,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: appColors.borderColor, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 30.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name', style: bodyTextStyle,),
                            const customTextField(text: 'New Zealand Warmblood Assoc.'),
                            const SizedBox(height: 10,),

                            Text('Reg No', style: bodyTextStyle,),
                            const customTextField(text: '318217 D'),
                            const SizedBox(height: 10,),

                            Text('Register', style: bodyTextStyle,),
                            const customTextField(text: 'New Zealand Warmblood Derivative'),
                            const SizedBox(height: 10,),

                            Text('UELN NO', style: bodyTextStyle,),
                            customTextField(text: ueln ?? ''),
                            const SizedBox(height: 10,),

                            Text('Microchip No', style: bodyTextStyle,),
                            customTextField(text: microChipNo?? ''),
                            const SizedBox(height: 10,),

                            Text('DNA Profile', style: bodyTextStyle,),
                            const customTextField(text: 'Not on file'),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    )

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

      horseName= data['main_name'] ?? '';
      ueln=data['ueln_number'] ?? '';
      microChipNo= data['microchip_number']?? '';


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
