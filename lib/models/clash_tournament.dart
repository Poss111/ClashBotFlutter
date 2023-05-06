class ClashTournament {
  String tournamentName;
  String tournamentDay;
  DateTime startTime;
  DateTime registrationTime;

  ClashTournament(this.tournamentName, this.tournamentDay, this.startTime,
      this.registrationTime);

  @override
  String toString() {
    return 'ClashTournament(tournamentName: $tournamentName, tournamentDay: $tournamentDay, startTime: $startTime, registrationTime: $registrationTime)';
  }

  @override
  bool operator == (Object o) {
    if (identical(this, o)) return true;
    return o is ClashTournament &&
        o.tournamentName == tournamentName &&
        o.tournamentDay == tournamentDay;
  }

  @override
  int get hashCode {
    return tournamentName.hashCode ^ tournamentDay.hashCode ^ startTime.hashCode ^ registrationTime.hashCode;
  }
}
