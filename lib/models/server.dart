class ClashServer {
  late String id;
  late String serverName;
  late String imageLink;
  late List<String> availableTeams;

  ClashServer(this.id, this.serverName, this.imageLink, this.availableTeams);

  @override
  String toString() {
    return "id: $id";
  }
}