import 'package:flutter/material.dart';
import '../colors.dart';

class LoanAmountSlider extends StatelessWidget {
  final int loanAmount;
  static const int loanMinAmount = 2000;
  static const int loanMaxAmount = 10000;
  final Function(int) onChanged;

  const LoanAmountSlider({
    super.key,
    required this.loanAmount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Loan Amount: $loanAmount €'),
        const SizedBox(height: 8),
        Slider.adaptive(
          value: loanAmount.toDouble(),
          min: loanMinAmount.toDouble(),
          max: loanMaxAmount.toDouble(),
          divisions: 80,
          label: '$loanAmount €',
          activeColor: AppColors.secondaryColor,
          onChanged: (double newValue) {
            onChanged(((newValue.floor() / 100).round() * 100));
          },
        ),
        const SizedBox(height: 4),
        const Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('$loanMinAmount€')),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('$loanMaxAmount€')),
              ),
            )
          ],
        ),
      ],
    );
  }
}
