import 'dart:math';
import 'dart:ui';

import 'package:syncfusion_flutter_charts/charts.dart';

class CustomDoughnutSeries<T, D> extends DoughnutSeries<T, D> {
  CustomDoughnutSeries({
    super.dataSource,
    super.xValueMapper,
    super.yValueMapper,
    super.pointColorMapper,
    String innerRadius = '70%',
    String radius = '100%',
    this.gap = "2.0",
  }) : super(innerRadius: innerRadius, radius: radius);

  @override
  final String gap;

  ChartSegment createSegment() {
    return _CustomDoughnutSegment<T, D>();
  }
}

class _CustomDoughnutSegment<T, D> extends DoughnutSegment<T, D> {
  @override
  void onPaint(Canvas canvas) {
    final Paint paint = getFillPaint();

    final CustomDoughnutSeries<T, D> customSeries =
        series as CustomDoughnutSeries<T, D>;
    final double gap = double.parse(customSeries.gap);

    // Calcular gap angle basado en un radio aproximado
    final double approximateRadius = 80.0; // Radio aproximado del chart
    final double gapAngle = (gap / (2 * pi * approximateRadius)) * 360;

    // Aplicar separación
    final double adjustedStartAngle = startAngle + gapAngle / 2;
    final double adjustedEndAngle = endAngle - gapAngle / 2;

    // Crear path normal pero con separación
    final Path path = Path();

    // Arco interior
    path.arcTo(
      Rect.fromCircle(
        center: series.center,
        radius: double.parse(series.innerRadius),
      ),
      adjustedStartAngle * (pi / 180),
      (adjustedEndAngle - adjustedStartAngle) * (pi / 180),
      false,
    );

    // Arco exterior
    path.arcTo(
      Rect.fromCircle(
        center: series.center,
        radius: double.parse(series.radius),
      ),
      adjustedEndAngle * (pi / 180),
      (adjustedStartAngle - adjustedEndAngle) * (pi / 180),
      false,
    );

    path.close();

    canvas.drawPath(path, paint);
  }
}
