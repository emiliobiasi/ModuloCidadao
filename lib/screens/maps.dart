import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo_cidadao/screens/seleciona_ticket.dart';




class maps extends StatefulWidget {
  const maps({Key? key}) : super(key: key);

  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  Future<List> getFruit() async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('ZonaAzulCidadao');
    final results = await callable();
    List fruit = results.data;
    return fruit;
  }

  static const  vetorDeCoordenadas = [LatLng(-22.85664450504122, -47.21118569636944), // R. João Ribeiro Evangelista
    LatLng(-22.856633991780658, -47.212044188759094), // R. Ana Profetisma da Silva
    LatLng(-22.85401015976297, -47.21211199746042), // R. João Barreto da Silva 2
    LatLng(-22.853963842555615, -47.21130473289067), // R. João Barreto da Silva 3
    LatLng(-22.8539778839156, -47.21000176557807), // R. João Barreto da Silva 1
    LatLng(-22.856603323914793, -47.20996374212226), // Vila Real Santista
    LatLng(-22.856614612579484, -47.210602491034074),  // R. Waldemar Simões
    LatLng(-22.856629763293768, -47.210885574572046)]; // R. José Martin dos Anjos




  static final CameraPosition _hortolandia = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-22.85250050972797, -47.21071312998611),
      tilt: 59.440717697143555,
      zoom: 18.151926040649414);


  static final Polyline _Polyline = Polyline(
      polylineId: PolylineId('_Polyline'),
      points: vetorDeCoordenadas,
      width: 1
  );


  static final Polygon _Polygon = Polygon(
      polygonId: PolygonId('_Polygon'),
      points: vetorDeCoordenadas,
      strokeWidth: 5,
      fillColor: Colors.lightBlueAccent.withOpacity(0.3)

  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.lightBlueAccent[700],
        ),
        body: Stack(
            children:[
              GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  polylines: {
                    _Polyline
                  },
                  polygons: {
                    _Polygon
                  },
                  initialCameraPosition: _hortolandia
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => seleciona_ticket()),
                  );
                },
                child: Text('Comprar Ticket'),
              )
            ]
        ),
      ),
    );
  }
}