import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yuktiidea/LandingPage.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  String termsAndConditions = '';
  String name='';
  String date='';

  @override
  void initState() {
    super.initState();
    fetchTermsAndConditions();
  }

  Future<void> fetchTermsAndConditions() async {
    final response = await http.get(
        Uri.parse('https://studylancer.yuktidea.com/api/terms-conditions'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final content = data['data']['content'];
      final namec= data['data']['title'];
      String datec = data['data']['updated_at'];
      setState(() {
        termsAndConditions = content;
        name= namec;
        date= datec.substring(0,10);
        print(name);
      });
    } else {
      throw Exception('Failed to load terms and conditions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#292929'),
      body: Container(
        padding: const EdgeInsets.only(top: 45, right: 15,left: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    child: const Icon(
                      Icons.close,
                      weight: 50,
                      color: Colors.white, // Color of the cross icon
                      size: 30, // Size of the cross icon
                    ),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset(
                        'assests/Terms.png',
                        // height: 20,
                        // width: 20,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.metrophobic(
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#d9896a'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          'Update $date',
                          style: GoogleFonts.metrophobic(
                            textStyle: TextStyle(
                              fontSize: 17,
                              color: HexColor('#7d7e80'),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: termsAndConditions.isNotEmpty
                      ? HtmlWidget(
                    termsAndConditions,
                    customStylesBuilder: (element) {
                      if (element.localName == 'h1') {
                        return {'color': '#d9896a', 'font-size': '20px'};
                      } else if (element.localName == 'p') {
                        return {'color': 'white', 'font-size': '15px'};
                      } else if (element.localName == 'li') {
                        return {'color': 'white', 'font-size': '15px'};
                      }

                      return null; // Return null for other elements to use default styles
                    },
                  )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}