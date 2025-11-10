import 'dart:io';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';

class InfoApi extends IOClient {
  Future<IOResponse> checkQpayInvoice({required String invoice}) async {
    const url = '/api/core/payment/check';
    final query = {'invoice_number': invoice};
    return sendGetRequest(url, query: query);
  }

  Future<IOResponse> getBanner() async {
    const url = '/api/info/banner/';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> getProducts() async {
    const url = '/api/product/group';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> getSubProducts({required int id}) async {
    final url = '/api/product/$id';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> sendProduct({required LoanCreateModel model}) async {
    const url = '/api/product/request/new';
    return sendPostRequest(url, data: model.toMap());
  }

  Future<IOResponse> getCountry() async {
    const url = '/api/info/city';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> getDistrict({required int id}) async {
    final url = '/api/info/district/$id';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> getSoum({required int id}) async {
    final url = '/api/info/horoo/$id';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> getBanks() async {
    const url = '/api/info/banks';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> checkBank({
    required int bankId,
    required String account,
  }) async {
    const url = '/api/info/account/name';
    final data = {'bank_id': bankId, 'account_no': account};
    return sendPostRequest(url, data: data, hasToken: false);
  }

  Future<IOResponse> getBranches({int? countryId, int? cityId}) async {
    const url = '/api/info/branchs';
    final query = {
      if (countryId != null) 'city': countryId,
      if (cityId != null) 'district': cityId,
    };
    return sendGetRequest(url, query: query, hasToken: false);
  }

  Future<IOResponse> getContact() async {
    const url = '/api/info/contact';
    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> getFaq() async {
    const url = '/api/info/faq';

    return sendGetRequest(url, hasToken: false);
  }

  Future<IOResponse> getNews({required int offset, required int limit}) async {
    const url = '/api/info/news';
    final query = {'offset': offset, 'limit': limit};
    return sendGetRequest(url, query: query, hasToken: false);
  }

  Future<IOResponse> getAdvice({
    required int offset,
    required int limit,
  }) async {
    const url = '/api/info/advice';
    final query = {'offset': offset, 'limit': limit};
    return sendGetRequest(url, query: query, hasToken: false);
  }

  Future<IOResponse> getVideos({
    required int offset,
    required int limit,
  }) async {
    const url = '/api/info/videos';
    final query = {'offset': offset, 'limit': limit};
    return sendGetRequest(url, query: query, hasToken: false);
  }

  Future<IOResponse> getNewsInfo({required int id}) async {
    final path = '/api/info/news/$id';
    return sendGetRequest(path, hasToken: false);
  }

  Future<IOResponse> getFields() async {
    const path = '/api/user/test/';
    final query = {'register': 'ЗЮ95052614'};
    return sendGetRequest(path, query: query, hasToken: false);
  }

  Future<IOResponse> getAppVersion() async {
    const path = '/api/info/app-version';
    final data = {
      'platform': Platform.isIOS ? 'ios' : 'android',
      'version': await HelperManager.buildVersion,
    };
    return sendPostRequest(path, data: data, hasToken: false);
  }
}
