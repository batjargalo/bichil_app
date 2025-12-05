import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchMapScreen extends GetView<BranchMapController> {
  const BranchMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: controller.isLoading.value
              ? const IOLoading()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: controller.defaultLocation,
                        zoom: 14,
                      ),
                      mapType: MapType.normal,
                      markers: controller.markers.toSet(),
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController mapController) {
                        if (!controller.mapController.isCompleted) {
                          controller.mapController.complete(mapController);
                        }
                      },
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: controller.userLocation.value == null
            ? null
            : IOBottomNavigationBar(
                backgroundColor: IOColors.backgroundPrimary,
                child: IOButtonWidget(
                  model: controller.nearButton,
                  onPressed: controller.onShowNear,
                ),
              ),
      ),
    );
  }
}
