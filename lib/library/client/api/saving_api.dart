import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';

class SavingApi extends IOClient {
  Future<IOResponse> getSavingList() async {
    // const path = '/api/polaris/customer/td/open/';
    // final data = {'pageNumber': 0, 'pageSize': 100};
    // return sendPostRequest(path, data: data);
    const path = '/api/core/saving/active/';
    return sendPostRequest(path);
  }

  Future<IOResponse> getSavingInfo({required String code}) async {
    const path = '/api/polaris/td/info/';
    final data = {'acntCode': code, 'getWithSecure': 0};
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getSavingFullInfo({required String code}) async {
    final path = '/api/core/saving/detail/$code';
    return sendGetRequest(path);
  }

  Future<IOResponse> getSavingStatement({
    required String code,
    required String startDate,
    required String endDate,
  }) async {
    const url = '/api/polaris/td/statement/';
    final data = {
      "acntCode": code,
      "startDate": startDate,
      "endDate": endDate,
      "startPagingPosition": 0,
      "pageRowCount": 100,
    };
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getSavingCondition() {
    const path = '/api/core/saving-contract/info';
    return sendGetRequest(path);
  }

  Future<IOResponse> getSavingContract({required SavingCreateModel model}) {
    const path = '/api/core/saving-contract/body';
    final query = {
      'term_len': model.term.value,
      'total_amount': model.firstAmount,
      'frequency': model.frequency.value,
    };
    return sendGetRequest(path, query: query);
  }

  Future<IOResponse> getSavingContractInfo({required String code}) {
    final path = '/api/core/saving/contract/$code/';
    return sendGetRequest(path);
  }

  Future<IOResponse> changeSavingName({
    required int code,
    required String name,
  }) {
    final path = '/api/core/saving/change-name/$code/';
    final data = {'name': name};
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> createSaving({required SavingCreateModel model}) {
    const path = '/api/core/saving/request';
    return sendPostRequest(path, data: model.toMap());
  }

  Future<IOResponse> addAmountSaving({
    required String code,
    required double amount,
  }) {
    const path = '/api/core/saving/deposit/';
    final data = {
      'amount': amount,
      'account_no': code,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getCalculate({
    required Map<String, dynamic> data,
  }) {
    const path = '/api/core/saving/calculate/';

    return sendPostRequest(path, data: data, hasToken: false);
  }

  Future<IOResponse> getCalculateRate({
    required double amount,
    required String purpose,
    required String account,
  }) {
    const path = '/api/core/saving/rate/calculate';
    final data = {
      'amount': amount,
      'purpose': purpose,
      'account_no': account,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getHistory({
    required int offset,
    required int limit,
  }) async {
    const url = '/api/polaris/customer/td/history/';
    final query = {
      'page_number': offset,
      'page_size': limit,
    };
    return sendPostRequest(url, query: query);
  }

  Future<IOResponse> closeSaving({
    required double amount,
    required String code,
    required int bankId,
    required String accountNumber,
    required String accountName,
    required String pin,
  }) async {
    const url = '/api/core/saving/close/';
    final query = {
      'amount': amount,
      'account_no': code,
      'pin_code': pin,
      'bank_id': bankId,
      'recipient_account': accountNumber,
      'recipient_name': accountName,
    };
    return sendPostRequest(url, data: query);
  }

  Future<IOResponse> withdrawSaving({
    required double amount,
    required String code,
    required int bankId,
    required String accountNumber,
    required String accountName,
    required String pin,
  }) async {
    const url = '/api/core/saving/withdraw/';
    final query = {
      'amount': amount,
      'account_no': code,
      'pin_code': pin,
      'bank_id': bankId,
      'recipient_account': accountNumber,
      'recipient_name': accountName,
    };
    return sendPostRequest(url, data: query);
  }
}
