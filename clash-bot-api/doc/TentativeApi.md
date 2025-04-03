# openapi.api.TentativeApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**assignUserToATentativeQueue**](TentativeApi.md#assignusertoatentativequeue) | **PATCH** /tentatives/{tentativeId}/users/{discordId} | 
[**createTentativeQueue**](TentativeApi.md#createtentativequeue) | **POST** /tentatives | 
[**removeUserFromTentativeQueue**](TentativeApi.md#removeuserfromtentativequeue) | **DELETE** /tentatives/{tentativeId}/users/{discordId} | 
[**retrieveTentativeQueue**](TentativeApi.md#retrievetentativequeue) | **GET** /tentatives/{tentativeId} | 
[**retrieveTentativeQueues**](TentativeApi.md#retrievetentativequeues) | **GET** /tentatives | 


# **assignUserToATentativeQueue**
> Tentative assignUserToATentativeQueue(xCausedBy, tentativeId, discordId)



Updates an existing Tentative queue.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = TentativeApi();
final xCausedBy = xCausedBy_example; // String | 
final tentativeId = tentativeId_example; // String | The unique identifier of the Clash Bot Tentative queue
final discordId = discordId_example; // String | The Discord id of the Player

try {
    final result = api_instance.assignUserToATentativeQueue(xCausedBy, tentativeId, discordId);
    print(result);
} catch (e) {
    print('Exception when calling TentativeApi->assignUserToATentativeQueue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **tentativeId** | **String**| The unique identifier of the Clash Bot Tentative queue | 
 **discordId** | **String**| The Discord id of the Player | 

### Return type

[**Tentative**](Tentative.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createTentativeQueue**
> Tentative createTentativeQueue(xCausedBy, tentativeRequired)



Creates a Tentative queue.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = TentativeApi();
final xCausedBy = xCausedBy_example; // String | 
final tentativeRequired = TentativeRequired(); // TentativeRequired | Details to create a Clash Bot Tentative Queue with.

try {
    final result = api_instance.createTentativeQueue(xCausedBy, tentativeRequired);
    print(result);
} catch (e) {
    print('Exception when calling TentativeApi->createTentativeQueue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **tentativeRequired** | [**TentativeRequired**](TentativeRequired.md)| Details to create a Clash Bot Tentative Queue with. | [optional] 

### Return type

[**Tentative**](Tentative.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeUserFromTentativeQueue**
> Tentative removeUserFromTentativeQueue(xCausedBy, tentativeId, discordId)



Removes a User from the specified Tentative Queue.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = TentativeApi();
final xCausedBy = xCausedBy_example; // String | 
final tentativeId = tentativeId_example; // String | The unique identifier of the Clash Bot Tentative queue
final discordId = discordId_example; // String | The Discord id of the Player

try {
    final result = api_instance.removeUserFromTentativeQueue(xCausedBy, tentativeId, discordId);
    print(result);
} catch (e) {
    print('Exception when calling TentativeApi->removeUserFromTentativeQueue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **tentativeId** | **String**| The unique identifier of the Clash Bot Tentative queue | 
 **discordId** | **String**| The Discord id of the Player | 

### Return type

[**Tentative**](Tentative.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveTentativeQueue**
> Tentative retrieveTentativeQueue(xCausedBy, tentativeId)



Retrieves a Tentative queues.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = TentativeApi();
final xCausedBy = xCausedBy_example; // String | 
final tentativeId = tentativeId_example; // String | The unique identifier of the Clash Bot Tentative queue

try {
    final result = api_instance.retrieveTentativeQueue(xCausedBy, tentativeId);
    print(result);
} catch (e) {
    print('Exception when calling TentativeApi->retrieveTentativeQueue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']
 **tentativeId** | **String**| The unique identifier of the Clash Bot Tentative queue | 

### Return type

[**Tentative**](Tentative.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **retrieveTentativeQueues**
> Tentatives retrieveTentativeQueues(xCausedBy, archived, discordId, serverId, tournamentName, tournamentDay)



Retrieves a list of Tentative queues.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = TentativeApi();
final xCausedBy = xCausedBy_example; // String | 
final archived = true; // bool | Will retrieve records that are from past Tournaments
final discordId = discordId_example; // String | The Discord id of the Player
final serverId = serverId_example; // String | The Discord id of the Discord Server
final tournamentName = tournamentName_example; // String | The LoL Clash Tournament name
final tournamentDay = tournamentDay_example; // String | The LoL Clash Tournament day

try {
    final result = api_instance.retrieveTentativeQueues(xCausedBy, archived, discordId, serverId, tournamentName, tournamentDay);
    print(result);
} catch (e) {
    print('Exception when calling TentativeApi->retrieveTentativeQueues: $e\n');
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

[**Tentatives**](Tentatives.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

