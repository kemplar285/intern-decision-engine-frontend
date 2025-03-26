import 'package:flutter/material.dart';
import '../fonts.dart';

class LoanResults extends StatelessWidget {
  final int loanAmountResult;
  final int loanPeriodResult;
  final String errorMessage;

  const LoanResults({
    super.key,
    required this.loanAmountResult,
    required this.loanPeriodResult,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Approved Loan Amount: ${loanAmountResult != 0 ? loanAmountResult : "--"} €',
        ),
        const SizedBox(height: 8.0),
        Text(
          'Approved Loan Period: ${loanPeriodResult != 0 ? loanPeriodResult : "--"} months',
        ),
        Visibility(
          visible: errorMessage.isNotEmpty,
          child: Text(errorMessage, style: errorMedium),
        ),
      ],
    );
  }
}
