import 'dart:io';
import 'package:camera/camera.dart';

sealed class CameraState {}

final class CameraInitial extends CameraState {}

final class CameraReady extends CameraState {
  final CameraController controller;
  final int selectedIndex;
  final FlashMode flashMode;

  CameraReady({
    required this.controller,
    required this.selectedIndex,
    required this.flashMode,
  });

  CameraReady copyWith({
    CameraController? controller,
    int? selectedIndex,
    FlashMode? flashMode,
  }) {
    return CameraReady(
      controller: controller ?? this.controller,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      flashMode: flashMode ?? this.flashMode,
    );
  }
}