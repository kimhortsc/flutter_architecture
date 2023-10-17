import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  late NetworkConnectivity networkConnectivity;

  @override
  void initState() {
    super.initState();

    networkConnectivity = NetworkConnectivity();
    networkConnectivity.initConnectivity();

    networkConnectivity.connectionStatus((connectionStatus) => setState(() {
      _connectionStatus = connectionStatus;
    }));

  }

  @override
  void dispose() {
    //_connectivitySubscription.cancel();
    super.dispose();
    networkConnectivity.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity example app'),
        elevation: 4,
      ),
      body: Center(
          child: Text('Connection Status: ${_connectionStatus.toString()}')),
    );
  }
}


class NetworkConnectivity{
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  final Connectivity _connectivity = Connectivity()
  ;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void connectionStatus(void Function(ConnectivityResult) callback){

    _connectivitySubscription.onData((data) {
      callback(data);
    });

    // callback(_connectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
  }

  void dispose(){
    _connectivitySubscription.cancel();
  }
}