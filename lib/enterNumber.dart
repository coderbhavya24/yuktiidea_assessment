import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:yuktiidea/VerifyOtp.dart';
import 'package:yuktiidea/countrySelect.dart';

class EnterNumber extends StatefulWidget {
  String code="d", img='d',role='d';
  EnterNumber(String roled, String name,String cd){
    this.code = name;
    this.img = cd;
    this.role=roled;
  }


  @override
  State<EnterNumber> createState() => _EnterNumberState(role, code,img);
}

class _EnterNumberState extends State<EnterNumber> {
  String code="d", img='d', role='d';
  _EnterNumberState(String roled, String name,String cd){
    this.code = name;
    this.img = cd;
    this.role = roled;
  }
  bool showerror = true;
  String phone='09';
  TextEditingController _numberController = TextEditingController();

  Future<void> sendOTP(String countryCode, String phoneNumber) async {
    // API endpoint
    String apiUrl = 'https://studylancer.yuktidea.com/api/${role}/login';

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'tel_code': countryCode,
          'phone': phoneNumber,
        },
      );

      // Check response status code
      if (response.statusCode == 200) {
        // Parse response body
        var responseBody = json.decode(response.body);
        // Check if OTP sent successfully
        if (responseBody['status'] == true) {
          print('Verification OTP sent');
        } else {
          print('Failed to send OTP');
        }
      } else {
        // Handle HTTP error
        print('Failed to send OTP. Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Failed to send OTP. Error: $error');
    }
  }

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
                    Container(
                      padding: EdgeInsets.only(left: 45,right: 45,top: 10),
                      child: Center(
                        child: Text('Please enter your 10 digit mobile number to get OTP ',
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
              Container(
                decoration: BoxDecoration(
                  color: HexColor('#292929'),
                  borderRadius: BorderRadius.circular(1.0), // Adjust border radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5), // Shadow color with opacity
                      spreadRadius: -4, // Shadow spread radius
                      blurRadius: 3, // Shadow blur radius
                      offset: Offset(0, 2), // Shadow position
                    ),

                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                      SvgPicture.network(
                        img, // Country flag SVG URL
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 25),
                      Text(code,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      SizedBox(width: 18),
                      // Add some space between flag and text field
                      Expanded(
                        child: TextField(
                          controller: _numberController,
                          // maxLength: 10,
                          keyboardType: TextInputType.phone, // Specify phone number input type
                          style: TextStyle(color: Colors.white,
                          fontSize: 20), // Text color
                          decoration: InputDecoration(
                            hintText: '9999999999', // Placeholder text
                            hintStyle: TextStyle(color: HexColor('#656366'),
                            fontSize: 20
                            ),

                            // Placeholder color
                            border: InputBorder.none, // No border
                          ),
                          onChanged: (value){
                            if(value.length==10){
                              if(value[0].compareTo('6')<0){
                                setState(() {
                                  showerror = true;
                                });
                              }
                              else{
                                showerror=false;
                              }
                            }
                          },
                        ),

                      ),
                    ],
                  ),
                ),
              ),
              showerror?
              Container(
                padding: EdgeInsets.only(left: 45,right: 45,top: 15),
                child: Center(
                  child: Text('Please enter a valid mobile number',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.metrophobic(

                        textStyle: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Color(0xFFf05252),
                        )
                    ),
                  ),
                ),
              ): Container(),
              SizedBox(height:MediaQuery.of(context).size.height*0.30 ,),
              GestureDetector(
                onTap: (){
                  if(!showerror){
                    print(code+_numberController.text);
                    sendOTP(code, _numberController.text);
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> VerifyOTP(phone))
                    );
                  }
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
                      width: showerror? 0: 3
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
                      'Get OTP',
                      style: TextStyle(
                        color: showerror? HexColor('#77685e') :HexColor('#f9d3b4'), // Text color
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
    );
  }
}
