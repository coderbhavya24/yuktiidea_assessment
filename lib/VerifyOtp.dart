import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yuktiidea/enterNumber.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#292929'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
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
                            Navigator.pop(context);
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
                    Text('Verify OTP ',
                      style: GoogleFonts.metrophobic(
                          textStyle: TextStyle(
                              fontSize: 30,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white
                          )
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 45,right: 45,top: 10),
                      child: Center(
                        child: Text('Please enter the OTP received to verify your phone number ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.metrophobic(

                              textStyle: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                color: Color(0xFFD9896A),
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
              SizedBox(height: 80,),


              SizedBox(height:MediaQuery.of(context).size.height*0.30 ,),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 200,
                  height: 50,
                  // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45),
                  decoration: BoxDecoration(
                    color: HexColor('#292929'), // Background color of the container
                    borderRadius: BorderRadius.circular(18.0,
                    ),
                    border: Border.all(
                        color: HexColor('#1c1e1f'),
                        width: 3
                    ),// Adjust border radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#f9d3b4').withOpacity(0.4), // Shadow color with opacity
                        spreadRadius: 0.5 , // Shadow spread radius
                        blurRadius: 3, // Shadow blur radius
                        offset: Offset(-3, -3), // Shadow position
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                        color: HexColor('#f9d3b4'), // Text color
                        fontSize: 19,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );;
  }
}
