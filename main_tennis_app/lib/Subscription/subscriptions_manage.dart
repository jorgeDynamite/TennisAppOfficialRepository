import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_tennis_app/HomePageStuff/PopUpPlayers.dart';
import 'package:main_tennis_app/Subscription/subscription_pause.dart';
import 'package:main_tennis_app/Subscription/subscription_pay.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';

class SubscriptionManage extends StatefulWidget {
  const SubscriptionManage(this.popUp, {Key? key }) : super(key: key);
  final bool? popUp;

  @override
  _SubscriptionManageState createState() => _SubscriptionManageState();
}

class _SubscriptionManageState extends State<SubscriptionManage> {
  

  String endsString = "date";
  String startingString = "date";

    Widget checkboxwidget(String text,  int index ) {
     
      return Row(children: [ SizedBox(width: 25,),
      Container(child: Icon(Icons.check, color: appcolors.mainGreen, size: 25,),
        height: 2.5 * appState.heightTenpx!, width: 2.5 * appState.widthTenpx!, decoration: BoxDecoration(border: Border.all(width: 3, color: appcolors.cardBlue), )),
   SizedBox(width: 15,), Text(text, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),),
     ],);}


  

  Widget paymentButton(int index){
    return MaterialButton(onPressed: (){
         }, 
    child: Container(decoration: BoxDecoration(border: Border.all(width: 3, color: appcolors.cardBlue), color: Colors.transparent,), height: 37 * appState.heightTenpx!,  width: 35 * appState.widthTenpx!,
    child: Column(children: [
      SizedBox(height: 2.0 * appState.heightTenpx!,),
      Text("Your subscription" , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
      SizedBox(height: 3.0 * appState.heightTenpx!,),
      checkboxwidget("All app features",  index),
      SizedBox(height: 2.0 * appState.heightTenpx!,),
     index == 1 ? Container() : checkboxwidget("", index),
      SizedBox(height: 2.0 * appState.heightTenpx!,),
     index == 1 ? Container() : checkboxwidget("",  index),
 SizedBox(height: 3.0 * appState.heightTenpx!,),
    Row(
      children: [
        SizedBox(width: 3.0 * appState.widthTenpx!,),
        Text("Started: " + startingString, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),),
      ],
    ), 
     SizedBox(height: 1.0 * appState.heightTenpx!,),
    Row(
      
      children: [
        SizedBox(width: 3.0 * appState.widthTenpx!,),
        Text("Ends: " + endsString, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),),
    
      ],
    ), 
    SizedBox(height: 8.0 * appState.heightTenpx!,),
     Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
       
       TextButton(onPressed: () {  
          var temp = DateTime.now().toUtc().add(Duration(days: 30));
     var split = endsString.split(".");
     print(split);
    
     var dateInOneMonth = DateTime.utc(int.parse( split[0]),int.parse( split[1]), int.parse( split[2]));  
     if(dateInOneMonth.compareTo(temp) > 0) {

             
    Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SUbscriptionEnd())); }

                  else {
                    appState.popUpError(context, "You cant end subscription because you have less than one month left.", "Ok");
                  }
    
              },child:  Text("Manage", style: TextStyle(color: appcolors.transparentWhite, fontSize: 15, fontWeight: FontWeight.w400),),),
     SizedBox(width: 3.0 * appState.widthTenpx!,),
      ],
    ),   
     
         ],) ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDates(appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3]);
  }

  Future<void> setDates(String namecode) async {
final databaseReference = FirebaseDatabase.instance.ref();
    
    DatabaseEvent reference = await databaseReference.child("Matches&Subscriptions/" + namecode + "/plan/").once();
 
    dynamic value = reference.snapshot.value;
this.setState(() {
  

    endsString = value["ends"]["ends"];
    startingString = value["started"]["starts"];
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
               Text("Manage plan", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),),
              SizedBox(height: 3.0 * appState.heightTenpx!,),
             paymentButton(1),
           SizedBox(height: 4.0 * appState.heightTenpx!,),
           
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
                                        "Finished",
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