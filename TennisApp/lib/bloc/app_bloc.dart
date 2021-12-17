import 'package:app/bloc/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc {
  final AppState _state;

  static final AppBloc _app = AppBloc._();
  factory AppBloc() {
    return _app;
  }

  AppBloc._() : _state = appState;
  Future<List<dynamic>> initSet(
      bool coach, String uid, String email, lastName, firstname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("coach", coach);
    preferences.setBool("loggedIn", true);

    preferences.setString("accountRandomUID", uid);

    preferences.setString("email", email);
    preferences.setString("lastName", lastName);
    preferences.setString("firstName", firstname);
    if (coach) {
      preferences.setString("URLtoPlayer", "");
      _state.coach = preferences.getBool("coach");
      preferences.setString(
          "URLtoCoach",
          "CP_Accounts/" +
              firstname.split("")[0] +
              "/" +
              firstname.split("")[1] +
              "/" +
              firstname +
              "-" +
              lastName +
              "-" +
              uid +
              "/");
      _state.urlsFromCoach["URLtoCoach"] =
          _state.coach == true ? preferences.getString("URLtoCoach") : "";
    } else {
      preferences.setString("activePlayerFirstName", firstname);

      preferences.setString("activePlayerLastName", lastName);

      _state.coach = preferences.getBool("coach");
      preferences.setString(
          "URLtoPlayer",
          "Tennis_Accounts/" +
              firstname.split("")[0] +
              "/" +
              firstname.split("")[1] +
              "/" +
              firstname +
              "-" +
              lastName +
              "-" +
              uid +
              "/");
      preferences.setString("URLtoCoach", "");

      _state.email = preferences.getString("email");
      _state.fistName = preferences.getString("firstName");
      _state.lastName = preferences.getString("lastName");
      _state.loggedIn = preferences.getBool("loggedIn");
      _state.coach == false
          ? _state.urlsFromTennisAccounts["URLtoPlayer"] =
              preferences.getString("URLtoPlayer")
          : "";
      _state.randomUID = preferences.getString("accountRandomUID");
      _state.urlsFromCoach["URLtoPlayer"] =
          _state.urlsFromTennisAccounts["URLtoPlayer"];
    }
    return init();
  }

  Future<List<dynamic>> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _state.coach = preferences.getBool("coach");
    _state.urlsFromCoach["URLtoCoach"] =
        _state.coach == true ? preferences.getString("URLtoCoach") : "";
    _state.email = preferences.getString("email");
    _state.fistName = preferences.getString("firstName");
    _state.lastName = preferences.getString("lastName");
    _state.loggedIn = preferences.getBool("loggedIn");
    _state.coach == false
        ? _state.urlsFromTennisAccounts["URLtoPlayer"] =
            preferences.getString("URLtoPlayer")
        : "";
    _state.randomUID = preferences.getString("accountRandomUID");
    print("______________________");
    print("initVariables");
    print(_state.coach);
    print(_state.urlsFromCoach["URLtoCoach"]);
    print(_state.urlsFromCoach["URLtoPlayer"]);
    print(_state.urlsFromTennisAccounts["URLtoPlayer"]);

    print(_state.fistName);
    print(_state.lastName);
    print(_state.email);
    print(_state.randomUID);
    print("______________________");
    return [
      _state.coach,
      _state.email,
      _state.fistName,
      _state.lastName,
      _state.randomUID,
      _state.urlsFromCoach,
      _state.urlsFromTennisAccounts,
    ];
  }
}

final app = AppBloc();
