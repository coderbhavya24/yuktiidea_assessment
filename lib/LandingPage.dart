import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktiidea/Terms%20and%20Conditions.dart';
import 'package:yuktiidea/countrySelect.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assests/2d5405a39fc1b02dfaa354b050d74e01 (1).gif',
          ),
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: HexColor('#292929'),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )
              ),
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width,
               child: Column(

                 children: <Widget>[
                   SizedBox(height: 35,),
                   Text('Welcome To Study Lancer',
                     style: GoogleFonts.metrophobic(
                         textStyle: TextStyle(
                             fontSize: 28,
                             fontWeight: FontWeight.bold,
                             color: Colors.white
                         )
                     ),
                     ),
                   SizedBox(height: 10,),
                   Text('Please select your role to get registered',
                     style: GoogleFonts.metrophobic(
                         textStyle: TextStyle(
                             fontSize: 16,
                             // fontWeight: FontWeight.bold,
                             color: Colors.white
                         )
                     ),),
                   SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context,
                           MaterialPageRoute(builder: (context) =>CountrySelect('student') ),
                           );
                         },
                         child: Container(

                           child: Image.asset('assests/img_3.png',
                             width: MediaQuery.of(context).size.width*0.5,
                             // height: 180,
                           ),
                         ),
                       ),
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context,
                           MaterialPageRoute(builder: (context) => CountrySelect('counsellor')),
                           );
                         },
                         child: Container(
                           child: Image.asset('assests/img_4.png',
                            width: MediaQuery.of(context).size.width*0.5,
                            // height: 200,
                           ),
                         ),
                       )
                     ],
                   ),
                   SizedBox(height: 14,),
                   RichText(
                     text: TextSpan(
                       text: 'By continuing you agree to our ',
                       style: GoogleFonts.metrophobic(
                           textStyle: TextStyle(
                               fontSize: 15,
                               // fontWeight: FontWeight.bold,
                               color: Colors.white
                           )
                       ),
                       children: [
                         TextSpan(
                           // recognizer: TapGest
                           // ),
                           recognizer: TapGestureRecognizer()
                             ..onTap=(){
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => TermsAndConditions()),
                               );
                             print("text Clicked");
                             }
                           ,
                           text: 'Terms and Conditions',
                           style: GoogleFonts.metrophobic(
                               textStyle: TextStyle(
                                   fontSize: 14,
                                   // fontWeight: FontWeight.bold,
                                   color: HexColor('#d9896a')
                               )
                           ),
                         )
                       ]
                     ),

                   ),
                 ],
               ),

            )
          ],
        ),
      ),
    );
  }
}
