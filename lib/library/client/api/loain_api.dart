import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';

class LoanApi extends IOClient {
  Future<IOResponse> sendCarRequest({
    required String registerType,
    required String loanType,
    required String carNo,
  }) async {
    const url = '/api/product/request/loan/car';
    final data = {
      'requested_amount': 0,
      'car_register_type': registerType,
      'car_loan_type': loanType,
      'car_register_number': carNo,
    };
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> sendPhoneRequest({
    required int amount,
    required String phone,
  }) async {
    const url = '/api/product/request/loan/number';
    final data = {'requested_amount': amount, 'phone_number': phone};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> sendPropertyRequest({
    required Map<String, dynamic> data,
  }) async {
    const url = '/api/product/request/loan/property';
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> recreate({required LoanRecreateModel model}) async {
    const url = '/api/core/loan/loan-on-loan/';
    return sendPostRequest(url, data: model.toMapFromLoan());
  }

  Future<IOResponse> createFromSaving({
    required LoanRecreateModel model,
  }) async {
    const url = '/api/core/loan/loan-on-saving/';
    return sendPostRequest(url, data: model.toMapFromSaving());
  }

  Future<IOResponse> getLoanOpenList() async {
    const url = '/api/polaris/customer/loan/open/';
    final data = {'pageNumber': 0, 'pageSize': 100};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getLoanList() async {
    const url = '/api/core/loan/active/';
    return sendGetRequest(url);
  }

  Future<IOResponse> getLoanInfo({required String code}) async {
    const url = '/api/polaris/loan/info/';
    final data = {'acntCode': code, 'getWithSecure': 0};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getPledgeInfo({
    required String code,
    required int sysNo,
  }) async {
    const url = '/api/polaris/pledge/info/';
    final data = {'accountNo': code, 'sysNo': sysNo};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getPledgeList({required String code}) async {
    const url = '/api/polaris/pledge/list/';
    final data = {'acntCode': code};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getLoanSavingRate({required String code}) async {
    const url = '/api/core/loan/loan-saving-rate/';
    final data = {'account_no': code};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getLoanStatement({
    required String code,
    required String startDate,
    required String endDate,
  }) async {
    const url = '/api/polaris/loan/statement/';
    final data = {
      'acntCode': code,
      'startDate': startDate,
      'endDate': endDate,
      'startPagingPosition': 0,
      'pageRowCount': 0,
    };
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getLoanSchedule({required String code}) async {
    const url = '/api/polaris/loan/repayment/';
    final data = {'acntCode': code};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getLoanCloseAmount({required String code}) async {
    const url = '/api/polaris/loan/close-amount/';
    final data = {'acntCode': code};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> payLoan({
    required String code,
    required double amount,
  }) async {
    const url = '/api/core/loan/pay/';
    final data = {'amount': amount, 'account_no': code};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> closeLoan({
    required String code,
    required double amount,
  }) async {
    const url = '/api/core/loan/close/';
    final data = {'amount': amount, 'account_no': code};
    return sendPostRequest(url, data: data);
  }

  Future<IOResponse> getCalculate({required LoanCalculatorModel model}) async {
    const url = '/api/core/loan/calculate/';
    return sendPostRequest(url, data: model.toMap(), hasToken: false);
  }

  Future<IOResponse> getHistory({
    required int offset,
    required int limit,
  }) async {
    const url = '/api/polaris/customer/loan/history/';
    final query = {'page_number': offset, 'page_size': limit};
    return sendPostRequest(url, query: query);
  }

  Future<IOResponse> getLoanLimits() async {
    const url = '/api/core/loanlimit';
    return sendGetRequest(url, hasToken: true);
  }
}
