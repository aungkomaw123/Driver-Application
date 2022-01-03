import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/location_provider.dart';
import 'package:flutter_application_1/widgets/profile.dart';
import 'package:flutter_application_1/widgets/user_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final List<Marker> _markers = [];

  intilize(double lat, double log) {
    Marker driverMarker = Marker(
      markerId: const MarkerId('id-1'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: const LatLng(16.772720098599095, 96.16173858249817),
      infoWindow: const InfoWindow(title: "Driver Location"),
    );

    Marker customerMarker = Marker(
        markerId: const MarkerId("id-2"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: LatLng(lat, log),
        infoWindow: const InfoWindow(title: "Customer Location"));

    _markers.add(driverMarker);
    _markers.add(customerMarker);
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider _locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    return Consumer<LocationProvider>(
        builder: (context, LocationProvider loc, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            intilize(_locationProvider.lat, _locationProvider.log);
            setState(() {});
          },
          child: const Icon(Icons.location_searching),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: Container(
            color: const Color.fromRGBO(4, 41, 58, 1),
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://scontent-hkg4-2.xx.fbcdn.net/v/t1.6435-9/146634239_137405848224789_4056590553719195166_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=vD9djh-I_ugAX_7Cmss&_nc_ht=scontent-hkg4-2.xx&oh=00_AT8gsvlZYmfEsU8XBhOh9ApCM_nml6kPK6mjHeysZMm_Uw&oe=61F04802"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40, top: 40),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        right: 10,
                                        left: 10,
                                        bottom: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    primary: Colors.white,
                                    minimumSize: const Size(120, 40)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return UseerList();
                                  }));
                                },
                                child: const Text(
                                  'Customer list',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(4, 28, 50, 1)),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40, top: 40),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 10, left: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Colors.white,
                                  minimumSize: const Size(120, 40)),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }));
                              },
                              child: const Text(
                                'Profile',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(4, 28, 50, 1)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: GoogleMap(
          markers: _markers.map((e) => e).toSet(),
          initialCameraPosition: CameraPosition(
            target: LatLng(16.772720098599095, 96.16173858249817),
            zoom: 15,
          ),
        ),
      );
    });
  }
}
