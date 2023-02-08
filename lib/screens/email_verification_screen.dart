import 'package:flutter/material.dart';
import 'package:hack_it/view_models/login_vm.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify your email"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Click on the link sent to you to verify your email.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Return to Login Page")
            ),
          ],
        ),
      ),
    );
  }
}
