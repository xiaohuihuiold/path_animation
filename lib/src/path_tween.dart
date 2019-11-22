import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class PathTween extends Animatable<List<Offset>> {
  final Path path;
  final bool startWithMoveTo;

  List<PathMetric> _pathMetrics;

  PathTween({
    @required this.path,
    bool forceClosed = false,
    this.startWithMoveTo = true,
  })  : assert(path != null),
        this._pathMetrics =
            path.computeMetrics(forceClosed: forceClosed).toList();

  @override
  List<Offset> transform(double t) {
    List<Offset> positions = List();
    _pathMetrics?.forEach((PathMetric pathMetric) {
      Path newPath = pathMetric.extractPath(
        0,
        pathMetric.length * (t == 0.0 ? 1 : t),
        startWithMoveTo: startWithMoveTo,
      );
      Offset position = newPath
          .computeMetrics()
          .first
          .getTangentForOffset((t == 0.0) ? 0 : double.infinity)
          .position;
      positions.add(Offset(position.dx, position.dy));
    });
    return positions;
  }

  @override
  String toString() => '$runtimeType($path)';
}
