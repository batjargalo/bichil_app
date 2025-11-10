import 'package:g_json/g_json.dart';

class IOResponse {
  bool get isSuccess => status == 'success';

  String status = '';
  String message = '';
  JSON json = JSON.nil;
  JSON data = JSON.nil;

  IOResponse();

  IOResponse.fromJSON(JSON response) {
    status = response['status'].stringValue;
    message = response['message'].stringValue;
    data = response['data'];
    json = response;
  }

  IOResponse.withError(String text) {
    status = 'fail';
    message = text;
  }

  IOResponse.withErrorJSON(JSON jsn) {
    message = jsn['msg'].stringValue;
  }
}
