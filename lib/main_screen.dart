import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cylinder_model.dart';
import 'widgets/modify_cylinder/modify_cylinder.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CylinderModel cylinder = Provider.of<CylinderModel>(context);
    bool canShoot = false;
    return Material(
      child: GestureDetector(
        onHorizontalDragStart: (_) {
          canShoot = true;
        },
        onHorizontalDragEnd: (_) {
          canShoot = true;
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 2 && canShoot) {
            cylinder.fireBulletAndShiftPosition();
            canShoot = false;
          }
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 10) {
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
