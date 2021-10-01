import 'package:geolocator/geolocator.dart';
class location{
  double longitude;
  double latitude;

  Future<void> getcurrnetlocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  latitude=position.latitude;
  longitude=position.longitude;
  }

}