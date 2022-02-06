import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_tennis_app/HomePageStuff/PopUpPlayers.dart';
import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/Subscription/subscription_pay.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';

class SubscriptionHome extends StatefulWidget {
  const SubscriptionHome(this.popUp, {this.fromAfterMatchPage,Key? key }) : super(key: key);
  final bool? popUp;
  final bool? fromAfterMatchPage; 

  @override
  _SubscriptionHomeState createState() => _SubscriptionHomeState();
}

class _SubscriptionHomeState extends State<SubscriptionHome> {
 
 
  Future<void> sendToPay(String namecode, int days) async {
 
    Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SubscriptionPay(namecode: namecode, days: days,)));
    
  }
    Widget checkboxwidget(String text1, String text2, String text3, int index ) {
      String text = index == 1 ? text1 : index == 2 ? text2 : text3;
      return Row(children: [ SizedBox(width: 25,),
      Container(child: Icon(Icons.check, color: appcolors.mainGreen, size: 25,),
        height: 2.5 * appState.heightTenpx!, width: 2.5 * appState.widthTenpx!, decoration: BoxDecoration(border: Border.all(width: 3, color: appcolors.cardBlue), )),
   SizedBox(width: 15,), Text(text, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),),
     ],);}


  

  Widget paymentButton(int index){
    return MaterialButton(onPressed: (){
      sendToPay(appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3], index == 1 ? 31 : index == 2 ? 183 : 365);
    }, 
    child: Container(decoration: BoxDecoration(border: Border.all(width: 3, color: appcolors.cardBlue), color: Colors.transparent,),  height:index == 1 ? 22 * appState.heightTenpx! : 27 * appState.heightTenpx!,  width: 35 * appState.widthTenpx!,
    child: Column(children: [
      SizedBox(height: 2.0 * appState.heightTenpx!,),
      Text( index == 1 ?"1 month" : index == 2 ?"6 months" : "12 months" , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
      SizedBox(height: 3.0 * appState.heightTenpx!,),
      checkboxwidget("All app feutures - for this player", "All app feutures - for this player", "All app feutures - for this player", index),
      SizedBox(height: 2.0 * appState.heightTenpx!,),
     index == 1 ? Container() : checkboxwidget("", "Exit subscription when you want", "Exit subscription when you want", index),
      SizedBox(height: 2.0 * appState.heightTenpx!,),
     index == 1 ? Container() : checkboxwidget("", "Get money back after exit", "Get money back after exit", index),
 SizedBox(height: 3.0 * appState.heightTenpx!,),
    
     Row( mainAxisAlignment: MainAxisAlignment.center, children: [ SizedBox(width: 3.0 * appState.widthTenpx!,),Text(index == 1 ? "5 USD" : index == 2 ? "19 USD" : "29 USD", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),), 
      SizedBox(width: 11.0 * appState.widthTenpx!,),
     Text("Choose", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)],)
         ],) ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.popUp!){
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
    appState.popUpError(context, "You have no matches left. You need to buy a subscription to keep tracking your matches using our app", "Ok");
      });  
      } 
  }
   @override
  Widget build(BuildContext context) {
   
    return Scaffold(backgroundColor: appcolors.backgroundColor, body: Center(
      child: Stack(
        children: [
          
          SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 6.0 * appState.heightTenpx!,),
              Text("Subscriptions", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),),
              SizedBox(height: 3.0 * appState.heightTenpx!,),
             paymentButton(1),
           SizedBox(height: 4.0 * appState.heightTenpx!,),
             paymentButton(2),
             SizedBox(height: 4.0 * appState.heightTenpx!,),
             paymentButton(3),
             SizedBox(height: 7.0 * appState.heightTenpx!,),
            ],),
          ),
           Align(
            alignment: Alignment.bottomLeft,
            child: MaterialButton(
              padding: EdgeInsets.only(left: 20, bottom: 40 ),
                                onPressed: () {
                                  if(widget.fromAfterMatchPage == null){

                    
                                  Navigator.of(context).pop();
                                   } else {
 Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePageView([0,0,0], true)));
    
                                   }
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
                                        "Home",
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