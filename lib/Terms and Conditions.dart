import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yuktiidea/LandingPage.dart';
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  String termsAndConditions = '';

  @override
  void initState() {
    super.initState();
    fetchTermsAndConditions();
  }

  Future<void> fetchTermsAndConditions() async {
    final response = await http.get(Uri.parse('https://studylancer.yuktidea.com/api/terms-conditions'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final content = data['data']['content'];
      setState(() {
        termsAndConditions = content;
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
        padding: EdgeInsets.only(top: 40,right: 15),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => LandingPage())
                    );
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF292929), // Circle background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white, // Shadow color
                          blurRadius: 10, // Spread of the shadow
                          offset: Offset(0, 0), // Offset of the shadow

                        ),
                      ],

                    ),
                    child: Icon(
                      Icons.close,
                      weight: 50,
                      color: Colors.white, // Color of the cross icon
                      size: 30, // Size of the cross icon
                    ),
                  ),
                ),
                SizedBox(width: 15,)
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset('assests/img.png',
                      height: 100,
                        ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Terms of Service',
                            style: GoogleFonts.metrophobic(
                                textStyle: TextStyle(
                                    fontSize: 24,
                                    // fontWeight: FontWeight.bold,
                                    color: HexColor('#d9896a')
                                )
                            ),),
                        SizedBox(height: 13,),
                        Text('Updated at 12-09-23',
                            style: GoogleFonts.metrophobic(
                            textStyle: TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            color: HexColor('#7d7e80')
                        )
    ),
                        ),
                      ],
                    )
                  ],
                )
              ],

            ),
            SizedBox(height: 40,),
            Expanded(child: SingleChildScrollView(
              child: Text(termsAndConditions),
              // child: termsAndConditions.isNotEmpty
              //     ? Html(
              //   data: termsAndConditions,
              //   style: {
              //     "h1": Style(color: Colors.yellow, fontSize: FontSize(24.0)),
              //     "p": Style(color: Colors.white, fontSize: FontSize(15.0)),
              //   },
              // )
              //     : Center(child: CircularProgressIndicator()),
            ),
            ),

          ],
        ),
      ),
    );
  }
}
