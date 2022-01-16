import 'package:main_tennis_app/SideBarStuff/bloc.animation_bloc/navigation.bloc.dart';

import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Orders",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
