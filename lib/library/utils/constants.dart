const environment = Environment.prod;
String get domain => environment.domain;

// const domain = 'https://api.bichilglobus.mn';

/* Store constants */
const kStoreUser = 'kStoreUser';
const kStoreDevice = 'kStoreDevice';
const kUser = 'kUser';
const kToken = 'kToken';
const kFcmToken = 'kFcmToken';
const kWalkthroughShowed = 'kWalkthroughShowed';
const kBiometricWithLogin = 'kBiometricWithLogin';
const kBiometricWithUser = 'kBiometricWithUser';
const kNotificationCount = 'kNotificationCount';

enum Environment {
  test(domain: 'http://192.168.88.88:8000'),
  staging(domain: 'https://testapi.bichilglobus.mn'),
  prod(domain: 'http://192.168.88.88:8000');

  const Environment({required this.domain});
  final String domain;
}
