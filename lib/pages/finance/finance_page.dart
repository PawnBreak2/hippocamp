import 'package:flutter/material.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/buttons/button_go_on.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: CustomColors.primaryBlue,
        title: Text(
          "Personal Finance",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          ButtonGoOn(
            iconLeft: Icons.attach_money_outlined,
            title: "Financial Timeline",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.wallet,
            title: "Liquidity Wallets",
            onPressed: () {},
          ),
          Divider(),
          ButtonGoOn(
            iconLeft: Icons.calendar_month,
            title: "Monthly Infow/Outflow",
            onPressed: () {},
          ),
          Divider(),
        ],
      ),
    );
  }
}
