# openapi.model.Player

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**discordId** | **String** | Discord Id for the Player | [optional] 
**name** | **String** | The Players discord name | [optional] 
**role** | [**Role**](Role.md) |  | [optional] 
**champions** | [**List<Champion>**](Champion.md) | A list of the Users preferred champions. | [optional] [default to const []]
**subscriptions** | [**List<Subscription>**](Subscription.md) |  | [optional] [default to const []]
**serverId** | **String** | The Discord Server id that the User is defaulted to. | [optional] 
**selectedServers** | **List<String>** | The list of available Discord Servers for the player to filter by. | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


