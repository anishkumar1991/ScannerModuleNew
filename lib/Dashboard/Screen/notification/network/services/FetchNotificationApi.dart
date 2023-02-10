import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../../Values/string.dart';

part 'FetchNotificationApi.g.dart';

@RestApi(baseUrl: "http://35.200.202.116")
abstract class FetchNotificationApi {
  factory FetchNotificationApi(Dio dio) = _FetchNotificationApi;

  @GET('/notification/api/notification_phone')
  Future<HttpResponse> getNotification(
      @Header('Authorization') String token);
}
