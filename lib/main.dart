import 'package:flutter/material.dart';
import 'package:russian_roulette/main_screen.dart';

import 'package:provider/provider.dart';
import 'package:russian_roulette/models/chamber_model.dart';
import 'package:russian_roulette/models/cylinder_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CylinderModel(
        chambers: [
          ChamberModel(isFilled: false),
          ChamberModel(isFilled: true),
          ChamberModel(isFilled: true),
          ChamberModel(isFilled: true),
          ChamberModel(isFilled: true),
          ChamberModel(isFilled: true),

        ]
      ),
      child: MaterialApp(
        theme: ThemeData(),
        home: const MainScreen(),
      ),
    );
  }
}
