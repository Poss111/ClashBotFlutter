# openapi
# Welcome to Clash Bot! 

Where all of your League of Legends Clash scheduling needs are met!

## Purpose

Clash Bot Webapp Service to support League of Legends Clash tournament scheduling with Discord.

## Disclaimer

Clash-Bot is not endorsed by Riot Games and does not reflect the views or opinions of Riot Games or 
anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games 
are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.


This Dart package is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 2.0.0
- Generator version: 7.12.0
- Build package: org.openapitools.codegen.languages.DartClientCodegen

## Requirements

Dart 2.12 or later

## Installation & Usage

### Github
If this Dart package is published to Github, add the following dependency to your pubspec.yaml
```
dependencies:
  openapi:
    git: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
```

### Local
To use the package in your local drive, add the following dependency to your pubspec.yaml
```
dependencies:
  openapi:
    path: /path/to/openapi
```

## Tests

TODO

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```dart
import 'package:openapi/api.dart';


final api_instance = ChampionsApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player
final champions = Champions(); // Champions | A list of champions.

try {
    final result = api_instance.addToPreferredChampionsForUser(xCausedBy, discordId, champions);
    print(result);
} catch (e) {
    print('Exception when calling ChampionsApi->addToPreferredChampionsForUser: $e\n');
}

```

## Documentation for API Endpoints

All URIs are relative to *http://localhost:8080/api/v2*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*ChampionsApi* | [**addToPreferredChampionsForUser**](doc//ChampionsApi.md#addtopreferredchampionsforuser) | **PATCH** /users/{discordId}/champions | 
*ChampionsApi* | [**createListOfPreferredChampionsForUser**](doc//ChampionsApi.md#createlistofpreferredchampionsforuser) | **POST** /users/{discordId}/champions | 
*ChampionsApi* | [**removePreferredChampionForUser**](doc//ChampionsApi.md#removepreferredchampionforuser) | **DELETE** /users/{discordId}/champions | 
*ChampionsApi* | [**retrieveUsersPreferredChampions**](doc//ChampionsApi.md#retrieveuserspreferredchampions) | **GET** /users/{discordId}/champions | 
*MaintenanceApi* | [**archiveTeamsAndTentativeQueues**](doc//MaintenanceApi.md#archiveteamsandtentativequeues) | **POST** /archive | 
*SubscriptionApi* | [**isUserSubscribed**](doc//SubscriptionApi.md#isusersubscribed) | **GET** /users/{discordId}/subscriptions/{subscription} | 
*SubscriptionApi* | [**subscribeUser**](doc//SubscriptionApi.md#subscribeuser) | **POST** /users/{discordId}/subscriptions/{subscription} | 
*SubscriptionApi* | [**unsubscribeUser**](doc//SubscriptionApi.md#unsubscribeuser) | **DELETE** /users/{discordId}/subscriptions/{subscription} | 
*TeamApi* | [**assignUserToTeam**](doc//TeamApi.md#assignusertoteam) | **PATCH** /teams/{teamId}/users/{discordId} | 
*TeamApi* | [**createTeam**](doc//TeamApi.md#createteam) | **POST** /teams | 
*TeamApi* | [**removeUserFromTeam**](doc//TeamApi.md#removeuserfromteam) | **DELETE** /teams/{teamId}/users/{discordId} | 
*TeamApi* | [**retrieveTeamBasedOnId**](doc//TeamApi.md#retrieveteambasedonid) | **GET** /teams/{teamId} | 
*TeamApi* | [**retrieveTeams**](doc//TeamApi.md#retrieveteams) | **GET** /teams | 
*TeamApi* | [**updateTeam**](doc//TeamApi.md#updateteam) | **PATCH** /teams/{teamId} | 
*TentativeApi* | [**assignUserToATentativeQueue**](doc//TentativeApi.md#assignusertoatentativequeue) | **PATCH** /tentatives/{tentativeId}/users/{discordId} | 
*TentativeApi* | [**createTentativeQueue**](doc//TentativeApi.md#createtentativequeue) | **POST** /tentatives | 
*TentativeApi* | [**removeUserFromTentativeQueue**](doc//TentativeApi.md#removeuserfromtentativequeue) | **DELETE** /tentatives/{tentativeId}/users/{discordId} | 
*TentativeApi* | [**retrieveTentativeQueue**](doc//TentativeApi.md#retrievetentativequeue) | **GET** /tentatives/{tentativeId} | 
*TentativeApi* | [**retrieveTentativeQueues**](doc//TentativeApi.md#retrievetentativequeues) | **GET** /tentatives | 
*TournamentApi* | [**createTournament**](doc//TournamentApi.md#createtournament) | **POST** /tournaments | 
*TournamentApi* | [**getTournaments**](doc//TournamentApi.md#gettournaments) | **GET** /tournaments | 
*TournamentApi* | [**retrieveRiotClashTournaments**](doc//TournamentApi.md#retrieveriotclashtournaments) | **PATCH** /tournaments/riot | 
*UserApi* | [**addUsersSelectedServers**](doc//UserApi.md#addusersselectedservers) | **PATCH** /users/{discordId}/servers | 
*UserApi* | [**createUser**](doc//UserApi.md#createuser) | **POST** /users | 
*UserApi* | [**createUsersSelectedServers**](doc//UserApi.md#createusersselectedservers) | **POST** /users/{discordId}/servers | 
*UserApi* | [**getUser**](doc//UserApi.md#getuser) | **GET** /users | 
*UserApi* | [**removeUsersSelectedServers**](doc//UserApi.md#removeusersselectedservers) | **DELETE** /users/{discordId}/servers | 
*UserApi* | [**retrieveUsersSelectedServers**](doc//UserApi.md#retrieveusersselectedservers) | **GET** /users/{discordId}/servers | 
*UserApi* | [**updateUser**](doc//UserApi.md#updateuser) | **PATCH** /users/{discordId} | 


## Documentation For Models

 - [ArchiveMetadata](doc//ArchiveMetadata.md)
 - [BaseTournament](doc//BaseTournament.md)
 - [Champion](doc//Champion.md)
 - [Champions](doc//Champions.md)
 - [CreateUserRequest](doc//CreateUserRequest.md)
 - [DetailedTournament](doc//DetailedTournament.md)
 - [Error](doc//Error.md)
 - [Event](doc//Event.md)
 - [EventType](doc//EventType.md)
 - [Player](doc//Player.md)
 - [PositionDetails](doc//PositionDetails.md)
 - [Role](doc//Role.md)
 - [Server](doc//Server.md)
 - [Servers](doc//Servers.md)
 - [Subscription](doc//Subscription.md)
 - [SubscriptionType](doc//SubscriptionType.md)
 - [Team](doc//Team.md)
 - [TeamEvent](doc//TeamEvent.md)
 - [TeamPlayer](doc//TeamPlayer.md)
 - [TeamPlayerDetails](doc//TeamPlayerDetails.md)
 - [TeamRequired](doc//TeamRequired.md)
 - [TeamTournamentDetails](doc//TeamTournamentDetails.md)
 - [TeamUpdate](doc//TeamUpdate.md)
 - [Teams](doc//Teams.md)
 - [Tentative](doc//Tentative.md)
 - [TentativePlayer](doc//TentativePlayer.md)
 - [TentativeRequired](doc//TentativeRequired.md)
 - [Tentatives](doc//Tentatives.md)
 - [Tournaments](doc//Tournaments.md)
 - [UpdateUserRequest](doc//UpdateUserRequest.md)


## Documentation For Authorization

Endpoints do not require authorization.


## Author

rixxroid@gmail.com

