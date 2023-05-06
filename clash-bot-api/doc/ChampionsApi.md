# clash_bot_api.api.ChampionsApi

## Load the API package
```dart
import 'package:clash_bot_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addToPreferredChampionsForUser**](ChampionsApi.md#addtopreferredchampionsforuser) | **PATCH** /users/{discordId}/champions | 
[**createListOfPreferredChampionsForUser**](ChampionsApi.md#createlistofpreferredchampionsforuser) | **POST** /users/{discordId}/champions | 
[**removePreferredChampionForUser**](ChampionsApi.md#removepreferredchampionforuser) | **DELETE** /users/{discordId}/champions | 
[**retrieveUsersPreferredChampions**](ChampionsApi.md#retrieveuserspreferredchampions) | **GET** /users/{discordId}/champions | 


# **addToPreferredChampionsForUser**
> Champions addToPreferredChampionsForUser(xCausedBy, discordId, champions)



Adds the requested champion to the users preferred champions. Cannot be greater than a length of 5.

### Example
```dart
import 'package:clash_bot_api/api.dart';

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

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 
 **champions** | [**Champions**](Champions.md)| A list of champions. | [optional] 

### Return type

[**Champions**](Champions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createListOfPreferredChampionsForUser**
> Champions createListOfPreferredChampionsForUser(xCausedBy, discordId, champions)



Updates the users preferred champions with an entirely new list. Cannot be greater than a length of 5.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = ChampionsApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player
final champions = Champions(); // Champions | A list of champions.

try {
    final result = api_instance.createListOfPreferredChampionsForUser(xCausedBy, discordId, champions);
    print(result);
} catch (e) {
    print('Exception when calling ChampionsApi->createListOfPreferredChampionsForUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 
 **champions** | [**Champions**](Champions.md)| A list of champions. | [optional] 

### Return type

[**Champions**](Champions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removePreferredChampionForUser**
> Champions removePreferredChampionForUser(xCausedBy, discordId, champions)



Removes the requested champion to the users preferred champions.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = ChampionsApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player
final champions = []; // List<String> | The list of champion's names to remove from the user's list of champions

try {
    final result = api_instance.removePreferredChampionForUser(xCausedBy, discordId, champions);
    print(result);
} catch (e) {
    print('Exception when calling ChampionsApi->removePreferredChampionForUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 
 **champions** | [**List<String>**](String.md)| The list of champion's names to remove from the user's list of champions | [default to const []]

### Return type

[**Champions**](Champions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveUsersPreferredChampions**
> Champions retrieveUsersPreferredChampions(xCausedBy, discordId)



Returns a list of preferred champions that the User has.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = ChampionsApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player

try {
    final result = api_instance.retrieveUsersPreferredChampions(xCausedBy, discordId);
    print(result);
} catch (e) {
    print('Exception when calling ChampionsApi->retrieveUsersPreferredChampions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 

### Return type

[**Champions**](Champions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

