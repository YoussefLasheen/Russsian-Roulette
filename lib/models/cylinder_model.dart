import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:russian_roulette/models/chamber_model.dart';

class CylinderModel extends ChangeNotifier {
  List<ChamberModel> chambers;
  int numberOfChambers;
  int position;
  bool status;
  var player = AudioPlayer();

  CylinderModel(
      {required this.chambers,
      this.numberOfChambers = 6,
      this.position = 0,
      this.status = false});

  CylinderModel.empty({numberOfChambers = 6})
      : this(chambers: [
          for (var i = numberOfChambers; i >= 0; i--)
            ChamberModel(isFilled: false),
        ], numberOfChambers: 6, position: 1);

  void randomizePosition() {
    var rng = Random();
    int newPosition = rng.nextInt(numberOfChambers - 1);
    position = newPosition;
  }

  void shiftPosition() {
    if (position == numberOfChambers - 1) {
      position = 0;
    } else {
      position += 1;
    }
  }

  void fireBulletAndShiftPosition() {
    status = chambers[position].isFilled;
    chambers[position] = ChamberModel(isFilled: false);
    status?
    player.setAsset('assets/audio/fire.mp3'):
    player.setAsset('assets/audio/dry.mp3');
    player.play();
    shiftPosition();
    notifyListeners();
  }

  void toggleChamberIsFilledStatus(int index){
    chambers[index] = ChamberModel(isFilled: !chambers[index].isFilled);
    notifyListeners();
  }
}
