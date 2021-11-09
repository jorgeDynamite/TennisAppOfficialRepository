import 'dart:async';

import 'package:app/HomePageStuff/View.dart';
import 'package:app/LoginPage.dart';
import 'package:app/SideBarStuff/bloc.animation_bloc/navigation.bloc.dart';
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
  SideBar(this.y, this.sendInitials, this.selectedPlayerFunction, this.ifCoach);
  bool y;
  Function sendInitials;
  Function selectedPlayerFunction;
  bool ifCoach;

  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
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

  Widget selectedPlayersHeadLine() {
    if (widget.ifCoach) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
            child: Row(
              children: [
                Text(
                  "Select Player ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          Column(children: playersWidgets),
          Divider(
            height: 64,
            thickness: 0.5,
            color: Colors.white.withOpacity(0.3),
            indent: 32,
            endIndent: 32,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Future _getIfUserDetails(context) async {
    print("run intisState");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loggedIn = preferences.getBool("loggedIn") ?? false;
    this.lastName = preferences.getString("lastName").toString();
    this.email = preferences.getString("email").toString();
    this.firstName = preferences.getString("firstName").toString();
    if (widget.ifCoach) {
      String uid = preferences.getString("accountRandomUID").toString();
      int? activePlayerIndex;
      activePlayerIndex = preferences.getInt("activePlayerIndex");

      String selected = "";
      List<String> namesOfPlayers;

      print("Email" + email);

      final databaseReference = FirebaseDatabase.instance.reference();

      DataSnapshot dataSnapshot = await databaseReference
          .child("CP_Accounts/" + firstName + lastName + "-" + uid + "/")
          .once();
      print("Data reference thing = " +
          "CP_Accounts/" +
          firstName +
          lastName +
          "-" +
          uid +
          "/");
      if (dataSnapshot.value != null) {
        dataSnapshot.value.forEach((key, value) {
          if (value["mainController"] == null) {
            value.forEach((key, value) {
              print(key);
              if (key != "playerTournaments" &&
                  key != "LastMatchPlayed" &&
                  key != "matchRecord") {
                String firstNamePlayer = value["firstName"];
                String lastNamePlayer = value["lastName"];
                String emailPlayer = value["email"];
                String passwordPlayer = value["password"];
                players.add(
                  Player(
                    firstName: lastNamePlayer,
                    lastName: firstNamePlayer,
                    email: emailPlayer,
                    password: passwordPlayer,
                    tournaments: [],
                  ),
                );
                print("adding all the players ");
                print(players.length.toString());
              }
            });
          }
          playerdataDetected = true;
        });
      } else {
        print("no player data was detected");
        playerdataDetected = false;
      }
      int listLength = players.length;
      this.setState(() {
        if (this.playerdataDetected) {
          for (var i = 0; i < listLength; i++) {
            if (activePlayerIndex != null) {
              if (i == activePlayerIndex) {
                color = Color(0xFF0ADE7C);
                iconColor = color;
                selected = " -";
              } else {
                color = Colors.white;
                iconColor = Colors.cyan;
                selected = "";
              }
            } else {
              if (i == 0) {
                setActivePlayer(players[i].lastName, players[i].firstName, i);
                color = Color(0xFF0ADE7C);
                iconColor = color;
                selected = " -";
              } else {
                color = Colors.white;
                iconColor = Colors.cyan;
                selected = "";
              }
            }
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

                    _playerOnPressed(i);
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
    }
  }

  _playerOnPressed(
    index,
  ) {
    setActivePlayer(players[index].lastName, players[index].firstName, index);
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
        iconColor = Colors.cyan;
        selected = "";
      }

      playerWidgets.add(MenuItemPlayers(
        iconColor: iconColor,
        color: color,
        index: i,
        players: players,
        playersWidgets: playersWidgets,
        onTap: () {
          _playerOnPressed(i);
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

  void setActivePlayer(String firstName, String lastName, int index) async {
    print("Starting th first SetactivePlayerFunction a");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("activePlayerFirstName", firstName);
    preferences.setString("activePlayerLastName", lastName);
    preferences.setInt("activePlayerIndex", index);

    widget.sendInitials();
    print("Ending the first SetactivePlayerFunction ");
  }

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);

    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    print("need context");

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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF262AAA),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
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
                            color: Color(0xFF1BB5FD),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 40,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      selectedPlayersHeadLine(),
                      MenuItem(
                        onTap: () {
                          onIconPressed();
                        },
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      MenuItem(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
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
                      width: 35,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
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
