
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ColoredProgressIndicator extends StatelessWidget {
  const ColoredProgressIndicator({Key? key, this.size}) : super(key: key);
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: size ?? Dimensions.forty + Dimensions.one,
      itemBuilder: (BuildContext context, int index) {
        BoxShape myShape = index%3 != 0 ? BoxShape.circle : BoxShape.rectangle;
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: myShape,
            color: myShape == BoxShape.circle ? index.isEven ? Colors.red : Colors.green : Colors.blue,
          ),
        );
      },
    );
  }
}
