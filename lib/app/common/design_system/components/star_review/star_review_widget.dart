import 'package:flutter/material.dart';

class StarReviewWidget extends StatelessWidget {
  const StarReviewWidget({
    required this.rating,
    required this.onRatingChanged,
    super.key,
  });

  final int rating;
  final Function(int) onRatingChanged;

  @override
  Widget build(BuildContext context) {
    const starNumbers = 5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        starNumbers,
        (index) {
          final isFilled = index < rating;
          return IconButton(
            onPressed: () => onRatingChanged(index + 1),
            icon: Icon(
              isFilled ? Icons.star : Icons.star_border,
              size: 30,
              color: isFilled ? const Color(0xFFFFCC00) : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
