import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  requestPermission() async {
    final permission = await _location.requestPermission();
    return permission == PermissionStatus.granted ||
        permission == PermissionStatus.grantedLimited;
  }

  getCurrentLocation() async {
    final serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      var request = await _location.requestService();
      if (!request) {
        print('GPS não habilitado');
      }
    }
  }
}
