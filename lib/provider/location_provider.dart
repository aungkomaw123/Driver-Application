import 'package:flutter/cupertino.dart';

class LocationProvider extends ChangeNotifier {
  late double lat = 16.77922387492406;
  late double log = 96.15425656102494;

  void setLat(lattitude) {
    lat = lattitude;
    notifyListeners();
  }

  void setLog(lognitude) {
    log = lognitude;
    notifyListeners();
  }
}
