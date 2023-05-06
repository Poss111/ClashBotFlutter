# clash_bot_api.model.Tentative

## Load the model package
```dart
import 'package:clash_bot_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | Unique identifier for the Tentative Queue. | [optional] 
**serverId** | **String** | The default Discord Server id for the player to use. | [optional] 
**tournamentDetails** | [**BaseTournament**](BaseTournament.md) |  | [optional] 
**tentativePlayers** | [**List<TentativePlayer>**](TentativePlayer.md) |  | [optional] [default to const []]
**lastUpdatedAt** | [**DateTime**](DateTime.md) | The timestamp that the object was updated at | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


