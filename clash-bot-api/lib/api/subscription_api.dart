//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SubscriptionApi {
  SubscriptionApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Retrieve details on a user's subscription.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [SubscriptionType] subscription (required):
  ///   The subscription type.
  Future<Response> isUserSubscribedWithHttpInfo(String xCausedBy, String discordId, SubscriptionType subscription,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/subscriptions/{subscription}'
      .replaceAll('{discordId}', discordId)
      .replaceAll('{subscription}', subscription.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'x-caused-by'] = parameterToString(xCausedBy);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Retrieve details on a user's subscription.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [SubscriptionType] subscription (required):
  ///   The subscription type.
  Future<Subscription?> isUserSubscribed(String xCausedBy, String discordId, SubscriptionType subscription,) async {
    final response = await isUserSubscribedWithHttpInfo(xCausedBy, discordId, subscription,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Subscription',) as Subscription;
    
    }
    return null;
  }

  /// Subscribes the User to the specified subscription.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [SubscriptionType] subscription (required):
  ///   The subscription type.
  Future<Response> subscribeUserWithHttpInfo(String xCausedBy, String discordId, SubscriptionType subscription,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/subscriptions/{subscription}'
      .replaceAll('{discordId}', discordId)
      .replaceAll('{subscription}', subscription.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'x-caused-by'] = parameterToString(xCausedBy);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Subscribes the User to the specified subscription.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [SubscriptionType] subscription (required):
  ///   The subscription type.
  Future<Subscription?> subscribeUser(String xCausedBy, String discordId, SubscriptionType subscription,) async {
    final response = await subscribeUserWithHttpInfo(xCausedBy, discordId, subscription,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Subscription',) as Subscription;
    
    }
    return null;
  }

  /// Unsubscribes the User from the specified subscription.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [SubscriptionType] subscription (required):
  ///   The subscription type.
  Future<Response> unsubscribeUserWithHttpInfo(String xCausedBy, String discordId, SubscriptionType subscription,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/subscriptions/{subscription}'
      .replaceAll('{discordId}', discordId)
      .replaceAll('{subscription}', subscription.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'x-caused-by'] = parameterToString(xCausedBy);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Unsubscribes the User from the specified subscription.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [SubscriptionType] subscription (required):
  ///   The subscription type.
  Future<Subscription?> unsubscribeUser(String xCausedBy, String discordId, SubscriptionType subscription,) async {
    final response = await unsubscribeUserWithHttpInfo(xCausedBy, discordId, subscription,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Subscription',) as Subscription;
    
    }
    return null;
  }
}
