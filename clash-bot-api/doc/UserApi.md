# clash_bot_api.api.UserApi

## Load the API package
```dart
import 'package:clash_bot_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUsersSelectedServers**](UserApi.md#addusersselectedservers) | **PATCH** /users/{discordId}/servers | 
[**createUser**](UserApi.md#createuser) | **POST** /users | 
[**createUsersSelectedServers**](UserApi.md#createusersselectedservers) | **POST** /users/{discordId}/servers | 
[**getUser**](UserApi.md#getuser) | **GET** /users | 
[**removeUsersSelectedServers**](UserApi.md#removeusersselectedservers) | **DELETE** /users/{discordId}/servers | 
[**retrieveUsersSelectedServers**](UserApi.md#retrieveusersselectedservers) | **GET** /users/{discordId}/servers | 
[**updateUser**](UserApi.md#updateuser) | **PATCH** /users/{discordId} | 


# **addUsersSelectedServers**
> Servers addUsersSelectedServers(xCausedBy, discordId, servers)



Adds the selected server to the users selected servers. Cannot be greater than a length of 5.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = UserApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player
final servers = Servers(); // Servers | A list of Discord Servers.

try {
    final result = api_instance.addUsersSelectedServers(xCausedBy, discordId, servers);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->addUsersSelectedServers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 
 **servers** | [**Servers**](Servers.md)| A list of Discord Servers. | [optional] 

### Return type

[**Servers**](Servers.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUser**
> Player createUser(xCausedBy, createUserRequest)



Create a new Clash Bot Player.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = UserApi();
final xCausedBy = xCausedBy_example; // String | 
final createUserRequest = CreateUserRequest(); // CreateUserRequest | All necessary parameters to create a new Player

try {
    final result = api_instance.createUser(xCausedBy, createUserRequest);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **createUserRequest** | [**CreateUserRequest**](CreateUserRequest.md)| All necessary parameters to create a new Player | [optional] 

### Return type

[**Player**](Player.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUsersSelectedServers**
> Servers createUsersSelectedServers(xCausedBy, discordId, servers)



Updates the users selected servers with an entirely new list. Cannot be greater than a length of 5.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = UserApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player
final servers = Servers(); // Servers | A list of Discord Servers.

try {
    final result = api_instance.createUsersSelectedServers(xCausedBy, discordId, servers);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->createUsersSelectedServers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 
 **servers** | [**Servers**](Servers.md)| A list of Discord Servers. | [optional] 

### Return type

[**Servers**](Servers.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUser**
> Player getUser(xCausedBy, discordId)



Retrieve a Clash Bot Player Details

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = UserApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player

try {
    final result = api_instance.getUser(xCausedBy, discordId);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->getUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | [optional] 

### Return type

[**Player**](Player.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeUsersSelectedServers**
> Servers removeUsersSelectedServers(xCausedBy, discordId, champions)



Removes the selected server to the users selected servers.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = UserApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player
final champions = []; // List<String> | The list of selected servers to remove from the user's list of champions

try {
    final result = api_instance.removeUsersSelectedServers(xCausedBy, discordId, champions);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->removeUsersSelectedServers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 
 **champions** | [**List<String>**](String.md)| The list of selected servers to remove from the user's list of champions | [default to const []]

### Return type

[**Servers**](Servers.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveUsersSelectedServers**
> Servers retrieveUsersSelectedServers(xCausedBy, discordId)



Returns a list of selected servers that the User has.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = UserApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player

try {
    final result = api_instance.retrieveUsersSelectedServers(xCausedBy, discordId);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->retrieveUsersSelectedServers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 

### Return type

[**Servers**](Servers.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> Player updateUser(xCausedBy, discordId, updateUserRequest)



Update an existing Clash Bot Player.

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = UserApi();
final xCausedBy = xCausedBy_example; // String | 
final discordId = discordId_example; // String | The Discord id of the Player
final updateUserRequest = UpdateUserRequest(); // UpdateUserRequest | All necessary parameters to update an existing Player

try {
    final result = api_instance.updateUser(xCausedBy, discordId, updateUserRequest);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **discordId** | **String**| The Discord id of the Player | 
 **updateUserRequest** | [**UpdateUserRequest**](UpdateUserRequest.md)| All necessary parameters to update an existing Player | [optional] 

### Return type

[**Player**](Player.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

