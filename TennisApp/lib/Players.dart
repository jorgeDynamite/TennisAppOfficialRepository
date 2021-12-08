class Player {
  String firstName;
  String lastName;
  String email;
  String password;
  String key;

  List<Tournament> tournaments;
  Player({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.tournaments,
    required this.key,
  });
}

class Tournament {
  List<Matches> matches;
  List<String> surface;
  String tournamentName;

  Tournament({
    required this.matches,
    required this.surface,
    required this.tournamentName,
  });
}

class Matches {
  Matches(
      {this.opponent,
      this.score,
      this.unforcedErrors,
      this.forcedErrors,
      this.winners,
      this.aces,
      this.doubleFaults,
      this.voleyWinner,
      this.voleyErrors,
      this.pointsWon,
      this.pointsLost,
      this.secondServeProcentage,
      this.firstServeProcentage,
      this.returnErrors,
      this.returnWinner,
      this.doubles,
      this.rules,
      this.surface,
      this.matchDurationTime,
      this.matchNumber,
      this.pointsPlayed,
      this.pointsTracked,
      this.recevingPointsPlayed,
      this.servePointsPlayed});
  String? surface;

  String? opponent;
  List<int>? score;
  int? unforcedErrors;
  int? forcedErrors;
  int? winners;
  int? aces;
  int? doubleFaults;
  int? voleyWinner;
  int? voleyErrors;
  int? pointsWon;
  int? pointsLost;
  int? secondServeProcentage;
  int? firstServeProcentage;
  int? returnErrors;
  int? returnWinner;
  int? pointsPlayed;
  int? pointsTracked;
  int? matchNumber;

  int? servePointsPlayed;
  int? recevingPointsPlayed;
  int? matchDurationTime;
  bool? doubles;
  Rules? rules;
}

class Rules {
  bool ad;
  MatchFormat matchFormatVariable;

  Rules({required this.ad, required this.matchFormatVariable});
}

class MatchFormat {
  bool? mostGamesWinsFormat;
  bool? mostSetsWinsFormat;
  int? numberSets;
  int? timeRestriction;
  int? gamesPerSet;
  bool? decidingSuperTiebreak;
  bool? tiebreak3all;
  bool? tiebreak6all;

  MatchFormat(
      {this.mostSetsWinsFormat,
      this.mostGamesWinsFormat,
      this.numberSets,
      this.timeRestriction,
      this.gamesPerSet,
      this.decidingSuperTiebreak,
      this.tiebreak3all,
      this.tiebreak6all});
}

class Player1 {
  String firstName;
  String lastName;
  String email;
  String password;

  List<Tournament> tournaments;
  Player1(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.tournaments});
}

class Tournament1 {
  List<Matches1> matches;
  List<String> surface;
  String tournamentName;

  Tournament1({
    required this.matches,
    required this.surface,
    required this.tournamentName,
  });
}

class Matches1 {
  Matches1(
      {this.opponent,
      this.score,
      this.unforcedErrors,
      this.forcedErrors,
      this.winners,
      this.aces,
      this.doubleFaults,
      this.voleyWinner,
      this.voleyErrors,
      this.pointsWon,
      this.pointsLost,
      this.secondServeProcentage,
      this.firstServeProcentage,
      this.returnErrors,
      this.returnWinner,
      this.doubles,
      this.rules,
      this.surface,
      this.matchDurationTime,
      this.pointsPlayed,
      this.pointsTracked,
      this.recevingPointsPlayed,
      this.servePointsPlayed});
  String? surface;

  String? opponent;
  List<int>? score;
  int? unforcedErrors;
  int? forcedErrors;
  int? winners;
  int? aces;
  int? doubleFaults;
  int? voleyWinner;
  int? voleyErrors;
  int? pointsWon;
  int? pointsLost;
  int? secondServeProcentage;
  int? firstServeProcentage;
  int? returnErrors;
  int? returnWinner;
  int? pointsPlayed;
  int? pointsTracked;

  int? servePointsPlayed;
  int? recevingPointsPlayed;
  int? matchDurationTime;
  bool? doubles;
  Rules1? rules;
}

class Rules1 {
  bool ad;
  MatchFormat1 matchFormatVariable;

  Rules1({required this.ad, required this.matchFormatVariable});
}

class MatchFormat1 {
  bool? mostGamesWinsFormat;
  bool? mostSetsWinsFormat;
  int? numberSets;
  int? timeRestriction;
  int? gamesPerSet;
  bool? decidingSuperTiebreak;
  bool? tiebreak3all;
  bool? tiebreak6all;

  MatchFormat1(
      {this.mostSetsWinsFormat,
      this.mostGamesWinsFormat,
      this.numberSets,
      this.timeRestriction,
      this.gamesPerSet,
      this.decidingSuperTiebreak,
      this.tiebreak3all,
      this.tiebreak6all});
}
