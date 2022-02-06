import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/bloc/app_bloc.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';
import 'package:http/http.dart' as http;

class SubscriptionPay extends StatefulWidget {
  const SubscriptionPay({this.days, this.namecode, Key? key }) : super(key: key);

final int? days;
final String? namecode;
  @override
  _SubscriptionPayState createState() => _SubscriptionPayState();
}

class _SubscriptionPayState extends State<SubscriptionPay> {
 String namecode = "";
 String paymentButtonName = "Pay";
  Future<void> setDate() async {
    namecode = appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3];
     final databaseReference = FirebaseDatabase.instance.ref();
     DatabaseReference paymentReference = databaseReference.child("Matches&Subscriptions/" + namecode + "/");
     
     
   
  }
  Future<void> setSubscription(String namecode, int days) async {
    print(namecode);
    final databaseReference = FirebaseDatabase.instance.ref();
    
    DatabaseReference reference = databaseReference.child("Matches&Subscriptions/" + namecode + "/plan/");
 
   
     var tempStarted = DateTime.now().toUtc();
     var tempEnds = DateTime.now().toUtc().add(Duration(days: days));
      DatabaseReference ends = reference.child("ends");
      DatabaseReference started = reference.child("started");
      String startedString = tempStarted.year.toString() + "." + tempStarted.month.toString() + "."+ tempStarted.day.toString();
      String endsString = tempEnds.year.toString() + "." + tempEnds.month.toString() + "."+ tempEnds.day.toString();
      ends.push();
      started.push();
      await ends.set({"ends": endsString});
      await started.set({"starts": startedString});
      appState.hasSubscription![namecode] = true;
      setState(() {
        paymentButtonName = "Return to home";
      });
    
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
      setSubscription(appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3], index == 1 ? 31 : index == 2 ? 183 : 365);
    }, 
    child: Container(decoration: BoxDecoration(border: Border.all(width: 3, color: appcolors.cardBlue), color: Colors.transparent,),  height:index == 1 ? 43 * appState.heightTenpx! : 43 * appState.heightTenpx!,  width: 35 * appState.widthTenpx!,
    child: Column(children: [
      SizedBox(height: 2.0 * appState.heightTenpx!,),
      Text("What do you get?" , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
      SizedBox(height: 3.0 * appState.heightTenpx!,),
      checkboxwidget("All app feutures", "All app feutures", "All app feutures", index),
      SizedBox(height: 2.0 * appState.heightTenpx!,),
      
       checkboxwidget("For this player", "For this player", "For this player", index),
     SizedBox(height: 2.0 * appState.heightTenpx!,),
      
       checkboxwidget("1 months with access to all features", "6 months with access to all features", "12 month with access to all features", index),
      SizedBox(height: 3.0 * appState.heightTenpx!,),
      index == 1 ? Container() : Text("Exit Terms" , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
       SizedBox(height: 2.0 * appState.heightTenpx!,),
     index == 1 ? Container() : checkboxwidget("", "Exit plan whenever you want", "Exit plan whenever you want", index),
      SizedBox(height: 2.0 * appState.heightTenpx!,),
      
     index == 1 ? Container() : checkboxwidget("", "Get 2 USD for every unused month \nwhen you stop plan", "Get 2 USD for every unused month \nwhen you stop plan", index),
     

 SizedBox(height: 3.0 * appState.heightTenpx!,),
    
    
         ],) ));
  }


   Map<String, dynamic>? paymentIntentData;

Future<void> makePayment(amount) async {
  
  print("Start Payment");
  
   
  String URL = "https://us-central1-tennisapprunningdatabase.cloudfunctions.net/stripePayment";
  final url = Uri.parse("$URL?amounts=$amount&namecode=$namecode");
print("Made url");
  final response = await http.get(url, headers: {'Content-Type': 'application/json',});
print("Response done ");
print(response.body);
paymentIntentData = json.decode(response.body);
print("PaymentIntent done ");
  await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
    paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
    customerId: "100000123",
    applePay: true,
    googlePay: true,
    style: ThemeMode.dark,
    merchantCountryCode: "US",
    merchantDisplayName: "George",
    billingDetails: BillingDetails(name: "hablalalalal", email: "tobiesongeorge@gmail.com",)
    
  ));
  print("Stripe PaymentSheet done ");
  
setState(() {});
  displayPaymentSheet();

  
}
//     parameters: PresentPaymentSheetParameters(clientSecret: paymentIntentData!['paymentIntent'],
    // confirmPayment: true)

Future<void> displayPaymentSheet() async {
 
 try {
   await Stripe.instance.presentPaymentSheet();
   setState(() {
   paymentIntentData = null;
     });
     ScaffoldMessenger.of(context).showSnackBar(
  
  SnackBar(content: Text("Paid Successfully!")),
);
await setSubscription(namecode, widget.days!);
 } catch(e){
   print(e);
 }
 
}
   @override
  Widget build(BuildContext context) {
     namecode = appState.urlsFromTennisAccounts["URLtoPlayer"]!.split("/")[3];
   
    return Scaffold(backgroundColor: appcolors.backgroundColor, body: Container(
      child:
          
          SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 6.0 * appState.heightTenpx!,),
              Text(widget.days == 365 ? "12 months" :  widget.days == 183 ? "6 months" : "1 month", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),),
              SizedBox(height: 5.0 * appState.heightTenpx!,),
             paymentButton(widget.days == 365 ? 3 :  widget.days == 183 ? 2 : 1),
             SizedBox(height: 4.0 * appState.heightTenpx!,),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               MaterialButton(
             // padding: EdgeInsets.only(left: 20, bottom: 150 ),
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  
                                },
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: appcolors.cardBlue,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Back",
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
                               SizedBox(width: 11.0 * appState.widthTenpx!,),
               Text(widget.days == 365 ? "29 USD" : widget.days == 183 ? "19 USD" : "5 USD", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),),
             SizedBox(width: 3.0 * appState.widthTenpx!,),
             ],
           ),
            SizedBox(height: 3.0 * appState.heightTenpx!,),
           
           MaterialButton(
             // padding: EdgeInsets.only(left: 20, bottom: 150 ),
                                onPressed: () {

 if(paymentButtonName == "Pay") {
   makePayment(widget.days == 365 ? 2900 : widget.days == 183 ? 1900 : 500,);} else {
 Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePageView([10,10,01], true)));
 
    
   }

                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: appcolors.mainGreen,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        paymentButtonName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
            ],),
          ),
          
        
      
    ),);
  }
}