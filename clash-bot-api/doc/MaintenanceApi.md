# clash_bot_api.api.MaintenanceApi

## Load the API package
```dart
import 'package:clash_bot_api/api.dart';
```

All URIs are relative to *http://localhost:8080/api/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archiveTeamsAndTentativeQueues**](MaintenanceApi.md#archiveteamsandtentativequeues) | **POST** /archive | 


# **archiveTeamsAndTentativeQueues**
> ArchiveMetadata archiveTeamsAndTentativeQueues(xCausedBy)



Will move all Teams and Tentative Queues that are now inactive into an archive table.  This will help keep current operations clean and quick. 

### Example
```dart
import 'package:clash_bot_api/api.dart';

final api_instance = MaintenanceApi();
final xCausedBy = xCausedBy_example; // String | 

try {
    final result = api_instance.archiveTeamsAndTentativeQueues(xCausedBy);
    print(result);
} catch (e) {
    print('Exception when calling MaintenanceApi->archiveTeamsAndTentativeQueues: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xCausedBy** | **String**|  | [default to 'Not Found']

### Return type

[**ArchiveMetadata**](ArchiveMetadata.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

