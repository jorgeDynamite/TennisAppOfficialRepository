import 'package:TennisApp/SideBarStuff/bloc.animation_bloc/navigation.bloc.dart';

import 'package:flutter/material.dart';



class MyAccountsPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Accounts",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}