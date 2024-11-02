import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AnimatedSvg extends StatefulWidget {
  final String svgAssetPath;
  Color color;

  AnimatedSvg({required this.svgAssetPath,required this.color});

  @override
  _AnimatedSvgState createState() => _AnimatedSvgState();
}

class _AnimatedSvgState extends State<AnimatedSvg> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Path> _paths = [];
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: Duration(milliseconds: 1300), // Adjust duration to control the speed of drawing
    );

    _loadSvgPaths();
  }

  Future<void> _loadSvgPaths() async {
    try {
      // Load SVG file as a string
      final String svgString = await DefaultAssetBundle.of(context)
          .loadString(widget.svgAssetPath);

      // Parse SVG string and extract Drawable object
      final DrawableRoot svgRoot = await svg.fromSvgString(svgString, widget.svgAssetPath);

      _paths = _extractPaths(svgRoot);

      setState(() {
        _isLoaded = true;
      });

      // Start animation after loading the paths
      _controller.forward();
    } catch (e) {
      print('Error loading SVG: $e');
    }
  }

  List<Path> _extractPaths(DrawableRoot svgRoot) {
    List<Path> paths = [];

    // Function to visit and extract all paths from the Drawable
    void visitor(Drawable drawable) {
      if (drawable is DrawableShape) {
        paths.add(drawable.path);
      }
      if (drawable is DrawableGroup) {
        drawable.children!.forEach(visitor);
      }
    }

    // Traverse the drawable tree to extract paths
    svgRoot.children.forEach(visitor);
    return paths;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SvgPathPainter(_paths, _controller,widget.color),
          size: Size(Get.width, Get.height),
        );
      },
    )
        : CircularProgressIndicator();
  }
}

class SvgPathPainter extends CustomPainter {
  final List<Path> paths;
  final Animation<double> animation;
  Color color;

  SvgPathPainter(this.paths, this.animation,this.color) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw each path progressively based on animation
    for (Path path in paths) {
      final PathMetrics pathMetrics = path.computeMetrics();
      for (PathMetric metric in pathMetrics) {
        final Path extractPath = metric.extractPath(
          0.0,
          metric.length * animation.value, // Animate from 0 to full path length
        );
        canvas.drawPath(extractPath, paint); // Draw the partial path
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


