//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UserApi {
  UserApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Adds the selected server to the users selected servers. Cannot be greater than a length of 5.
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
  /// * [Servers] servers:
  ///   A list of Discord Servers.
  Future<Response> addUsersSelectedServersWithHttpInfo(String xCausedBy, String discordId, { Servers? servers, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/servers'
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody = servers;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'x-caused-by'] = parameterToString(xCausedBy);

    const contentTypes = <String>['application/json'];


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

  /// Adds the selected server to the users selected servers. Cannot be greater than a length of 5.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [Servers] servers:
  ///   A list of Discord Servers.
  Future<Servers?> addUsersSelectedServers(String xCausedBy, String discordId, { Servers? servers, }) async {
    final response = await addUsersSelectedServersWithHttpInfo(xCausedBy, discordId,  servers: servers, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Servers',) as Servers;
    
    }
    return null;
  }

  /// Create a new Clash Bot Player.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [CreateUserRequest] createUserRequest:
  ///   All necessary parameters to create a new Player
  Future<Response> createUserWithHttpInfo(String xCausedBy, { CreateUserRequest? createUserRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users';

    // ignore: prefer_final_locals
    Object? postBody = createUserRequest;

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

  /// Create a new Clash Bot Player.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [CreateUserRequest] createUserRequest:
  ///   All necessary parameters to create a new Player
  Future<Player?> createUser(String xCausedBy, { CreateUserRequest? createUserRequest, }) async {
    final response = await createUserWithHttpInfo(xCausedBy,  createUserRequest: createUserRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Player',) as Player;
    
    }
    return null;
  }

  /// Updates the users selected servers with an entirely new list. Cannot be greater than a length of 5.
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
  /// * [Servers] servers:
  ///   A list of Discord Servers.
  Future<Response> createUsersSelectedServersWithHttpInfo(String xCausedBy, String discordId, { Servers? servers, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/servers'
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody = servers;

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

  /// Updates the users selected servers with an entirely new list. Cannot be greater than a length of 5.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [Servers] servers:
  ///   A list of Discord Servers.
  Future<Servers?> createUsersSelectedServers(String xCausedBy, String discordId, { Servers? servers, }) async {
    final response = await createUsersSelectedServersWithHttpInfo(xCausedBy, discordId,  servers: servers, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Servers',) as Servers;
    
    }
    return null;
  }

  /// Retrieve a Clash Bot Player Details
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId:
  ///   The Discord id of the Player
  Future<Response> getUserWithHttpInfo(String xCausedBy, { String? discordId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (discordId != null) {
      queryParams.addAll(_queryParams('', 'discordId', discordId));
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

  /// Retrieve a Clash Bot Player Details
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId:
  ///   The Discord id of the Player
  Future<Player?> getUser(String xCausedBy, { String? discordId, }) async {
    final response = await getUserWithHttpInfo(xCausedBy,  discordId: discordId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Player',) as Player;
    
    }
    return null;
  }

  /// Removes the selected server to the users selected servers.
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
  /// * [List<String>] champions (required):
  ///   The list of selected servers to remove from the user's list of champions
  Future<Response> removeUsersSelectedServersWithHttpInfo(String xCausedBy, String discordId, List<String> champions,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/servers'
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('multi', 'champions', champions));

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

  /// Removes the selected server to the users selected servers.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [List<String>] champions (required):
  ///   The list of selected servers to remove from the user's list of champions
  Future<Servers?> removeUsersSelectedServers(String xCausedBy, String discordId, List<String> champions,) async {
    final response = await removeUsersSelectedServersWithHttpInfo(xCausedBy, discordId, champions,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Servers',) as Servers;
    
    }
    return null;
  }

  /// Returns a list of selected servers that the User has.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Response> retrieveUsersSelectedServersWithHttpInfo(String xCausedBy, String discordId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/servers'
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
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Returns a list of selected servers that the User has.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Servers?> retrieveUsersSelectedServers(String xCausedBy, String discordId,) async {
    final response = await retrieveUsersSelectedServersWithHttpInfo(xCausedBy, discordId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Servers',) as Servers;
    
    }
    return null;
  }

  /// Update an existing Clash Bot Player.
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
  /// * [UpdateUserRequest] updateUserRequest:
  ///   All necessary parameters to update an existing Player
  Future<Response> updateUserWithHttpInfo(String xCausedBy, String discordId, { UpdateUserRequest? updateUserRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}'
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody = updateUserRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    headerParams[r'x-caused-by'] = parameterToString(xCausedBy);

    const contentTypes = <String>['application/json'];


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

  /// Update an existing Clash Bot Player.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [UpdateUserRequest] updateUserRequest:
  ///   All necessary parameters to update an existing Player
  Future<Player?> updateUser(String xCausedBy, String discordId, { UpdateUserRequest? updateUserRequest, }) async {
    final response = await updateUserWithHttpInfo(xCausedBy, discordId,  updateUserRequest: updateUserRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Player',) as Player;
    
    }
    return null;
  }
}
