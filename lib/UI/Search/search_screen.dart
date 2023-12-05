import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manage_my_horse/UI/Details/main_detail.dart';
import 'package:manage_my_horse/UI/Search/Widget/button.dart';
import 'package:manage_my_horse/utils/colors.dart';
import 'package:manage_my_horse/utils/text.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Map<String, dynamic>> horses = [];
  List<dynamic> horseData = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: appColors.iconColor,
        ),
        title: Text(
          'Search',
          style: titleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: appColors.appBarColor,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _searchController.clear();
            });
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: size.height * .08,
                      color: appColors.contaienrHeaderColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * .06,
                            width: size.width * .80,
                            padding: const EdgeInsets.only(left: 20),
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              onChanged: (value) {
                                if (value.length >= 3) {
                                  searchQuery(value);
                                } else {
                                  horses.clear();
                                  horses.add({'name': 'No Result'});
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'name reg.no ueln microchip',
                                hintStyle: TextStyle(
                                    color: const Color(0xffCCBEB4)
                                        .withOpacity(.49),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 18.0),
                                // Adjust padding as needed
                                alignLabelWithHint: true,
                                fillColor: appColors.textFieldColor,
                                // Set the background color here
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Set the border radius here
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  // Remove the default border
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  // Remove the default border
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Color(0xff8C7A6B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        width: size.width * .9,
                        height: size.height*.7,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: appColors.borderColor, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: horseData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                                child: Button(
                                  image: 'assets/images/Mack.png',
                                  name: horseData[index]['name']?? '',
                                  age: horseData[index]['age']?? '',
                                  gender: horseData[index]['gender']?? '',
                                  breed: horseData[index]['breed']?? '',
                                  onPress: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainDetail(
                                              id: horseData[index]['id']))),
                                ),
                              );
                            }))
                  ],
                ),
                Visibility(
                  visible: _searchController.text.length > 0,
                  child: Positioned(
                    top: size.height * .08,
                    left: size.width * .06,
                    child: Container(
                      width: size.width * .75,
                      height: size.height * .3,
                      decoration: BoxDecoration(
                          color: appColors.textFieldColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: horses.length,
                        itemBuilder: (context, index) {
                          final horse = horses[index];
                          return GestureDetector(
                            onTap: () {
                              if (horse['id'] != null) {
                                _searchController.clear();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainDetail(id: horse['id'])));
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 8.0),
                              child: Text(
                                capitalize(horse['name']),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            // Add any other information you want to display
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchQuery(String query) async {
    final response = await http.get(Uri.parse(
        'https://mmh-dev.managemyhorse.co.nz/dev.01/001/horses/search?query=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        int count = 0;
        for (var item in data) {
          if (count < 10) {
            horses.add({
              'name': item['main_name'],
              'id': item['id'],
            });
            count++;
          }
        }
      } else {
        horses.add({'name': 'No Result'});
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://mmh-dev.managemyhorse.co.nz/dev.01/001/lists/1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      horseData.clear();
      for (int i = 0; i < 8; i++) {
        final horse = data['horses'][i];
        final id = horse['id'] ;
        final horseName = horse['main_name'];
        final gender = horse['gender'];
        final breed = horse['breed'];
        final dob = horse['dob'];
        final age;
        if (dob != null) {
          final DateTime birthDate = DateFormat('yyyy').parse(dob);
          final DateTime now = DateTime.now();
          age = '${birthDate.year} ${now.year - birthDate.year} y/o';
        } else {
          age = '';
        }

        horseData.add({
          'id': id,
          'name': horseName,
          'gender': gender,
          'breed': breed,
          'age': age
        });
      }

      if (mounted) {
        setState(() {});
      }
    }
  }

  String capitalize(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }

    List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    return words.join(' ');
  }
}
