import 'package:bichil/library/library.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationManager {
  static final shared = LocationManager();

  bool serviceEnabled = false;
  LocationPermission permission = LocationPermission.denied;

  bool get locatoinEnabled =>
      permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always;

  Stream<Position> get positionStream => Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      );

  Future checkPermissionStatus() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await const IOAlert(
        type: IOAlertType.error,
        bodyText: 'Таны төхөөрөмж байршил тогтоох боломжгүй байна',
        acceptText: 'Ойлголоо',
      ).show();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await const IOAlert(
          type: IOAlertType.error,
          bodyText: 'Та байршил авах тохиргоог зөвшөөрнө үү',
          acceptText: 'Ойлголоо',
        ).show();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await const IOAlert(
        type: IOAlertType.error,
        bodyText: 'Та байршил авах тохиргоог зөвшөөрнө үү',
        acceptText: 'Ойлголоо',
      ).show();
    }
  }

  double getRangeInKm({required LatLng from, required LatLng to}) {
    return Geolocator.distanceBetween(
          from.latitude,
          from.longitude,
          to.latitude,
          to.longitude,
        ) /
        1000;
  }
}
