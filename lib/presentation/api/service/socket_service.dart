import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


class SocketServices {
  static late io.Socket socket;
  bool show = false;

  ///<<<============ Connect with socket ====================>>>
  static Future<void> connectToSocket() async {
    List<String>? userDetails = await getUserAcessDetails();
    if(userDetails != null && userDetails.isNotEmpty){
      String token = userDetails[0];
      socket = io.io(
          ApiPaths.socketUrl,
          io.OptionBuilder()
              .setTransports(['websocket'])
              .enableAutoConnect()
              .setExtraHeaders({'authorization': token}) // optional
              .build());
    }

    socket.onConnect((data) {
      log("=============================> Connection $data");
    });
    socket.onConnectError((data) {
        log("============================>Connection Error $data");
    });

    socket.connect();
  }

  /// Send Location Method

  static Future<void> sendLocation({required double latitude, required double longitude}) async {
    try {
      log('sendLocation is being called');

      Map<String, String> data = {
        "lang": longitude.toString(),
        "lat": latitude.toString(),
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

  /// Get Location Method

  static Future<LatLng?> getLocation({required String userId}) async {
    try {
      log('Get Location is being called');


      // Check if the socket is connected before emitting
      if (socket.connected) {
        log('Socket is connected. Getting client_location event.');
        log('User Id: $userId');

    // ::$userId
        socket.on("server_location", (data) {

          log("======>>>${data["lat"]}<<<=======");
          log("======>>>${data["lang"]}<<<=======");

          return LatLng(double.parse(data["lat"]), double.parse(data["lang"]));

        },);
      } else {
        log('Socket is not connected. Unable to emit event.');
        return null;
      }
    } catch (error, stackTrace) {
      // Catch any unexpected errors and log them
      log('Error in sendLocation: $error');
      log('Stack Trace: $stackTrace');
      return null;
    }
  }

}