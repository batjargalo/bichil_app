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
<<<<<<< HEAD
  test(domain: 'http://localhost:8000'),
  staging(domain: 'https://testapi.bichilglobus.mn'),
  prod(domain: 'http://api.bichilglobus.mn:8000');
=======
  test(domain: 'http://192.168.88.87:8000'),
  staging(domain: 'https://testapi.bichilglobus.mn'),
  prod(domain: 'http://192.168.88.87:8000');
>>>>>>> 59d12f12bb3f2229c31b773cea92cd9a0b0d97f7

  const Environment({required this.domain});
  final String domain;
}
