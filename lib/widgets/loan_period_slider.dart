import 'package:flutter/material.dart';
import '../colors.dart';

class LoanPeriodSlider extends StatelessWidget {
  final int loanPeriod;
  static const int maxLoanPeriod = 48;
  static const int minLoanPeriod = 12;
  final Function(int) onChanged;

  const LoanPeriodSlider({
    super.key,
    required this.loanPeriod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Loan Period: $loanPeriod months'),
        const SizedBox(height: 8),
        Slider.adaptive(
          value: loanPeriod.toDouble(),
          min: minLoanPeriod.toDouble(),
          max: maxLoanPeriod.toDouble(),
          divisions: 6,
          label: '$loanPeriod months',
          activeColor: AppColors.secondaryColor,
          onChanged: (double newValue) {
            onChanged(((newValue.floor() / 6).round() * 6));
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
                  child: Text('$minLoanPeriod months'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('$maxLoanPeriod months'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
