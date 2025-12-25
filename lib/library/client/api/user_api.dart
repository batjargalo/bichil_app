import 'package:bichil/library/library.dart';

class UserApi extends IOClient {
  Future<IOResponse> login({
    required String username,
    required String password,
  }) async {
    const path = '/api/token/';
    final data = {
      'device_id': await HelperManager.deviceId,
      'username': username,
      'password': password,
    };
    return sendPostRequest(path, data: data, hasToken: false);
  }

  Future<IOResponse> getAccess({required String refresh}) async {
    const path = '/api/token/refresh/';
    final data = {'refresh': refresh};
    return sendPostRequest(path, data: data, hasToken: false);
  }

  Future<IOResponse> getUserInfo() {
    const path = '/api/polaris/customer/retail/info/';
    return sendPostRequest(path);
  }

  Future<IOResponse> sendOtp({
    required String phone,
    required String type,
  }) async {
    const url = '/api/otp/send';
    final data = {'phone_number': phone, 'type': type};
    return sendPostRequest(url, data: data, hasToken: false);
  }

  Future<IOResponse> checkOtp({
    required String phoneNumber,
    required String otp,
    required String token,
  }) async {
    const url = '/api/otp/check';
    final data = {'phone_number': phoneNumber, 'otp': otp, 'otp_token': token};
    return sendPostRequest(url, data: data, hasToken: false);
  }

  Future<IOResponse> changePassword({
    required String old,
    required String newPass,
  }) async {
    const url = '/api/user/password/update/';
    final data = {'new_password': newPass, 'current_password': old};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> changePhone({
    required String phone,
    required String token,
  }) async {
    const url = '/api/user/change/phonenumber/';
    final data = {'phone_number': phone, 'opt_token': token};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> changeBank({
    required int bankId,
    required String account,
  }) {
    const url = '/api/user/bankaccount/';
    final data = {'bank_id': bankId, 'account_number': account};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> changeEmail({required String email}) {
    const url = '/api/user/email/update';
    final data = {'email': email};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> changePin({
    required String pin,
    required String password,
  }) async {
    const url = '/api/user/pin-code/create';
    final data = {'pin_code': pin, 'password': password};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> resetPassword({
    required String phone,
    required String password,
    required String token,
  }) async {
    const url = '/api/user/password/reset/';
    final data = {
      'phone_number': phone,
      'password': password,
      'otp_token': token,
    };
    return sendPostRequest(url, data: data, hasToken: false);
  }

  Future<IOResponse> registerDevice() async {
    const url = '/api/register/devices';
    final data = {
      'name': await HelperManager.deviceModel,
      'registration_id': HelperManager.fcmToken,
      'device_id': 'string',
      'active': true,
      'type': HelperManager.os,
    };

    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> register({required Map<String, dynamic> data}) async {
    const url = '/api/user/register/';

    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> delete({required String password}) async {
    const url = '/api/user/delete/';
    final data = {'password': password};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getNotifications({
    required int offset,
    required int limit,
    required String type,
  }) async {
    const url = '/api/user/notification';
    final query = {'offset': offset, 'limit': limit, 'type': type};
    return sendGetRequest(url, query: query);
  }

  Future<IOResponse> getNotificationCount() async {
    const url = '/api/user/notifications/count';
    return sendGetRequest(url);
  }

  Future<IOResponse> readNotification({required int id}) async {
    const url = '/api/user/notification/read';
    final data = {'id': id};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getUserRelated() {
    const path = '/api/user/related/';
    return sendGetRequest(path);
  }

  Future<IOResponse> addRelate({
    required String name,
    required String phone,
    required String relation,
  }) {
    const url = '/api/user/related/';
    final data = {'name': name, 'phone': phone, 'relation': relation};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> changeRelate({
    int? id,
    required String name,
    required String phone,
    required String relation,
  }) {
    const url = '/api/user/related/';
    final data = {"id": id, 'name': name, 'phone': phone, 'relation': relation};
    return sendPutRequest(url, data: data);
  }
}
