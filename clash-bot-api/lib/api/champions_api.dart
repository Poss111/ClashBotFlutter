//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ChampionsApi {
  ChampionsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Adds the requested champion to the users preferred champions. Cannot be greater than a length of 5.
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
  /// * [Champions] champions:
  ///   A list of champions.
  Future<Response> addToPreferredChampionsForUserWithHttpInfo(String xCausedBy, String discordId, { Champions? champions, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/champions'
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody = champions;

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

  /// Adds the requested champion to the users preferred champions. Cannot be greater than a length of 5.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [Champions] champions:
  ///   A list of champions.
  Future<Champions?> addToPreferredChampionsForUser(String xCausedBy, String discordId, { Champions? champions, }) async {
    final response = await addToPreferredChampionsForUserWithHttpInfo(xCausedBy, discordId,  champions: champions, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Champions',) as Champions;
    
    }
    return null;
  }

  /// Updates the users preferred champions with an entirely new list. Cannot be greater than a length of 5.
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
  /// * [Champions] champions:
  ///   A list of champions.
  Future<Response> createListOfPreferredChampionsForUserWithHttpInfo(String xCausedBy, String discordId, { Champions? champions, }) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/champions'
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody = champions;

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

  /// Updates the users preferred champions with an entirely new list. Cannot be greater than a length of 5.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [Champions] champions:
  ///   A list of champions.
  Future<Champions?> createListOfPreferredChampionsForUser(String xCausedBy, String discordId, { Champions? champions, }) async {
    final response = await createListOfPreferredChampionsForUserWithHttpInfo(xCausedBy, discordId,  champions: champions, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Champions',) as Champions;
    
    }
    return null;
  }

  /// Removes the requested champion to the users preferred champions.
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
  ///   The list of champion's names to remove from the user's list of champions
  Future<Response> removePreferredChampionForUserWithHttpInfo(String xCausedBy, String discordId, List<String> champions,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/champions'
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

  /// Removes the requested champion to the users preferred champions.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [List<String>] champions (required):
  ///   The list of champion's names to remove from the user's list of champions
  Future<Champions?> removePreferredChampionForUser(String xCausedBy, String discordId, List<String> champions,) async {
    final response = await removePreferredChampionForUserWithHttpInfo(xCausedBy, discordId, champions,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Champions',) as Champions;
    
    }
    return null;
  }

  /// Returns a list of preferred champions that the User has.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Response> retrieveUsersPreferredChampionsWithHttpInfo(String xCausedBy, String discordId,) async {
    // ignore: prefer_const_declarations
    final path = r'/users/{discordId}/champions'
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

  /// Returns a list of preferred champions that the User has.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Champions?> retrieveUsersPreferredChampions(String xCausedBy, String discordId,) async {
    final response = await retrieveUsersPreferredChampionsWithHttpInfo(xCausedBy, discordId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Champions',) as Champions;
    
    }
    return null;
  }
}
