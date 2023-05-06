# clash_bot_api.api.TournamentApi

## Load the API package
```dart
import 'package:clash_bot_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createTournament**](TournamentApi.md#createtournament) | **POST** /tournaments | 
[**getTournaments**](TournamentApi.md#gettournaments) | **GET** /tournaments | 


# **createTournament**
> DetailedTournament createTournament(xCausedBy, detailedTournament)



To create a Tournament

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TournamentApi();
final xCausedBy = xCausedBy_example; // String | 
final detailedTournament = DetailedTournament(); // DetailedTournament | 

try {
    final result = api_instance.createTournament(xCausedBy, detailedTournament);
    print(result);
} catch (e) {
    print('Exception when calling TournamentApi->createTournament: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **detailedTournament** | [**DetailedTournament**](DetailedTournament.md)|  | [optional] 

### Return type

[**DetailedTournament**](DetailedTournament.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTournaments**
> Tournaments getTournaments(xCausedBy, tournament, day, upcomingOnly)



### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = TournamentApi();
final xCausedBy = xCausedBy_example; // String | 
final tournament = tournament_example; // String | The Tournament name to filter by.
final day = day_example; // String | The tournament day to filter by.
final upcomingOnly = true; // bool | Whether to return only upcoming tournaments or not?

try {
    final result = api_instance.getTournaments(xCausedBy, tournament, day, upcomingOnly);
    print(result);
} catch (e) {
    print('Exception when calling TournamentApi->getTournaments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **tournament** | **String**| The Tournament name to filter by. | [optional] 
 **day** | **String**| The tournament day to filter by. | [optional] 
 **upcomingOnly** | **bool**| Whether to return only upcoming tournaments or not? | [optional] 

### Return type

[**Tournaments**](Tournaments.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

