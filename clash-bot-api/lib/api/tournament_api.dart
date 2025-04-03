//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TournamentApi {
  TournamentApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// To create a Tournament
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [DetailedTournament] detailedTournament:
  Future<Response> createTournamentWithHttpInfo(String xCausedBy, { DetailedTournament? detailedTournament, }) async {
    // ignore: prefer_const_declarations
    final path = r'/tournaments';

    // ignore: prefer_final_locals
    Object? postBody = detailedTournament;

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

  /// To create a Tournament
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [DetailedTournament] detailedTournament:
  Future<DetailedTournament?> createTournament(String xCausedBy, { DetailedTournament? detailedTournament, }) async {
    final response = await createTournamentWithHttpInfo(xCausedBy,  detailedTournament: detailedTournament, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DetailedTournament',) as DetailedTournament;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /tournaments' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tournament:
  ///   The Tournament name to filter by.
  ///
  /// * [String] day:
  ///   The tournament day to filter by.
  ///
  /// * [bool] upcomingOnly:
  ///   Whether to return only upcoming tournaments or not?
  Future<Response> getTournamentsWithHttpInfo(String xCausedBy, { String? tournament, String? day, bool? upcomingOnly, }) async {
    // ignore: prefer_const_declarations
    final path = r'/tournaments';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (tournament != null) {
      queryParams.addAll(_queryParams('', 'tournament', tournament));
    }
    if (day != null) {
      queryParams.addAll(_queryParams('', 'day', day));
    }
    if (upcomingOnly != null) {
      queryParams.addAll(_queryParams('', 'upcomingOnly', upcomingOnly));
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

  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  ///
  /// * [String] tournament:
  ///   The Tournament name to filter by.
  ///
  /// * [String] day:
  ///   The tournament day to filter by.
  ///
  /// * [bool] upcomingOnly:
  ///   Whether to return only upcoming tournaments or not?
  Future<Tournaments?> getTournaments(String xCausedBy, { String? tournament, String? day, bool? upcomingOnly, }) async {
    final response = await getTournamentsWithHttpInfo(xCausedBy,  tournament: tournament, day: day, upcomingOnly: upcomingOnly, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tournaments',) as Tournaments;
    
    }
    return null;
  }

  /// Will retrieve Clash Tournaments from Riot's League of Legends API
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> retrieveRiotClashTournamentsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/tournaments/riot';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

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

  /// Will retrieve Clash Tournaments from Riot's League of Legends API
  Future<Tournaments?> retrieveRiotClashTournaments() async {
    final response = await retrieveRiotClashTournamentsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tournaments',) as Tournaments;
    
    }
    return null;
  }
}
