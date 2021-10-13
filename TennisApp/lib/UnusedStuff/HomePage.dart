import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import '../HomePageStuff/View.dart';



class HomePageReal extends StatefulWidget {
  @override
  _HomePageRealState createState() => _HomePageRealState();
}

class _HomePageRealState extends State<HomePageReal> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: AppBar( backgroundColor: Colors.transparent,
           title: TextButton(child: Text("George Tobieson", style: TextStyle(color: Color(0xFFACA2A2),fontFamily: "Helvetica", fontSize: 18,)), onPressed: () {print("hej");},)),backgroundColor: Colors.black,  body: Column(children: [
      
SizedBox(height: 20),
      Align(alignment: Alignment.center, child: Stack(children: [Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(23)), gradient: LinearGradient(colors: [Color(0xFF6302C1), Color(0xFF00FFF5) ],) , ), height: 192, width: 342,
       
    ), Positioned(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xFF272626), ), height: 185, width: 335, child: 
    Column(children: [Padding(padding: EdgeInsets.fromLTRB(12, 0, 12, 0), child: MaterialButton(
                  elevation: 0,
                  height: 20,
                  
                  onPressed: () {
                    print("Change Match");
                  },
                  color: Colors.transparent,
                  child: Column(children: [Row(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ 
                       Icon(Icons.arrow_forward_ios, size: 17,),
                      Align(alignment: Alignment.center, child: Padding(child: Text('Last Match', textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Helvetica", )), padding: EdgeInsets.fromLTRB(0, 3, 10, 0),),),
                     
                      
                      
                    ],
                  ),
                   
                      ],) ,
                  textColor: Colors.white,
                )),],),), right: 3, bottom: 3,),],
       )),]));
      
  }
}
