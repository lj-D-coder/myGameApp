import 'package:mygame/models/res/otp_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/res/otp_verify_response.dart';
part 'otp_service.g.dart';

@RestApi(
    baseUrl: "https://2factor.in/API/V1/411d5bb4-9ff5-11ee-8cbb-0200cd936042/")
abstract class OtpService {
  factory OtpService(Dio dio, {String baseUrl}) = _OtpService;
  // Add other methods as needed

  @GET("SMS/{phone}/AUTOGEN3/LoginTemplate")
  Future<OtpResponse> generateOtp(@Path("phone") String phone);

  @GET("SMS/VERIFY/{session}/{otp}")
  Future<OtpVerifyResponse> verifyPin(
      @Path("session") String session, @Path("otp") otp);
}
