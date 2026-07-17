import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;
  final VoidCallback? onBackspacePressed;
  final Color textColor;
  final double buttonSize;

  const NumericKeyboard({
    super.key,
    required this.onKeyPressed,
    this.onBackspacePressed,
    this.textColor = Colors.white,
    this.buttonSize = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -350,
          left: -200,
          child: Container(
            width: 800,
            height: 800,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0x80E840D1), Colors.transparent],
                radius: 0.6,
              ),
            ),
          ),
        ),

        Column(
          children: [
            _buildRow([1, 2, 3]),
            const SizedBox(height: 10),
            _buildRow([4, 5, 6]),
            const SizedBox(height: 10),
            _buildRow([7, 8, 9]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKey("."),
                _buildKey("0"),
                if (onBackspacePressed != null) _buildBackspaceKey(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<int> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        return _buildKey(number.toString());
      }).toList(),
    );
  }

  Widget _buildKey(String value) {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: TextButton(
        onPressed: () => onKeyPressed(value),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 35,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceKey() {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: TextButton(
        onPressed: onBackspacePressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Icon(Icons.backspace, color: textColor, size: 35),
      ),
    );
  }
}
