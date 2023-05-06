# clash_bot_api.api.TeamApi

## Load the API package
```dart
import 'package:clash_bot_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**assignUserToTeam**](TeamApi.md#assignusertoteam) | **PATCH** /teams/{teamId}/users/{discordId} | 
[**createTeam**](TeamApi.md#createteam) | **POST** /teams | 
[**removeUserFromTeam**](TeamApi.md#removeuserfromteam) | **DELETE** /teams/{teamId}/users/{discordId} | 
[**retrieveTeamBasedOnId**](TeamApi.md#retrieveteambasedonid) | **GET** /teams/{teamId} | 
[**retrieveTeams**](TeamApi.md#retrieveteams) | **GET** /teams | 
[**updateTeam**](TeamApi.md#updateteam) | **PATCH** /teams/{teamId} | 


# **assignUserToTeam**
> Team assignUserToTeam(xCausedBy, teamId, discordId, positionDetails)



Assign's a User to the specified Team based on the role provided.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TeamApi();
final xCausedBy = xCausedBy_example; // String | 
final teamId = teamId_example; // String | The unique identifier of the Clash Bot Team
final discordId = discordId_example; // String | The Discord id of the Player
final positionDetails = PositionDetails(); // PositionDetails | Details to assign a user to a Team with.

try {
    final result = api_instance.assignUserToTeam(xCausedBy, teamId, discordId, positionDetails);
    print(result);
} catch (e) {
    print('Exception when calling TeamApi->assignUserToTeam: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **teamId** | **String**| The unique identifier of the Clash Bot Team | 
 **discordId** | **String**| The Discord id of the Player | 
 **positionDetails** | [**PositionDetails**](PositionDetails.md)| Details to assign a user to a Team with. | 

### Return type

[**Team**](Team.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createTeam**
> Team createTeam(xCausedBy, teamRequired)



Creates a Team with the defined details

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TeamApi();
final xCausedBy = xCausedBy_example; // String | 
final teamRequired = TeamRequired(); // TeamRequired | Details to create a Clash Bot Team with.

try {
    final result = api_instance.createTeam(xCausedBy, teamRequired);
    print(result);
} catch (e) {
    print('Exception when calling TeamApi->createTeam: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **teamRequired** | [**TeamRequired**](TeamRequired.md)| Details to create a Clash Bot Team with. | 

### Return type

[**Team**](Team.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeUserFromTeam**
> Team removeUserFromTeam(xCausedBy, teamId, discordId)



Removes a User from the specified Team.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TeamApi();
final xCausedBy = xCausedBy_example; // String | 
final teamId = teamId_example; // String | The unique identifier of the Clash Bot Team
final discordId = discordId_example; // String | The Discord id of the Player

try {
    final result = api_instance.removeUserFromTeam(xCausedBy, teamId, discordId);
    print(result);
} catch (e) {
    print('Exception when calling TeamApi->removeUserFromTeam: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **teamId** | **String**| The unique identifier of the Clash Bot Team | 
 **discordId** | **String**| The Discord id of the Player | 

### Return type

[**Team**](Team.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveTeamBasedOnId**
> Team retrieveTeamBasedOnId(xCausedBy, teamId)



Returns a single Clash Bot Team based on the id provided.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TeamApi();
final xCausedBy = xCausedBy_example; // String | 
final teamId = teamId_example; // String | The unique identifier of the Clash Bot Team

try {
    final result = api_instance.retrieveTeamBasedOnId(xCausedBy, teamId);
    print(result);
} catch (e) {
    print('Exception when calling TeamApi->retrieveTeamBasedOnId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **teamId** | **String**| The unique identifier of the Clash Bot Team | 

### Return type

[**Team**](Team.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveTeams**
> Teams retrieveTeams(xCausedBy, archived, discordId, serverId, tournamentName, tournamentDay)



Returns a list of Teams.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TeamApi();
final xCausedBy = xCausedBy_example; // String | 
final archived = true; // bool | Will retrieve records that are from past Tournaments
final discordId = discordId_example; // String | The Discord id of the Player
final serverId = serverId_example; // String | The Discord id of the Discord Server
final tournamentName = tournamentName_example; // String | The LoL Clash Tournament name
final tournamentDay = tournamentDay_example; // String | The LoL Clash Tournament day

try {
    final result = api_instance.retrieveTeams(xCausedBy, archived, discordId, serverId, tournamentName, tournamentDay);
    print(result);
} catch (e) {
    print('Exception when calling TeamApi->retrieveTeams: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **archived** | **bool**| Will retrieve records that are from past Tournaments | [optional] [default to false]
 **discordId** | **String**| The Discord id of the Player | [optional] 
 **serverId** | **String**| The Discord id of the Discord Server | [optional] 
 **tournamentName** | **String**| The LoL Clash Tournament name | [optional] 
 **tournamentDay** | **String**| The LoL Clash Tournament day | [optional] 

### Return type

[**Teams**](Teams.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTeam**
> Team updateTeam(xCausedBy, teamId, teamUpdate)



Updates an existing Clash Bot Team's metadata.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TeamApi();
final xCausedBy = xCausedBy_example; // String | 
final teamId = teamId_example; // String | The unique identifier of the Clash Bot Team
final teamUpdate = TeamUpdate(); // TeamUpdate | Details to update a Clash Bot Team's metadata with.

try {
    final result = api_instance.updateTeam(xCausedBy, teamId, teamUpdate);
    print(result);
} catch (e) {
    print('Exception when calling TeamApi->updateTeam: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **teamId** | **String**| The unique identifier of the Clash Bot Team | 
 **teamUpdate** | [**TeamUpdate**](TeamUpdate.md)| Details to update a Clash Bot Team's metadata with. | 

### Return type

[**Team**](Team.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

