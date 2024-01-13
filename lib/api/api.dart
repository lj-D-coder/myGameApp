import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api.g.dart';

@RestApi(baseUrl: "https://example.com/api")
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;
  // Add other methods as needed
}
