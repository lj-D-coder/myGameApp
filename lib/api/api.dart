import 'package:mygame/models/req/add_business_model.dart';
import 'package:mygame/models/req/sign_up_request.dart';
import 'package:mygame/models/res/add_business_response.dart';
import 'package:mygame/models/res/all_biz_info_response.dart';
import 'package:mygame/models/res/genereic_response.dart';
import 'package:mygame/models/res/sign_up_response.dart';
import 'package:mygame/models/res/simple_response.dart';
import 'package:mygame/models/res/single_biz_info.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/res/serializable.dart';
part 'api.g.dart';

@RestApi(baseUrl: "https://mygame-eight.vercel.app/api/")
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;
  // Add other methods as needed

  @POST("auth")
  Future<SignUpResponse> signUp(@Header("Content-Type") String contentType,
      @Body() SignUpRequest request);

  @POST("business/setup")
  Future<AddBusinessResponse> addBusiness(
      @Header("Content-Type") String contentType,
      @Body() AddBusinessModel request);

  @GET("business/setup")
  Future<AllBusinessInfoResponse> getAllBusiness(
      @Header("Content-Type") String contentType);

  @GET("business/setup/{id}")
  Future<GenericResponse<SingleBusinessInfo>> getBusinessInfo(
      @Header("Content-Type") String contentType, @Path("id") String id);

  @DELETE("business/setup/{id}")
  Future<SimpleResponse> deleteBusiness(
      @Header("Content-Type") String contentType, @Path("id") String id);

  @PUT("business/setup/{id}")
  Future<SimpleResponse> updateBusiness(
      @Header("Content-Type") String contentType,
      @Path("id") String id,
      @Body() AddBusinessModel request);

  @PUT("business/setup/{id}")
  Future<SimpleResponse> saveBusinessInfo(
      @Header("Content-Type") String contentType,
      @Path("id") String id,
      @Body() BusinessData request);
}
