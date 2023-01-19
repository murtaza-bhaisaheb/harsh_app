import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:harsh_app/services/db_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DbServices db = DbServices();

  @override
  void initState() {
    db.getMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DbServices dbServices = DbServices();
    const CameraPosition kGoogle = CameraPosition(
      target: LatLng(22.55543, 72.9230435),
      zoom: 30,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: dbServices.getMarkers(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return GoogleMap(
                initialCameraPosition: kGoogle,
                markers: snapshot.data!.toSet(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   setState(() {});
        // }),
      ),
    );
  }
}