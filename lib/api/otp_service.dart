import 'package:mygame/models/res/otp_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'otp_service.g.dart';

@RestApi(baseUrl: "https://2factor.in/API/V1/")
abstract class OtpService {
  factory OtpService(Dio dio, {String baseUrl}) = _OtpService;
  // Add other methods as needed

  @GET("411d5bb4-9ff5-11ee-8cbb-0200cd936042/:phone/AUTOGEN3/LoginTemplate")
  Future<OtpResponse> generateOtp(@Path("phone") String phone);
}
