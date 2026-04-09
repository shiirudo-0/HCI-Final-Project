import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'home.dart';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final MapController _mapController = MapController();
  List<LatLng> _route = [];

  double _distance = 0.0;
  int _seconds = 0;

  Timer? _timer;
  StreamSubscription<Position>? _positionStream;

  bool isTracking = false;
  bool isPaused = false;
  bool isFinished = false;
  bool followUser = true;

  LatLng _currentPosition = LatLng(14.5995, 120.9842);
  final Distance distanceCalculator = Distance();

  // ================= TIMER =================
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void stopTimer() => _timer?.cancel();

  String get formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds min";
  }

  // ================= TRACKING =================
  Future<void> startTracking() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) return;

    setState(() {
      isTracking = true;
      isPaused = false;
      isFinished = false;
      _route.clear();
      _distance = 0;
      _seconds = 0;
    });

    startTimer();

    _positionStream =
        Geolocator.getPositionStream().listen((Position position) {
      LatLng newPoint = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentPosition = newPoint;
        _route.add(newPoint);

        if (_route.length > 1) {
          _distance += distanceCalculator(
            _route[_route.length - 2],
            newPoint,
          );
        }
      });

      if (followUser) {
        _mapController.move(newPoint, 17);
      }
    });
  }

  void pauseTracking() {
    stopTimer();
    _positionStream?.pause();
    setState(() => isPaused = true);
  }

  void resumeTracking() {
    startTimer();
    _positionStream?.resume();
    setState(() => isPaused = false);
  }

  void endTracking() {
    stopTimer();
    _positionStream?.cancel();
    setState(() {
      isTracking = false;
      isPaused = false;
      isFinished = true;
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (isTracking) {
              stopTimer();
              _positionStream?.cancel();
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          // MAP
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 16,
              onPositionChanged: (pos, hasGesture) {
                if (hasGesture) followUser = false;
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 40,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _route,
                    strokeWidth: 5,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black,
                  ),
                ],
              ),
            ],
          ),

          // FOLLOW BUTTON
          Positioned(
            top: 50,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: followUser ? Colors.green : Colors.grey,
              onPressed: () {
                setState(() {
                  followUser = true;
                  _mapController.move(_currentPosition, 17);
                });
              },
              child: Icon(Icons.my_location),
            ),
          ),

          // BOTTOM CARD
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12, offset: Offset(0, -2))],
              ),
              child: isTracking
                  ? trackingUI()
                  : isFinished
                      ? finishedUI()
                      : startUI(),
            ),
          ),
        ],
      ),
    );
  }

  // ================= START UI =================
  Widget startUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Distance Goal", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
        SizedBox(height: 10),
        TextField(
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          decoration: InputDecoration(
            hintText: "Enter your distance (e.g 2.5 km)",
            hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(onPressed: startTracking, child: Text("Start Tracking"))
      ],
    );
  }

  // ================= TRACKING UI =================
  Widget trackingUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Current Track:", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                SizedBox(height: 10),
                Text("${(_distance / 1000).toStringAsFixed(2)} km", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                Text(formattedTime, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
              ],
            ),
            Image.asset('gymchad.png', height: 60),
          ],
        ),
        SizedBox(height: 15),
        Text("Progress", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: _distance / 5000, // Progress towards 5 km goal
          minHeight: 8,
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(Colors.green),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Start: 0 km", style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color)),
            Text("Current: ${(_distance / 1000).toStringAsFixed(2)} km", style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color)),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: isPaused ? resumeTracking : pauseTracking,
              child: Text(isPaused ? "Resume" : "Pause"),
            ),
            ElevatedButton(onPressed: endTracking, child: Text("End")),
          ],
        ),
      ],
    );
  }

  // ================= FINISHED UI =================
  Widget finishedUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Current Track:", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
        SizedBox(height: 10),
        Text("${(_distance / 1000).toStringAsFixed(1)} km", style: TextStyle(fontSize: 24, color: Theme.of(context).textTheme.displayLarge?.color)),
        Text(formattedTime, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
        SizedBox(height: 15),
        Text("Final Progress", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: (_distance / 5000).clamp(0.0, 1.0), // Progress towards 5 km goal
          minHeight: 8,
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(Colors.green),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Start: 0 km", style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color)),
            Text("End: ${(_distance / 1000).toStringAsFixed(2)} km", style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color)),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isFinished = false;
                  _route.clear();
                  _distance = 0;
                  _seconds = 0;
                });
              },
              child: Text("Track Again"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              child: Text("Done"),
            ),
          ],
        ),
      ],
    );
  }
}