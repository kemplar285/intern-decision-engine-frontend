import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inbank_frontend/widgets/national_id_field.dart';

import '../api_service.dart';
import 'loan_amount_slider.dart';
import 'loan_period_slider.dart';
import 'loan_results.dart';

class LoanForm extends StatefulWidget {
  const LoanForm({super.key});

  @override
  LoanFormState createState() => LoanFormState();
}

class LoanFormState extends State<LoanForm> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  String _nationalId = '';
  int _loanAmount = 2500;
  int _loanPeriod = 36;
  int _loanAmountResult = 0;
  int _loanPeriodResult = 0;
  String _errorMessage = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final result = await _apiService.requestLoanDecision(
          _nationalId, _loanAmount, _loanPeriod);
      setState(() {
        _loanAmountResult = int.parse(result['loanAmount'].toString());
        _loanPeriodResult = int.parse(result['loanPeriod'].toString());
        _errorMessage = result['errorMessage'].toString();
      });
    } else {
      _loanAmountResult = 0;
      _loanPeriodResult = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formWidth = screenWidth / 3;
    const minWidth = 500.0;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main box
          SizedBox(
            width: max(minWidth, formWidth),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormField<String>(
                    builder: (state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NationalIdTextFormField(
                            onChanged: (value) {
                              setState(() {
                                _nationalId = value ?? '';
                                _submitForm();
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  // Loan Amount Box
                  const SizedBox(height: 60.0),
                  LoanAmountSlider(
                    loanAmount: _loanAmount,
                    onChanged: (newAmount) {
                      setState(() {
                        _loanAmount = newAmount;
                        _submitForm();
                      });
                    },
                  ),

                  // Loan Period Slider Box
                  const SizedBox(height: 24.0),
                  LoanPeriodSlider(
                    loanPeriod: _loanPeriod,
                    onChanged: (newPeriod) {
                      setState(() {
                        _loanPeriod = newPeriod;
                        _submitForm();
                      });
                    },
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),

          // Loan Results Box
          const SizedBox(height: 16.0),
          LoanResults(
            loanAmountResult: _loanAmountResult,
            loanPeriodResult: _loanPeriodResult,
            errorMessage: _errorMessage,
          ),
        ],
      ),
    );
  }
}
