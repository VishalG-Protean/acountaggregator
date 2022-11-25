

abstract class BaseApiServices {

  /// Use for Get Response.
  Future<dynamic> getGetApiResponse(String url);

  /// Use for Post Response.
  Future<dynamic> getPostApiResponse(String url , dynamic data);

}