//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MaintenanceApi {
  MaintenanceApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Will move all Teams and Tentative Queues that are now inactive into an archive table.  This will help keep current operations clean and quick. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  Future<Response> archiveTeamsAndTentativeQueuesWithHttpInfo(String xCausedBy,) async {
    // ignore: prefer_const_declarations
    final path = r'/archive';

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

  /// Will move all Teams and Tentative Queues that are now inactive into an archive table.  This will help keep current operations clean and quick. 
  ///
  /// Parameters:
  ///
  /// * [String] xCausedBy (required):
  Future<ArchiveMetadata?> archiveTeamsAndTentativeQueues(String xCausedBy,) async {
    final response = await archiveTeamsAndTentativeQueuesWithHttpInfo(xCausedBy,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ArchiveMetadata',) as ArchiveMetadata;
    
    }
    return null;
  }
}
