import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Country {
  final int id;
  final String name;
  final String flagUrl;
  final String imageUrl;

  Country({
    required this.id,
    required this.name,
    required this.flagUrl,
    required this.imageUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      flagUrl: json['flag'],
      imageUrl: json['image'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final response = await http.get(
      Uri.parse('https://studylancer.yuktidea.com/api/select/country'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 50|SAmMJXQJERbxRn9kXudYIU0bBzSrL9f225trNbKk5270d1we',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final countriesData = responseData['data']['countries'];
      setState(() {
        print('loaded');
        countries = countriesData.map<Country>((countryData) => Country.fromJson(countryData)).toList();
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#292929'),
      body: Container(
        padding: EdgeInsets.only(top: 50, right: 25, left: 25),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: HexColor('#292929'),
                borderRadius: BorderRadius.circular(8.0),
                // Adjust border radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    // Shadow color with opacity
                    spreadRadius: -4,
                    // Shadow spread radius
                    blurRadius: 3,
                    // Shadow blur radius
                    offset: Offset(0, 2), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF292929),
                            // Circle background color
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                // spreadRadius: -2,// Shadow color
                                spreadRadius: -7,
                                blurRadius: 16, // Spread of the shadow
                                offset: Offset(-5, -5), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            weight: 80,
                            color: Colors.white, // Color of the cross icon
                            size: 23, // Size of the cross icon
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Select Country ',
                    style: GoogleFonts.metrophobic(
                        textStyle: TextStyle(
                            fontSize: 30,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 45, right: 45, top: 10),
                    child: Center(
                      child: Text(
                        'Please select the country where you want to study ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.metrophobic(
                            textStyle: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Color(0xFFD9896A),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: countries.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCountryItem(countries[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryItem(Country country) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.network(
            country.flagUrl,
            width: 100,
            height: 60,
          ),
          SizedBox(height: 10),
          Text(
            country.name,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
