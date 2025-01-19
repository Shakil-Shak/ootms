import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


class SocketServices {
  static late io.Socket socket;
  bool show = false;

  ///<<<============ Connect with socket ====================>>>
  static Future<void> connectToSocket() async {
    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];

    socket = io.io(
        ApiPaths.socketUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({'authorization': token}) // optional
            .build());

    socket.onConnect((data) {
      log("=============================> Connection $data");
    });
    socket.onConnectError((data) {
        log("============================>Connection Error $data");
    });

    socket.connect();
  }

  static Future<void> sendLocation({required double latitude, required double longitude}) async {
    try {
      log('sendLocation is being called');

      Map<String, String> data = {
        "lat": "23.002156",
        "lang": "90.654156",
      };

      // Check if the socket is connected before emitting
      if (socket.connected) {
        log('Socket is connected. Emitting client_location event.');

        socket.emitWithAck("client_location", data, ack: (response) {
          if (response != null) {
            log('Acknowledgment received: $response');
          } else {
            log('No acknowledgment received or timeout occurred.');
          }
        });
      } else {
        log('Socket is not connected. Unable to emit event.');
      }
    } catch (error, stackTrace) {
      // Catch any unexpected errors and log them
      log('Error in sendLocation: $error');
      log('Stack Trace: $stackTrace');
    }
  }

}