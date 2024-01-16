import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late ClusterManager _manager;
  // late ClusterManager<Place> _clusterManager;
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = Set();

  final CameraPosition _parisCameraPosition =
      const CameraPosition(target: LatLng(48.856613, 2.352222), zoom: 12.0);
  List<Place> items = [
    Place(latLng: LatLng(21.1702, 72.8311), category: "liveNow"),
    Place(latLng: LatLng(21.7051, 72.9959), category: "PreNow"),
    Place(latLng: LatLng(23.0225, 72.5714), category: "liveNow"),
    Place(latLng: LatLng(22.5726, 88.3639), category: "PreNow"),
    Place(latLng: LatLng(19.0760, 72.8777), category: "liveNow"),
    Place(latLng: LatLng(10.1632, 76.6413), category: "PreNow"),
    Place(latLng: LatLng(37.7749, -122.4194), category: "liveNow"),
    Place(latLng: LatLng(37.7745, -122.4184), category: "PreNow"),
    Place(latLng: LatLng(37.7750, -122.4180), category: "liveNow"),
    Place(latLng: LatLng(37.7747, -122.4196), category: "PreNow"),
    Place(latLng: LatLng(37.7751, -122.4192), category: "liveNow"),
    Place(latLng: LatLng(37.7748, -122.4188), category: "PreNow"),
    Place(latLng: LatLng(40.7128, -74.0060), category: "liveNow"),
    Place(latLng: LatLng(34.0522, -118.2437), category: "PreNow"),
    Place(latLng: LatLng(41.8781, -87.6298), category: "liveNow"),
    Place(latLng: LatLng(29.7604, -95.3698), category: "PreNow"),
    Place(latLng: LatLng(51.5074, -0.1278), category: "liveNow"),
    Place(latLng: LatLng(35.6895, 139.6917), category: "PreNow"),
    Place(latLng: LatLng(52.5200, 13.4050), category: "liveNow"),
    Place(latLng: LatLng(48.8566, 2.3522), category: "PreNow"),
    Place(latLng: LatLng(19.4326, -99.1332), category: "liveNow"),
    Place(latLng: LatLng(-33.8688, 151.2093), category: "PreNow"),
    Place(latLng: LatLng(-23.5505, -46.6333), category: "liveNow"),
    Place(latLng: LatLng(-22.9068, -43.1729), category: "PreNow"),
    Place(latLng: LatLng(55.7558, 37.6173), category: "liveNow"),
    Place(latLng: LatLng(59.3293, 18.0686), category: "PreNow"),
    Place(latLng: LatLng(35.6894, 139.6922), category: "liveNow"),

    // Add more places with different categories
  ];

  Map<String, Color> categoryColors = {
    "liveNow": Colors.yellow,
    "PreNow": Colors.green,
    // Define colors for other categories
  };

  // final Map<String, List<Place>> items = {
  //   "liveNow": [
  //     Place(latLng: LatLng(37.7749, -122.4194)),
  //     Place(latLng: LatLng(37.7745, -122.4184)),
  //   ],
  //   "PreNow": [
  //     Place(latLng: LatLng(29.5017961, -98.4211198)),
  //     Place(latLng: LatLng(29.4863979, -98.4177688)),
  //     Place(latLng: LatLng(29.4816842, -98.4172595)),
  //     Place(latLng: LatLng(29.5244773, -98.4125834)),
  //   ],
  // };

  // List<Place> items = [
  //   Place(
  //       latLng: const LatLng(
  //           37.7749, -122.4194)), // Replace with actual restaurant locations
  //   Place(latLng: const LatLng(37.7745, -122.4184)),
  //   Place(latLng: const LatLng(66.160507, -153.369141)),
  //   Place(latLng: LatLng(29.501796110000043, -98.42111988)),
  //   Place(latLng: LatLng(29.486397887000063, -98.41776879999996)),
  //   Place(latLng: const LatLng(29.48168424800008, -98.41725954999998)),
  //   Place(
  //       latLng: const LatLng(29.524477369000067,
  //           -98.41258342199997)), // Replace with actual restaurant locations
  // ];
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    _manager = _initClusterManager()!;
    _cameraPosition =
        const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 5);
    // for (var categoryPlaces in items.values) {
    //   _clusterManager.setItems(categoryPlaces);
    // }
    super.initState();
  }

  ClusterManager? _initClusterManager() {
    return ClusterManager<Place>(
        items,
        // [...items['liveNow'] ?? [], ...items['PreNow'] ?? []],
        _updateMarkers,
        markerBuilder: _markerBuilder);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  GoogleMapController? _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomGesturesEnabled: true,
        mapToolbarEnabled: true,
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        initialCameraPosition: _cameraPosition!,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        trafficEnabled: false,
        buildingsEnabled: false,
        rotateGesturesEnabled: true,
        markers: markers,

        ///markers,
        minMaxZoomPreference: const MinMaxZoomPreference(1, 10),
        onTap: (_) {
          // if (_bsController != null) _bsController!.close();
        },
        onMapCreated: (GoogleMapController controller) async {
          _googleMapController = controller;
          // _setMapStyle();
          double temp = await controller.getZoomLevel();
          print('Zoom Level $temp');
          _controller.complete(controller);
          _manager.setMapId(controller.mapId);
        },
        onCameraMove: _manager.onCameraMove,
        onCameraIdle: _manager.updateMap,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _manager.setItems(<Place>[
      //       for (int i = 0; i < 30; i++)
      //         Place(
      //             name: 'New Place ${DateTime.now()} $i',
      //             latLng: LatLng(48.858265 + i * 0.01, 2.350107))
      //     ]);
      //   },
      //   child: const Icon(Icons.update),
      // ),
    );
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        var category;
        cluster.items.forEach((element) {
          category = element.category;
        });
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---->>> $cluster');

            cluster.items.forEach((p) {
              print('cluster items-->${p.latLng}');
            });
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null,
              colors: categoryColors[category]),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size,
      {String? text, Color? colors}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = colors!;
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
}

class Place with ClusterItem {
  final String? name;
  final LatLng latLng;
  final String category;

  Place({this.name, required this.latLng, required this.category});

  @override
  LatLng get location => latLng;
}
