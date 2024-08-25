import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:flutter/material.dart';

class ManualPaymentScreen extends StatelessWidget {
  const ManualPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payemnt Now'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Text('text-Field $i');
          },
        ),
      ),
    );
  }
}
