import 'dart:io';

import 'package:mygame/models/req/add_business_model.dart';
import 'package:mygame/models/req/booking_dropped.dart';
import 'package:mygame/models/req/booking_request.dart';
import 'package:mygame/models/req/confirm_booking.dart';
import 'package:mygame/models/req/follow_req.dart';
import 'package:mygame/models/req/friend_req.dart';
import 'package:mygame/models/req/get_ranges_req.dart';
import 'package:mygame/models/req/homefeed_request.dart';
import 'package:mygame/models/req/pricing_request.dart';
import 'package:mygame/models/req/save_token_req.dart';
import 'package:mygame/models/req/sign_up_request.dart';
import 'package:mygame/models/req/update_location_req.dart';
import 'package:mygame/models/res/add_business_response.dart';
import 'package:mygame/models/res/all_biz_info_response.dart';
import 'package:mygame/models/res/booking_response.dart';
import 'package:mygame/models/res/client_booking_list_response.dart';
import 'package:mygame/models/res/follower_res.dart';
import 'package:mygame/models/res/friend_res.dart';
import 'package:mygame/models/res/genereic_response.dart';
import 'package:mygame/models/res/get_all_matches_response.dart';
import 'package:mygame/models/res/get_ranges_response.dart';
import 'package:mygame/models/res/home_feed_response.dart';
import 'package:mygame/models/res/match_details.dart';
import 'package:mygame/models/res/pricing_response.dart';
import 'package:mygame/models/res/sign_up_response.dart';
import 'package:mygame/models/res/simple_response.dart';
import 'package:mygame/models/res/single_biz_info.dart';
import 'package:mygame/models/res/user_profile.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://mygame-eight.vercel.app/api/")
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;
  // Add other methods as needed

  @POST("auth")
  Future<SignUpResponse> signUp(
      @Header("Content-Type") String contentType, @Body() SignUpRequest request);

  @POST("business/setup")
  Future<AddBusinessResponse> addBusiness(
      @Header("Content-Type") String contentType, @Body() AddBusinessModel request);

  @GET("business/setup")
  Future<AllBusinessInfoResponse> getAllBusiness(@Header("Content-Type") String contentType);

  @GET("business/setup/{id}")
  Future<GenericResponse<SingleBusinessInfo>> getBusinessInfo(
      @Header("Content-Type") String contentType, @Path("id") String id);

  @DELETE("business/setup/{id}")
  Future<SimpleResponse> deleteBusiness(
      @Header("Content-Type") String contentType, @Path("id") String id);

  @PUT("business/setup/{id}")
  Future<SimpleResponse> updateBusiness(@Header("Content-Type") String contentType,
      @Path("id") String id, @Body() AddBusinessModel request);

  @PATCH("business/setup/{id}")
  Future<SimpleResponse> saveBusinessInfo(@Header("Content-Type") String contentType,
      @Path("id") String id, @Body() BusinessData request);

  @POST("business/pricing")
  Future<PricingResponse> savePrice(
      @Header("Content-Type") String contentType, @Body() PricingRequest request);

  @POST("upload")
  @MultiPart()
  Future<SimpleResponse> uploadFile(
    @Part(name: 'businessID') String businessID,
    @Part(name: "image", fileName: "image") File file,
  );

  @POST("upload/profile-photo")
  @MultiPart()
  Future<SimpleResponse> uploadProfile(
    @Part(name: 'userId') String userId,
    @Part(name: "image", fileName: "image") File file,
  );

  @POST("client/booking")
  Future<BookingResponse> booking(
      @Header("Content-Type") String contentType, @Body() BookingRequest request);

  @POST("client/booking/confirmation")
  Future<SimpleResponse> confirmBooking(
      @Header("Content-Type") String contentType, @Body() ConfirmBookingRequest request);

  @POST("client/timeRange")
  Future<GetRangesResponse> getTimeRanges(
      @Header("Content-Type") String contentType, @Body() GetRangesReq request);

  @POST("client/timeRange/playground")
  Future<GetRangesResponse> getTimeRangesPlayground(
      @Header("Content-Type") String contentType, @Body() GetRangesReq request);

  @POST("client/booking/dropped")
  Future<SimpleResponse> droppedBooking(
      @Header("Content-Type") String contentType, @Body() BookingDropped request);

  @POST("location/nearby-ground")
  Future<HomeFeedResponse> homeFeed(
      @Header("Content-Type") String contentType, @Body() HomeFeedRequest request);

  @GET("business/matches/{id}")
  Future<AllMatchesResponse> getAllMatchesUnderBusiness(
      @Header("Content-Type") String contentType, @Path("id") id);

  @GET("match/{id}")
  Future<MatchDetailResponse> getMatchDetails(
      @Header("Content-Type") String contentType, @Path("id") id);

  @GET("client/my-booking/{id}")
  Future<MyBookingResponse> getClientBooking(
      @Header("Content-Type") String contentType, @Path("id") id);

  @POST("client/update-location")
  Future<SimpleResponse> updateUserLocation(
      @Header("Content-Type") String contentType, @Body() UpdateLocationReq body);

  @POST("client/nearby-friend-suggestion")
  Future<FriendRes> findFriends(@Header("Content-Type") String contentType, @Body() FriendReq body);

  @GET("client/follow/{id}")
  Future<FollowerRes> getFollower(
      @Header("Content-Type") String contentType, @Path("id") String id);

  @POST("client/follow")
  Future<SimpleResponse> follow(@Header("Content-Type") String contentType, @Body() FollowReq body);

  @DELETE("client/follow/{id}")
  Future<SimpleResponse> unfollow(
      @Header("Content-Type") String contentType, @Path('id') String id, @Body() FollowReq req);

  @POST("firebase/save-token")
  Future<SimpleResponse> saveToken(
      @Header("Content-Type") String contentType, @Body() FirebaseSaveTokenReq req);

  @GET("user-profile/{id}")
  Future<UserProfileRes> getProfile(
      @Header("Content-Type") String contentType, @Path('id') String id);
  // @POST("client/location/nearby-ground")
  // Future<SimpleResponse> homefeed(@Header("Content-Type") String contentType, @Body() BookingDropped request);
}
