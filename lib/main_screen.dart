import 'package:flutter/material.dart';
import 'package:russian_roulette/widgets/fire_button.dart';
import 'package:russian_roulette/widgets/modify_cylinder/modify_cylinder.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, __, ___) => const ModifyCylinder()),
              );
            },
            icon: Icon(Icons.settings),
          ),
          FireButton(),
        ],
      ),
    );
  }
}
