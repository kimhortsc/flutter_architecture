// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'notifier/user.dart';
//
// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const User(),
//     );
//   }
// }
//
// class User extends ConsumerStatefulWidget {
//   const User({super.key});
//
//   @override
//   ConsumerState createState() => _UserState();
// }
//
// class _UserState extends ConsumerState<User> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     final asyncUser = ref.watch(asyncUserProvider);
//
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           Container(
//             color: Colors.amber,
//           ),
//
//           Center(
//             child: asyncUser.when(
//                 data: (result) {
//
//                   if(result.data == null){
//                     return Center(
//                       child: Text("${result.message}.........................."),
//                     );
//                   }
//
//                   return ListView.builder(
//                     itemCount: result.data!.length,
//                     itemBuilder: (BuildContext context, int index){
//                       return ListTile(
//                         leading: Text(result.data![index].id.toString()),
//                         trailing: Text(result.data![index].email),
//                         title: Text(result.data![index].firstName),
//                       );
//                     },
//                   );
//                 },
//                 error: (err, stack) => Text("${err.runtimeType}"),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//           )
//           )
//         ],
//       ),
//     );
//   }
// }

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

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
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    //initConnectivity();

    //_connectivitySubscription

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    //_connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    print("nnnnnnnnnnnnnnnnnnnnnnn");

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {

    print("ffffffffffffffffffffffffffff");

    setState(() {
      _connectionStatus = result;
    });
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

// import 'dart:async';
// import 'dart:io';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class ConnectionCheckerDemo extends StatefulWidget {
//   const ConnectionCheckerDemo({Key? key}) : super(key: key);
//
//   @override
//   State<ConnectionCheckerDemo> createState() => _ConnectionCheckerDemoState();
// }
//
// class _ConnectionCheckerDemoState extends State<ConnectionCheckerDemo> {
//   Map _source = {ConnectivityResult.none: false};
//   final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
//   String string = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _networkConnectivity.initialise();
//     _networkConnectivity.myStream.listen((source) {
//       _source = source;
//       print('source $_source');
//       // 1.
//       switch (_source.keys.toList()[0]) {
//         case ConnectivityResult.mobile:
//           string =
//               _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
//           break;
//         case ConnectivityResult.wifi:
//           string =
//               _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
//           break;
//         case ConnectivityResult.none:
//         default:
//           string = 'Offline';
//       }
//       // 2.
//       setState(() {});
//       // 3.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             string,
//             style: TextStyle(fontSize: 30),
//           ),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color(0xff6ae792),
//       ),
//       body: Center(
//           child: Text(
//         string,
//         style: TextStyle(fontSize: 54),
//       )),
//     );
//   }
//
//   @override
//   void dispose() {
//     _networkConnectivity.disposeStream();
//     super.dispose();
//   }
// }
//
// class NetworkConnectivity {
//   NetworkConnectivity._();
//
//   static final _instance = NetworkConnectivity._();
//
//   static NetworkConnectivity get instance => _instance;
//   final _networkConnectivity = Connectivity();
//   final _controller = StreamController.broadcast();
//
//   Stream get myStream => _controller.stream;
//
//   void initialise() async {
//     ConnectivityResult result = await _networkConnectivity.checkConnectivity();
//     _checkStatus(result);
//     _networkConnectivity.onConnectivityChanged.listen((result) {
//       print(result);
//       _checkStatus(result);
//     });
//   }
//
//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     _controller.sink.add({result: isOnline});
//
//
//   }
//
//   void disposeStream() => _controller.close();
// }
