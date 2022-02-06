import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_tennis_app/HomePageStuff/PopUpPlayers.dart';
import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/Subscription/subscription_pay.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';

class SUbscriptionEnd extends StatefulWidget {
  const SUbscriptionEnd({Key? key }) : super(key: key);
  

  @override
  _SUbscriptionEndState createState() => _SUbscriptionEndState();
}

class _SUbscriptionEndState extends State<SUbscriptionEnd> {
  

  String endsString = "date";
  String startingString = "date";
  String buttonText = "End subscription";


  Future<void> sendToPay(String namecode, int days) async {
 
    Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SubscriptionPay(namecode: namecode, days: days,)));
    
  }
    Widget checkboxwidget(String text,  int index ) {
     
      return Row(children: [ SizedBox(width: 25,),
      Container(child: Icon(Icons.check, color: appcolors.mainGreen, size: 25,),
        height: 2.5 * appState.heightTenpx!, width: 2.5 * appState.widthTenpx!, decoration: BoxDecoration(border: Border.all(width: 3, color: appcolors.cardBlue), )),
   SizedBox(width: 15,), Text(text, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),),
     ],);}


  

  Widget paymentButton(int index){
    return MaterialButton(onPressed: (){
         }, 
    child: Container(decoration: BoxDecoration(border: Border.all(width: 3, color: appcolors.cardBlue), color: Colors.transparent,), height: 32 * appState.heightTenpx!,  width: 35 * appState.widthTenpx!,
    child: Column(children: [
      SizedBox(height: 2.0 * appState.heightTenpx!,),
      Text("Conditions" , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
      SizedBox(height: 3.0 * appState.heightTenpx!,),
      checkboxwidget("Get 2 USD for every unused month",  index),
        SizedBox(height: 3.0 * appState.heightTenpx!,),
      checkboxwidget("Usually takes 2 days for \nTGAME to refund",  index),
      SizedBox(height: 3.0 * appState.heightTenpx!,),
      checkboxwidget("5 - 10 days before you can \nsee the refunded money in \nyour bank account",  index),

         ],) ));
  }


  Future<void> sendRequest(String namecode) async {
final databaseReference = FirebaseDatabase.instance.ref();

  DatabaseReference reference2 = databaseReference.child("Matches&Subscriptions/" + namecode + "/plan/");
    reference2.remove();
    reference2.set({ "ends":
      {"ends": "noPlan",},
      "started":
      {"starts": "noPlan",}});
      buttonText = "Return to home";
       ScaffoldMessenger.of(context).showSnackBar(
  
  SnackBar(content: Text("Plan Ended")),
);
this.setState(() {

    });
   
  }
   @override
  Widget build(BuildContext context) {
   
    return Scaffold(backgroundColor: appcolors.backgroundColor, body: Center(
      child: Stack(
        children: [
          
          SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 6.0 * appState.heightTenpx!,),
              Text("End subscription", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),),
              SizedBox(height: 3.0 * appState.heightTenpx!,),
             paymentButton(1),
            SizedBox(height: 5.0 * appState.heightTenpx!,),
            MaterialButton(
           
                                onPressed: () {
                                  if(buttonText != "Return to home"){
                                  sendRequest(appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3]);
                             } else {
                               Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePageView([10,10,01], true)));
 
                             }
                                },
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: appcolors.mainGreen,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        buttonText,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
            ],),
          ),
           Align(
            alignment: Alignment.bottomLeft,
            child: MaterialButton(
              padding: EdgeInsets.only(left: 20, bottom: 40 ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: appcolors.mainGreen,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Back",
                                        style: TextStyle(
                                          color: appcolors.backgroundColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
          ),
        ],
      ),
    ),);
  }
}