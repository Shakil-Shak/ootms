
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class BackGroundService{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel notificationChannel = const AndroidNotificationChannel(
    "stopwatch_foreground",
    "Stopwatch Foreground",
    description: "This channel is used for stopwatch notifications",
    importance: Importance.high,
  );

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(iOS: DarwinInitializationSettings()),
      );
    }


    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);


    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: notificationChannel.id,
        initialNotificationTitle: "Background Service Running",
        initialNotificationContent: "Fetching location...",
      ),
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
        onBackground: iosBackground,
      ),
    );

    await service.startService();
  }

// iOS Background Execution Handler
  @pragma("vm:entry-point")
  Future<bool> iosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

// Main Background Service Handler
  void onStart(ServiceInstance service) async {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Location Service",
        content: "Tracking your location...",
      );
    }

    // Request location permissions
    // await Geolocator.requestPermission();

    Timer.periodic(const Duration(seconds: 10), (timer) async {
      // if (!service.isRunning) timer.cancel();

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Log or process the location
      print("Location: ${position.latitude}, ${position.longitude}");

      // Optionally, communicate with the app via the service
      service.invoke("update", {
        "latitude": position.latitude,
        "longitude": position.longitude,
      });
    });
  }

  Future<void> handleLocationPermissions(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Location permission denied.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission is required to continue.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("Location permission permanently denied. Directing to settings.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enable location permissions in settings."),
          action: SnackBarAction(
            label: "Settings",
            onPressed: () {
              Geolocator.openAppSettings();
            },
          ),
        ),
      );
      return;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      log("Location permission granted.");
    } else {
      log("Unhandled permission state: $permission");
    }
  }
}