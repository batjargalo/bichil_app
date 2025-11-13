import 'package:bichil/library/library.dart';
import 'package:dio/dio.dart';
import 'package:g_json/g_json.dart';

enum DioType { auth, offline }

class DioManager {
  static final DioManager _singleton = DioManager._internal();

  factory DioManager() {
    return _singleton;
  }

  final _connectTimeout = const Duration(seconds: 60);
  final _receiveTimeout = const Duration(seconds: 60);
  final _headers = {Headers.acceptHeader: Headers.jsonContentType, Headers.contentTypeHeader: Headers.jsonContentType};

  BaseOptions get option =>
      BaseOptions(baseUrl: domain, connectTimeout: _connectTimeout, receiveTimeout: _receiveTimeout, headers: _headers);

  late Dio mainDio;
  late Dio customDio;

  DioManager._internal() {
    mainDio = Dio(option);
    // mainDio.transformer = CustomTransformer();
    customDio = Dio(option);
    // customDio.transformer = CustomTransformer();
    addMainInterceptor();
  }

  addMainInterceptor() async {
    mainDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (HelperManager.isLogged) {
            options.headers['Authorization'] = 'Bearer ${HelperManager.token.access}';
            handler.next(options);
          } else {
            handler.next(options);
          }
        },
        onResponse: (response, handler) async {
          final data = JSON(response.data);
          final status = data['status'].stringValue;
          if (status == 'unauthorized') {
            final res = await UserApi().getAccess(refresh: HelperManager.token.refresh);

            if (res.data.exist('access')) {
              final token = HelperManager.token;
              token.access = res.data['access'].stringValue;
              await UserStoreManager.shared.write(kToken, token.toMap());

              try {
                RequestOptions requestOptions = response.requestOptions;
                handler.resolve(
                  await mainDio.request(
                    requestOptions.path,
                    options: Options(method: requestOptions.method),
                    data: requestOptions.data,
                    queryParameters: requestOptions.queryParameters,
                  ),
                );
              } on DioException catch (_) {
                SessionManager.shared.logout();
              }
            } else {
              SessionManager.shared.logout();
            }
          } else {
            handler.next(response);
          }
        },
      ),
    );
  }
}

class CustomTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    options.path = Uri.decodeFull(options.path);
    return super.transformRequest(options);
  }
}
