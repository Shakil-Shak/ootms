import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


class SocketServices {
  static late io.Socket socket;
  bool show = false;

  ///<<<============ Connect with socket ====================>>>
  static void connectToSocket() {
    socket = io.io(
        ApiPaths.socketUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            // .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    socket.onConnect((data) {
      debugPrint("=============================> Connection $data");
    });
    socket.onConnectError((data) {
        debugPrint("============================>Connection Error $data");
    });


    socket.connect();
  }
}