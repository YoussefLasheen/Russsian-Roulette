import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:russian_roulette/models/chamber_model.dart';
import 'package:russian_roulette/models/cylinder_model.dart';

class ModifyCylinder extends StatefulWidget {
  const ModifyCylinder({Key? key}) : super(key: key);

  @override
  State<ModifyCylinder> createState() => _ModifyCylinderState();
}

class _ModifyCylinderState extends State<ModifyCylinder> {
  double degreeToRadians(double degrees) => degrees * (3.14 / 180);
  double degree = 0;
  double radius = 5;
  @override
  Widget build(BuildContext context) {
    CylinderModel cylinder = Provider.of<CylinderModel>(context, listen: false);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300, 300)),
        child: Material(
          color: Color(0xfff7f7fa),
          elevation: 20,
          borderRadius: BorderRadius.circular(20),
          shadowColor: Colors.black,
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  cylinder.randomizePosition();
                  Navigator.pop(context);
                },
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 200, height: 200),
                child: Transform.rotate(
                  angle: degreeToRadians(degree),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onPanUpdate: adjustTimeKnob,
                    behavior: HitTestBehavior.translucent,
                    child: Stack(
                      children: const [
                        Positioned(
                          child: ChamberIndicator(
                            index: 0,
                          ),
                          top: 10,
                          right: 0,
                          left: 0,
                        ),
                        Positioned(
                          child: ChamberIndicator(
                            index: 1,
                          ),
                          top: 40,
                          left: 15,
                        ),
                        Positioned(
                          child: ChamberIndicator(
                            index: 2,
                          ),
                          bottom: 40,
                          left: 15,
                        ),
                        Positioned(
                          child: ChamberIndicator(
                            index: 3,
                          ),
                          bottom: 10,
                          right: 0,
                          left: 0,
                        ),
                        Positioned(
                          child: ChamberIndicator(
                            index: 4,
                          ),
                          bottom: 40,
                          right: 15,
                        ),
                        Positioned(
                          child: ChamberIndicator(
                            index: 5,
                          ),
                          top: 40,
                          right: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void adjustTimeKnob(d) {
    /// Pan location on the wheel
    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    /// Pan movements
    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    /// Absolute change on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    /// Directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : yChange * -1;

    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

    // Total computed change
    double rotationalChange = verticalRotation + horizontalRotation;

    double _value = degree + (rotationalChange / 5);

    setState(() {
      degree = _value;
    });
  }
}

class ChamberIndicator extends StatelessWidget {
  final int index;
  const ChamberIndicator({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CylinderModel cylinder = Provider.of<CylinderModel>(context);
    return IconButton(
      iconSize: 50,
      splashRadius: 20,
      onPressed: () {
        cylinder.toggleChamberIsFilledStatus(index);
      },
      icon: cylinder.chambers[index].isFilled
          ? Icon(
              Icons.circle,
            )
          : Icon(Icons.circle_outlined),
    );
  }
}
