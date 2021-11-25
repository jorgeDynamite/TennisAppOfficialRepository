class AppState {
  bool? coach;
  bool? loggedIn;
  String? randomUID;
  String? email;
  String? lastName;
  String? fistName;
  Map<String, String?> urlsFromCoach = {
    "URLtoCoach": "",
    "URLtoPlayer": "",
  };

  Map<String, String?> urlsFromTennisAccounts = {
    "URLtoPlayer": "",
  };
}

final appState = AppState();
