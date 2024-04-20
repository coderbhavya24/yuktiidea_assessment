import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telephony/telephony.dart';
import 'package:yuktiidea/enterNumber.dart';
import 'package:yuktiidea/homePage.dart';

class VerifyOTP extends StatefulWidget {
  String phone ="d";
  VerifyOTP(String num){
    this.phone = num;
  }

  @override
  State<VerifyOTP> createState() => _VerifyOTPState(phone);
}

class _VerifyOTPState extends State<VerifyOTP> {
  String phone ='d';
  _VerifyOTPState(String num){
    this.phone = num;
  }
  bool verified=false;
  bool showerror=true;
  TextEditingController _one=TextEditingController();
  TextEditingController _two=TextEditingController();
  TextEditingController _three=TextEditingController();
  TextEditingController _four=TextEditingController();
  String otp ='';
  bool _isButtonVisible = false;

  void _startTimer(int time) {
    Future.delayed(Duration(seconds: time), () {
      setState(() {
        _isButtonVisible = true;
      });
    });
  }
  Future<void> verifyOTP(String otp, String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('https://studylancer.yuktidea.com/api/verify-otp'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'code': otp,
          'phone': phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final bool status = responseData['status'];
        final String message = responseData['message'];

        if (status) {
          final data = responseData['data'];
          final String profileStatus = data['profile_status'];
          final String role = data['role'];
          final String accessToken = data['access_token'];
          // Handle the response data as needed
        } else {
          // Handle the case when verification fails
        }
      } else {
        // Handle HTTP error
        throw Exception('Failed to verify OTP: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any other errors that may occur during the request
      print('Error verifying OTP: $error');
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
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.white,
                      height: 64,
                      width: 64,
                      child: TextField(
                        controller: _one,
                        onChanged: (value){
                          if(value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          ),
                        style: TextStyle(
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      height: 64,
                      width: 64,
                      child: TextField(
                        controller: _two,
                        onChanged: (value){
                          if(value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                          else if(value.length==0){
                            FocusScope.of(context).previousFocus();
                          }
                        },
                          style: TextStyle(
                              color: Colors.white
                          ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      height: 64,
                      width: 64,
                      child: TextField(
                        controller: _three,
                        onChanged: (value){

                          if(value.isEmpty){
                            FocusScope.of(context).previousFocus();
                          }
                          else if(value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                          style: TextStyle(
                              color: Colors.white
                          ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      height: 64,
                      width: 64,
                      child: TextField(
                        controller: _four,
                        onChanged: (value){
                          if(value.length==0){
                            FocusScope.of(context).previousFocus();
                          }
                          otp = _one.text + _two.text + _three.text + _four.text;
                        },
                        style: TextStyle(
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.15 ,),
              Text(
                'Didn\'t recieve OTP'
                ,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 25,),
              GestureDetector(
                onTap: (){
                  if(_isButtonVisible){

                  }
                },
                child: Text(
                  'Resend OTP'
                      ,
                  style: TextStyle(
                    fontSize: 19,
                    color: !_isButtonVisible? HexColor('#77685e') :HexColor('#f9d3b4'),
                    fontWeight: !_isButtonVisible? FontWeight.normal : FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  print(otp);
                  verifyOTP(otp, phone);
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> HomePage()),
                  );
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
