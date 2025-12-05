import 'dart:async';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class BranchMapController extends IOController {
  final mapController = Completer<GoogleMapController>();
  final defaultLocation = const LatLng(47.91855296258276, 106.91778241997314);
  final markers = <Marker>[].obs;
  final userLocation = Rx<LatLng?>(null);
  late BitmapDescriptor markerIcon;
  StreamSubscription<Position>? locationStream;

  final nearButton = IOButtonModel(
    label: 'Өөрт ойр салбар харах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  );

  @override
  void onInit() {
    super.onInit();
    initializeMarker();
    checkLocation();
  }

  @override
  void onClose() {
    locationStream?.cancel();
    super.onClose();
  }

  Future checkLocation() async {
    await LocationManager.shared.checkPermissionStatus();

    if (LocationManager.shared.locatoinEnabled) {
      locationStream = LocationManager.shared.positionStream.listen(
        _locationChange,
      );
    }
  }

  Future initializeMarker() async {
    markerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(45, 55)),
      'assets/images/marker.png',
    );
    getBranches();
  }

  Future getBranches() async {
    isLoading.value = true;
    final response = await InfoApi().getBranches();
    isLoading.value = false;
    if (response.isSuccess) {
      final branches =
          response.data.listValue.map((e) => BranchModel.fromJson(e)).toList();
      markers.value = branches
          .map((e) => Marker(
                markerId: MarkerId(e.id.toString()),
                position: LatLng(e.latitude, e.longitude),
                icon: markerIcon,
                onTap: () => showInfo(e),
              ))
          .toList();
    }
  }

  Future updateGoogleCameraToFit() async {
    final locUser = userLocation.value;
    final locBranch = markers.first.position;
    if (locUser == null) return;
    double southWestLat = locUser.latitude;
    double southWestLon = locUser.longitude;
    double northEastLat = locUser.latitude;
    double northEastLon = locUser.longitude;

    if (southWestLat > locBranch.latitude) {
      southWestLat = locBranch.latitude;
    }
    if (southWestLon > locBranch.longitude) {
      southWestLon = locBranch.longitude;
    }
    if (northEastLat < locBranch.latitude) {
      northEastLat = locBranch.latitude;
    }
    if (northEastLon < locBranch.longitude) {
      northEastLon = locBranch.longitude;
    }

    final ctrlr = await mapController.future;

    ctrlr.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(southWestLat, southWestLon),
          northeast: LatLng(northEastLat, northEastLon),
        ),
        50,
      ),
    );
  }

  void _locationChange(Position position) {
    userLocation.value = LatLng(
      position.latitude,
      position.longitude,
    );
  }

  void onShowNear() {
    final loc = userLocation.value;
    if (loc == null) return;
    markers.sort((a, b) {
      final aRange = LocationManager.shared.getRangeInKm(
        from: loc,
        to: a.position,
      );
      final bRange = LocationManager.shared.getRangeInKm(
        from: loc,
        to: b.position,
      );
      return aRange.compareTo(bRange);
    });
    updateGoogleCameraToFit();
  }

  void showInfo(BranchModel branch) {
    BranchMapInfoWidget(branch: branch).show();
  }
}
