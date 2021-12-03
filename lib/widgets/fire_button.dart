import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_roulette/models/cylinder_model.dart';

class FireButton extends StatelessWidget {
  const FireButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CylinderModel cylinder = Provider.of<CylinderModel>(context);
    return IconButton(
      onPressed: () {
        cylinder.fireBulletAndShiftPosition();
      },
      icon: Icon(
        Icons.plus_one_rounded,
        color: cylinder.status ? Colors.red : Colors.black,
      ),
    );
  }
}
