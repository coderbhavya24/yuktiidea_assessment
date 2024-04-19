import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yuktiidea/countrySelect.dart';

class EnterNumber extends StatefulWidget {
  String code="d", img='d';
  EnterNumber(String name,String cd){
    this.code = name;
    this.img = cd;
  }

  @override
  State<EnterNumber> createState() => _EnterNumberState(code,img);
}

class _EnterNumberState extends State<EnterNumber> {
  String code="d", img='d';
  _EnterNumberState(String name,String cd){
    this.code = name;
    this.img = cd;
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
                                builder: (context) => const CountrySelect()),
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
                  Text('Enter phone number ',
                    style: GoogleFonts.metrophobic(
                        textStyle: TextStyle(
                            fontSize: 30,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white
                        )
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
