import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'LandingPage.dart';

class CountrySelect extends StatefulWidget {
  const CountrySelect({super.key});

  @override
  State<CountrySelect> createState() => _CountrySelectState();
}

class _CountrySelectState extends State<CountrySelect> {
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final response = await http.get(Uri.parse('https://studylancer.yuktidea.com/api/countries'));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final countriesData = responseData['data'];
      setState(() {
        _countries = countriesData.map<Country>((countryData) => Country.fromJson(countryData)).toList();
        print('loaded\n ${_countries.length} countries');
        _filteredCountries = List.from(_countries);
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }
  void filterCountries(String query) {
    setState(() {
      _filteredCountries = _countries
          .where((country) => country.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
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
                borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5), // Shadow color with opacity
                    spreadRadius: -4, // Shadow spread radius
                    blurRadius: 3, // Shadow blur radius
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LandingPage()),
                          );
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF292929), // Circle background color
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
                  Text('Select your country',
                    style: GoogleFonts.metrophobic(
                        textStyle: TextStyle(
                            fontSize: 32,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white
                        )
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: TextField(
                      controller: _searchController,
                      onChanged: filterCountries,
                      style: TextStyle(color: Colors.white), // Text color
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF4B4E4F), // Inside color
                        hintText: 'Search', // Initial text
                        hintStyle: TextStyle(color: Colors.white), // Initial text color
                        prefixIcon: Icon(Icons.search, color: Color(0xFFD9896A)), // Search icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),


            Expanded(
              child: Container(
                // padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _filteredCountries.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 90,
                      // width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: HexColor('#292929'),
                        borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5), // Shadow color with opacity
                            spreadRadius: -4, // Shadow spread radius
                            blurRadius: 3, // Shadow blur radius
                            offset: Offset(0, 2), // Shadow position
                          ),

                        ],
                      ),
                      // color: Colors.transparent,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 1,horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.network(
                                _filteredCountries[index].flag,
                                width: 20, // Adjust width as needed
                                height: 20, // Adjust height as needed
                                fit: BoxFit.contain, // Adjust BoxFit as needed
                              ),
                              SizedBox(width: 10,),
                              Text(_filteredCountries[index].name.length < 24 ?
                              _filteredCountries[index].name : _filteredCountries[index].name.substring(0,24)
                                ,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                            ],
                          ),

                          Text(_filteredCountries[index].telCode,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Country {
  final int id;
  final String name;
  final String code;
  final String telCode;
  final String timezone;
  final String flag;
  final String createdAt;
  final String updatedAt;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.telCode,
    required this.timezone,
    required this.flag,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      telCode: json['tel_code'] ?? '',
      timezone: json['timezone'] ?? '',
      flag: json['flag'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
