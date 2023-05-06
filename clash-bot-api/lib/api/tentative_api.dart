//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TentativeApi {
  TentativeApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Updates an existing Tentative queue.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tentativeId (required):
  ///   The unique identifier of the Clash Bot Tentative queue
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Response> assignUserToATentativeQueueWithHttpInfo(String xCausedBy, String tentativeId, String discordId,) async {
    // ignore: prefer_const_declarations
    final path = r'/tentatives/{tentativeId}/users/{discordId}'
      .replaceAll('{tentativeId}', tentativeId)
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'x-caused-by'] = parameterToString(xCausedBy);

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Updates an existing Tentative queue.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tentativeId (required):
  ///   The unique identifier of the Clash Bot Tentative queue
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Tentative?> assignUserToATentativeQueue(String xCausedBy, String tentativeId, String discordId,) async {
    final response = await assignUserToATentativeQueueWithHttpInfo(xCausedBy, tentativeId, discordId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tentative',) as Tentative;
    
    }
    return null;
  }

  /// Creates a Tentative queue.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [TentativeRequired] tentativeRequired:
  ///   Details to create a Clash Bot Tentative Queue with.
  Future<Response> createTentativeQueueWithHttpInfo(String xCausedBy, { TentativeRequired? tentativeRequired, }) async {
    // ignore: prefer_const_declarations
    final path = r'/tentatives';

    // ignore: prefer_final_locals
    Object? postBody = tentativeRequired;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'x-caused-by'] = parameterToString(xCausedBy);

    const contentTypes = <String>['application/json'];


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

  /// Creates a Tentative queue.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [TentativeRequired] tentativeRequired:
  ///   Details to create a Clash Bot Tentative Queue with.
  Future<Tentative?> createTentativeQueue(String xCausedBy, { TentativeRequired? tentativeRequired, }) async {
    final response = await createTentativeQueueWithHttpInfo(xCausedBy,  tentativeRequired: tentativeRequired, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tentative',) as Tentative;
    
    }
    return null;
  }

  /// Removes a User from the specified Tentative Queue.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tentativeId (required):
  ///   The unique identifier of the Clash Bot Tentative queue
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Response> removeUserFromTentativeQueueWithHttpInfo(String xCausedBy, String tentativeId, String discordId,) async {
    // ignore: prefer_const_declarations
    final path = r'/tentatives/{tentativeId}/users/{discordId}'
      .replaceAll('{tentativeId}', tentativeId)
      .replaceAll('{discordId}', discordId);

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

  /// Removes a User from the specified Tentative Queue.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tentativeId (required):
  ///   The unique identifier of the Clash Bot Tentative queue
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Tentative?> removeUserFromTentativeQueue(String xCausedBy, String tentativeId, String discordId,) async {
    final response = await removeUserFromTentativeQueueWithHttpInfo(xCausedBy, tentativeId, discordId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tentative',) as Tentative;
    
    }
    return null;
  }

  /// Retrieves a Tentative queues.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tentativeId (required):
  ///   The unique identifier of the Clash Bot Tentative queue
  Future<Response> retrieveTentativeQueueWithHttpInfo(String xCausedBy, String tentativeId,) async {
    // ignore: prefer_const_declarations
    final path = r'/tentatives/{tentativeId}'
      .replaceAll('{tentativeId}', tentativeId);

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

  /// Retrieves a Tentative queues.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tentativeId (required):
  ///   The unique identifier of the Clash Bot Tentative queue
  Future<Tentative?> retrieveTentativeQueue(String xCausedBy, String tentativeId,) async {
    final response = await retrieveTentativeQueueWithHttpInfo(xCausedBy, tentativeId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tentative',) as Tentative;
    
    }
    return null;
  }

  /// Retrieves a list of Tentative queues.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [bool] archived:
  ///   Will retrieve records that are from past Tournaments
  ///
  /// * [String] discordId:
  ///   The Discord id of the Player
  ///
  /// * [String] serverId:
  ///   The Discord id of the Discord Server
  ///
  /// * [String] tournamentName:
  ///   The LoL Clash Tournament name
  ///
  /// * [String] tournamentDay:
  ///   The LoL Clash Tournament day
  Future<Response> retrieveTentativeQueuesWithHttpInfo(String xCausedBy, { bool? archived, String? discordId, String? serverId, String? tournamentName, String? tournamentDay, }) async {
    // ignore: prefer_const_declarations
    final path = r'/tentatives';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (archived != null) {
      queryParams.addAll(_queryParams('', 'archived', archived));
    }
    if (discordId != null) {
      queryParams.addAll(_queryParams('', 'discordId', discordId));
    }
    if (serverId != null) {
      queryParams.addAll(_queryParams('', 'serverId', serverId));
    }
    if (tournamentName != null) {
      queryParams.addAll(_queryParams('', 'tournamentName', tournamentName));
    }
    if (tournamentDay != null) {
      queryParams.addAll(_queryParams('', 'tournamentDay', tournamentDay));
    }

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

  /// Retrieves a list of Tentative queues.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [bool] archived:
  ///   Will retrieve records that are from past Tournaments
  ///
  /// * [String] discordId:
  ///   The Discord id of the Player
  ///
  /// * [String] serverId:
  ///   The Discord id of the Discord Server
  ///
  /// * [String] tournamentName:
  ///   The LoL Clash Tournament name
  ///
  /// * [String] tournamentDay:
  ///   The LoL Clash Tournament day
  Future<Tentatives?> retrieveTentativeQueues(String xCausedBy, { bool? archived, String? discordId, String? serverId, String? tournamentName, String? tournamentDay, }) async {
    final response = await retrieveTentativeQueuesWithHttpInfo(xCausedBy,  archived: archived, discordId: discordId, serverId: serverId, tournamentName: tournamentName, tournamentDay: tournamentDay, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tentatives',) as Tentatives;
    
    }
    return null;
  }
}
