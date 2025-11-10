import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final List<Widget> slivers;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const CommonScaffold({
    super.key,
    required this.slivers,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          Container(color: const Color(0xFF141326)),

          Positioned(
            bottom: -250,
            right: -125,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x80E840D1), Colors.transparent],
                  radius: 0.6,
                ),
              ),
            ),
          ),

          Positioned(
            top: -280,
            right: 50,
            child: Container(
              width: 500,
              height: 450,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0x80E840D1), Colors.transparent],
                ),
              ),
            ),
          ),

          CustomScrollView(slivers: slivers),
        ],
      ),
    );
  }
}
