import 'dart:async';

import 'package:main_tennis_app/HomePageStuff/PlayersAddPage.dart';
import 'package:main_tennis_app/HomePageStuff/PopUpPlayers.dart';
import 'package:main_tennis_app/HomePageStuff/View.dart';
import 'package:main_tennis_app/LoginPage.dart';
import 'package:main_tennis_app/RandomWidgets/logo.dart';
import 'package:main_tennis_app/SideBarStuff/bloc.animation_bloc/navigation.bloc.dart';
import 'package:main_tennis_app/bloc/app_bloc.dart';
import 'package:main_tennis_app/bloc/app_state.dart';
import 'package:main_tennis_app/colors.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Players.dart';
import '../../UnusedStuff/ParentCoachMainPage.dart';

import 'menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  SideBar(this.y, this.sendInitials, this.selectedPlayerFunction, this.ifCoach,
      this.setPlayerReference);
  bool y;
  Function sendInitials;
  Function selectedPlayerFunction;
  bool ifCoach;
  Function setPlayerReference;

  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  appColors colors = appColors();
  bool? coach;
  bool loggedIN = true;
  bool playerdataDetected = false;
  String lastName = "";
  String email = "";
  String firstName = "";
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  List<Player> players = [];
  List<Widget> playersWidgets = [];
  late Color color;
  dynamic widgetContext;
  late Color iconColor;
  final _animationDuration = const Duration(milliseconds: 500);

  String nameToLongFunc(String title, int maxAmountLetters) {
    List<String> splitTitle = title.split("");
    print(splitTitle);
    print(splitTitle.length);
    String newTitle = "";
    if (splitTitle.length > maxAmountLetters) {
      for (var i = 0; i < maxAmountLetters; i++) {
        newTitle = newTitle + splitTitle[i];
        print(newTitle);
      }

      return newTitle;
    } else {
      return title;
    }
  }

  Widget selectedPlayersHeadLine(coach) {
    if (coach) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(2.5 * appState.widthTenpx!,
                appState.heightTenpx!, 0, appState.heightTenpx!),
            child: Row(
              children: [
                Text(
                  "Tennis Players",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          SizedBox(
              child: SingleChildScrollView(
                child: Column(children: playersWidgets),
              ),
              height: 25.0 * appState.heightTenpx!),
          Divider(
            height: 2.4 * appState.heightTenpx!,
            thickness: 0.5,
            color: Colors.white.withOpacity(0.3),
            indent: 32,
            endIndent: 32,
          ),
          SizedBox(height: 4.0 * appState.heightTenpx!),
          MenuItem(
            onTap: () {
              appState.AddedPlayerToCP = true;
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => popUpPLayers()));
            },
            icon: Icons.person,
            title: "Add Player",
            fontSize: 24,
            iconSize: 34,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  

  Future _getIfUserDetails(context) async {
    List<dynamic> initAtributes = await app.init();
    String playerKey = "";
    List<String> playerKeys = [];
    print("run intisState");

    SharedPreferences preferences = await SharedPreferences.getInstance();

    this.lastName = initAtributes[3];
    this.email = initAtributes[1];
    this.firstName = initAtributes[2];
    this.coach = initAtributes[0];
    if (coach!) {
      String uid = initAtributes[4];
      int? activePlayerIndex;
      if (appState.newActivePlayer == false) {
        print("asdassadasdasdd");
        activePlayerIndex = preferences.getInt("activePlayerIndex");
      } else {
        appState.newActivePlayer = false;
      }
      String selected = "";

      final databaseReference = FirebaseDatabase.instance.ref();

      //DataSnapshot dataSnapshot =
      //   await databaseReference.child(initAtributes[5]["URLtoCoach"]).once();
      DatabaseEvent? dataSnapshot =
          await databaseReference.child(initAtributes[5]["URLtoCoach"]).once();

      //print(_state.urlsFromCoach["URLtoCoach"]! + "dsadasdsadasds");
      if (dataSnapshot.snapshot.value != null) {
        dynamic values = dataSnapshot.snapshot.value!;
        values.forEach((key, value) {
          playerKey = key;
          playerKeys.add(key);
          if (playerKey[0] != "-") {
            value.forEach((key, value) {
              print(key);
              if (key != "playerTournaments" &&
                  key != "LastMatchPlayed" &&
                  key != "matchRecord" &&
                  key != "lastTenGames") {
                String firstNamePlayer = value["firstName"];
                String lastNamePlayer = value["lastName"];
                String emailPlayer = value["email"];
                String passwordPlayer = value["password"];
                appState.urlsFromTennisAccounts["URLtoPlayer"] =
                    "Tennis_Accounts/" +
                        playerKey.split("")[0] +
                        "/" +
                        playerKey.split("")[1] +
                        "/" +
                        playerKey +
                        "/";
                appState.urlsFromCoach["URLtoPlayer"] =
                    appState.urlsFromCoach["URLtoCoach"]! + playerKey + "/";

                print(appState.urlsFromTennisAccounts["URLtoPlayer"]);
                print(appState.urlsFromCoach["URLtoPlayer"]);
                print(firstNamePlayer);
                players.add(
                  Player(
                    firstName: lastNamePlayer,
                    lastName: firstNamePlayer,
                    email: emailPlayer,
                    password: passwordPlayer,
                    tournaments: [],
                    key: playerKey,
                  ),
                  
                );
                if(!appState.firstLoad){
                  app.setMatchesLeftVatiable(firstNamePlayer + "-" + lastNamePlayer + "-" + uid);
                 
                  }
              }
            });
          }
          playerdataDetected = true;
           appState.firstLoad = true;
           print(appState.matchesLeft);
        });
      } else {
        print("no player data was detected");
        playerdataDetected = false;
      }
      int listLength = players.length;
      this.setState(() {
        if (this.playerdataDetected) {
          for (var i = 0; i < listLength; i++) {
            print("in Loop");
            if (activePlayerIndex != null) {
              if (i == activePlayerIndex) {
                setActivePlayer(
                  players[i].lastName,
                  players[i].firstName,
                  i,
                  players[i].key,
                );

                color = Color(0xFF0ADE7C);
                iconColor = color;
                selected = " -";
              } else {
                color = Colors.white;
                iconColor = Colors.white;
                selected = "";
              }
            } else {
              if (i == 0) {
                setActivePlayer(
                  players[i].lastName,
                  players[i].firstName,
                  i,
                  players[i].key,
                );
                color = Color(0xFF0ADE7C);
                iconColor = color;
                selected = " -";
              } else {
                color = Colors.white;
                iconColor = Colors.white;
                selected = "";
              }
            }
            // setActivePlayer(
            //     players[i].lastName, players[i].firstName, i, playerKey);

            String title =
                players[i].lastName + " " + players[i].firstName + selected;

            this.playersWidgets.add(MenuItemPlayers(
                  iconColor: iconColor,
                  color: color,
                  players: players,
                  playersWidgets: playersWidgets,
                  index: i,
                  onTap: () {
                    print("Pressed");

                    _playerOnPressed(
                      i,
                      players[i].key,
                    );
                  },
                  icon: Icons.person,
                  title: nameToLongFunc(title, 18),
                ));
          }
        }

        this.email = email;
        this.lastName = lastName;
        this.firstName = firstName;

        this.email = email;
      });

      print("object");
    } else {
      widget.selectedPlayerFunction;
      
    }
  }

  _playerOnPressed(index, playerKey) {
    setActivePlayer(
        players[index].lastName, players[index].firstName, index, playerKey);
    List<Widget> playerWidgets = [];
    String selected = "";

    int listLength = this.players.length;
    for (var i = 0; i < listLength; i++) {
      if (i == index) {
        color = Color(0xFF0ADE7C);
        iconColor = color;
        selected = " -";
      } else {
        color = Colors.white;
        iconColor = Colors.white;
        selected = "";
      }

      playerWidgets.add(MenuItemPlayers(
        iconColor: iconColor,
        color: color,
        index: i,
        players: players,
        playersWidgets: playersWidgets,
        onTap: () {
          _playerOnPressed(i, players[i].key);
        },
        icon: Icons.person,
        title: nameToLongFunc(
            players[i].lastName + " " + players[i].firstName + selected, 18),
      ));
    }
    this.setState(() {
      this.playersWidgets = playerWidgets;
      print("now editet the playersWidgets");
    });
  }

  void setActivePlayer(
      String firstName, String lastName, int index, String playerKey) async {
    print("Starting th first SetactivePlayerFunction a");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("activePlayerFirstName", firstName);
    preferences.setString("activePlayerLastName", lastName);
    preferences.setInt("activePlayerIndex", index);
    widget.sendInitials();
    appState.urlsFromTennisAccounts["URLtoPlayer"] = "Tennis_Accounts/" +
        playerKey.split("")[0] +
        "/" +
        playerKey.split("")[1] +
        "/" +
        playerKey +
        "/";

    if (preferences.getBool("coach")!) {
      appState.urlsFromCoach["URLtoPlayer"] =
          appState.urlsFromCoach["URLtoCoach"]! + playerKey + "/";
    }
    print(appState.urlsFromTennisAccounts["URLtoPlayer"]);
    widget.setPlayerReference();
    print("Ending the first SetactivePlayerFunction ");
  }

  @override
  void initState() {
    super.initState();
    coach = true;
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);

    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    print("need context");
    //_getIfUserDetails(widgetContext);

    _getIfUserDetails(widgetContext);
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    widgetContext = context;
    print("context defined");
    if (firstName == null) {
      firstName = "waiting";
    }
    if (email == null) {
      email = "waiting";
    }
    final screenWidth = MediaQuery.of(context).size.width;

    if (widget.y) {
      onIconPressed();
    }
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2.0 * appState.widthTenpx!),
                  color: Color(0xFF12161F), //const Color(0xFF262AAA),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0 * appState.heightTenpx!,
                      ),
                      ListTile(
                        title: Text(
                          firstName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          email,
                          style: TextStyle(
                            color: colors.mainGreen, //Color(0xFF1BB5FD),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: colors.cardBlue,
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 4.0 * appState.heightTenpx!,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      selectedPlayersHeadLine(coach ?? false),
                      SizedBox(
                        height: coach != null
                            ? coach!
                                ? 0
                                : 45.0 * appState.heightTenpx!
                            : 0,
                      ),
                      MenuItem(
                        onTap: () {
                          appState.matchesLeft = {};
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                        icon: Icons.exit_to_app,
                        title: "Logout",
                      ),
                    
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 3.5 * appState.widthTenpx!,
                      height: 11.0 * appState.heightTenpx!,
                      color: colors.backgroundColor, // Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: colors.lightblue, // Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
