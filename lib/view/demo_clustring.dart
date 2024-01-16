import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  List<Place> places = [
    Place(latLng: LatLng(37.7749, -122.4194), category: "liveNow"),
    Place(latLng: LatLng(37.7745, -122.4184), category: "liveNow"),
    Place(latLng: LatLng(37.7757, -122.4168), category: "liveNow"),
    Place(latLng: LatLng(37.7761, -122.4160), category: "liveNow"),
    Place(latLng: LatLng(37.7740, -122.4152), category: "liveNow"),
    Place(latLng: LatLng(37.7736, -122.4144), category: "liveNow"),
    Place(latLng: LatLng(37.7731, -122.4136), category: "liveNow"),
    Place(latLng: LatLng(29.4863979, -98.4177688), category: "PreNow"),
    Place(latLng: LatLng(29.5244773, -98.4125834), category: "PreNow"),
    Place(latLng: LatLng(37.7727, -122.4128), category: "PreNow"),
    Place(latLng: LatLng(37.7723, -122.4120), category: "PreNow"),
    Place(latLng: LatLng(37.7719, -122.4112), category: "PreNow"),
    Place(latLng: LatLng(37.7715, -122.4104), category: "PreNow"),
    Place(latLng: LatLng(37.7711, -122.4096), category: "PreNow"),
    Place(latLng: LatLng(37.7707, -122.4088), category: "PreNow"),
    // Add more places with different categories
  ];
  late ClusterManager _manager;
  Set<Marker> markers = Set();
  Map<String, Color> categoryColors = {
    "liveNow": Colors.green,
    "PreNow": Colors.red,
    // Define colors for other categories
  };
  ClusterManager? _initClusterManager() {
    return ClusterManager<Place>(places, _updateMarkers,
        markerBuilder: _createMarkers1);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  @override
  void initState() {
    _manager = _initClusterManager()!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category-wise Clustering')),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onCameraMove: _handleCameraMove,
        initialCameraPosition:
            CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 10),
        markers: markers,
        onCameraIdle: _manager.updateMap,
      ),
    );
  }

  // Set<Future<Marker>> _createMarkers() {
  //   return places.map((place) async {
  //     return Marker(
  //       markerId: MarkerId(place.latLng.toString()),
  //       position: place.latLng,
  //       icon: await _getMarkerBitmap(
  //           place.isMultiple ? 125 : 75, place.category,
  //           text: cluster.isMultiple ? cluster.count.toString() : null),
  //     );
  //   }).toSet();
  // }
  Future<Marker> Function(Cluster<Place>) get _createMarkers1 =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---->>> $cluster');

            cluster.items.forEach((p) {
              print('cluster items-->${p.latLng}');
            });
          },
          icon: await _getMarkerBitmap(
            cluster.isMultiple ? 125 : 75,
            places.map((e) => e.category) as String,
            text: cluster.isMultiple ? cluster.count.toString() : null,
          ),
        );
      };
  // BitmapDescriptor _createMarkerIcon(String category) {
  //   Color markerColor = categoryColors[category] ?? Colors.blue;
  //   return BitmapDescriptor.defaultMarkerWithHue(_getColorHue(markerColor));
  // }

  Future<BitmapDescriptor> _getMarkerBitmap(int size, String category,
      {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()
      ..color = categoryColors[category] ?? Colors.blue;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  double _getColorHue(Color color) {
    return ((color.red / 255) * 360);
  }

  void _handleCameraMove(CameraPosition position) {
    double zoomLevel = position.zoom;
    if (zoomLevel <= 10) {
      // Set clustering behavior and marker colors based on zoom levels
      // Handle category-wise data and colors here
    } else {
      // Set custom clustering behavior with different colors
      // Handle category-wise data and colors here
    }
  }
}

class Place with ClusterItem {
  final LatLng latLng;
  final String category;

  Place({required this.latLng, required this.category});
  @override
  LatLng get location => latLng;
}
