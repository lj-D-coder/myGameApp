import 'package:mygame/models/res/sign_up_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api.g.dart';

@RestApi(baseUrl: "https://56cd-117-214-14-205.ngrok-free.app/")
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;
  // Add other methods as needed

  @FormUrlEncoded()
  @POST("auth")
  Future<SignUpResponse> signUp(@Field() loginId, @Field() userName,
      @Field() phoneNo, @Field() email, @Field() userRole);
}
