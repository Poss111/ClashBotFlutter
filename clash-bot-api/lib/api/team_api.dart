//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TeamApi {
  TeamApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Assign's a User to the specified Team based on the role provided.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [PositionDetails] positionDetails (required):
  ///   Details to assign a user to a Team with.
  Future<Response> assignUserToTeamWithHttpInfo(String xCausedBy, String teamId, String discordId, PositionDetails positionDetails,) async {
    // ignore: prefer_const_declarations
    final path = r'/teams/{teamId}/users/{discordId}'
      .replaceAll('{teamId}', teamId)
      .replaceAll('{discordId}', discordId);

    // ignore: prefer_final_locals
    Object? postBody = positionDetails;

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

  /// Assign's a User to the specified Team based on the role provided.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  ///
  /// * [PositionDetails] positionDetails (required):
  ///   Details to assign a user to a Team with.
  Future<Team?> assignUserToTeam(String xCausedBy, String teamId, String discordId, PositionDetails positionDetails,) async {
    final response = await assignUserToTeamWithHttpInfo(xCausedBy, teamId, discordId, positionDetails,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Team',) as Team;
    
    }
    return null;
  }

  /// Creates a Team with the defined details
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [TeamRequired] teamRequired (required):
  ///   Details to create a Clash Bot Team with.
  Future<Response> createTeamWithHttpInfo(String xCausedBy, TeamRequired teamRequired,) async {
    // ignore: prefer_const_declarations
    final path = r'/teams';

    // ignore: prefer_final_locals
    Object? postBody = teamRequired;

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

  /// Creates a Team with the defined details
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [TeamRequired] teamRequired (required):
  ///   Details to create a Clash Bot Team with.
  Future<Team?> createTeam(String xCausedBy, TeamRequired teamRequired,) async {
    final response = await createTeamWithHttpInfo(xCausedBy, teamRequired,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Team',) as Team;
    
    }
    return null;
  }

  /// Removes a User from the specified Team.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Response> removeUserFromTeamWithHttpInfo(String xCausedBy, String teamId, String discordId,) async {
    // ignore: prefer_const_declarations
    final path = r'/teams/{teamId}/users/{discordId}'
      .replaceAll('{teamId}', teamId)
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

  /// Removes a User from the specified Team.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  ///
  /// * [String] discordId (required):
  ///   The Discord id of the Player
  Future<Team?> removeUserFromTeam(String xCausedBy, String teamId, String discordId,) async {
    final response = await removeUserFromTeamWithHttpInfo(xCausedBy, teamId, discordId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Team',) as Team;
    
    }
    return null;
  }

  /// Returns a single Clash Bot Team based on the id provided.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  Future<Response> retrieveTeamBasedOnIdWithHttpInfo(String xCausedBy, String teamId,) async {
    // ignore: prefer_const_declarations
    final path = r'/teams/{teamId}'
      .replaceAll('{teamId}', teamId);

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

  /// Returns a single Clash Bot Team based on the id provided.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  Future<Team?> retrieveTeamBasedOnId(String xCausedBy, String teamId,) async {
    final response = await retrieveTeamBasedOnIdWithHttpInfo(xCausedBy, teamId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Team',) as Team;
    
    }
    return null;
  }

  /// Returns a list of Teams.
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
  Future<Response> retrieveTeamsWithHttpInfo(String xCausedBy, { bool? archived, String? discordId, String? serverId, String? tournamentName, String? tournamentDay, }) async {
    // ignore: prefer_const_declarations
    final path = r'/teams';

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

  /// Returns a list of Teams.
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
  Future<Teams?> retrieveTeams(String xCausedBy, { bool? archived, String? discordId, String? serverId, String? tournamentName, String? tournamentDay, }) async {
    final response = await retrieveTeamsWithHttpInfo(xCausedBy,  archived: archived, discordId: discordId, serverId: serverId, tournamentName: tournamentName, tournamentDay: tournamentDay, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Teams',) as Teams;
    
    }
    return null;
  }

  /// Updates an existing Clash Bot Team's metadata.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  ///
  /// * [TeamUpdate] teamUpdate (required):
  ///   Details to update a Clash Bot Team's metadata with.
  Future<Response> updateTeamWithHttpInfo(String xCausedBy, String teamId, TeamUpdate teamUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/teams/{teamId}'
      .replaceAll('{teamId}', teamId);

    // ignore: prefer_final_locals
    Object? postBody = teamUpdate;

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

  /// Updates an existing Clash Bot Team's metadata.
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] teamId (required):
  ///   The unique identifier of the Clash Bot Team
  ///
  /// * [TeamUpdate] teamUpdate (required):
  ///   Details to update a Clash Bot Team's metadata with.
  Future<Team?> updateTeam(String xCausedBy, String teamId, TeamUpdate teamUpdate,) async {
    final response = await updateTeamWithHttpInfo(xCausedBy, teamId, teamUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Team',) as Team;
    
    }
    return null;
  }
}
