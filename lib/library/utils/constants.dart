const environment = Environment.test;
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
  test(domain: 'http://localhost:8000'),
  staging(domain: 'https://testapi.bichilglobus.mn'),
  prod(domain: 'http://api.bichilglobus.mn:8000');

  const Environment({required this.domain});
  final String domain;
}
