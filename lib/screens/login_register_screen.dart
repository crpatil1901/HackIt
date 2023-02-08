
import 'package:flutter/material.dart';
import 'package:hack_it/screens/email_verification_screen.dart';
import 'package:hack_it/screens/home_screen.dart';
import 'package:hack_it/view_models/login_vm.dart';
import 'package:provider/provider.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<LoginViewModel>(context);

    Widget loginCardHeader = Container(
      color: Theme.of(context).colorScheme.primary,
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      child: Text(
        "Log In",
        style: Theme.of(context).textTheme.displayLarge
            ?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        )
        ,
      ),
    );

    Widget errorDialogBox =  AlertDialog(
        title: Text(
          "Error",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
        content: Text(
          viewModel.error ?? "Invalid Error",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.errorContainer,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text("OK",),
          ),
        ]
    );

    Widget googleLoginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
      ),
      onPressed: () {},
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google_icon.png",
              height: 24.0,
            ),
            const SizedBox(width: 10.0,),
            const Text("Sign in with Google",),
          ],
        ),
      ),
    );

    Widget facebookLoginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white
      ),
      onPressed: () {},
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/facebook_icon.png",
              height: 24.0,
            ),
            const SizedBox(width: 5.0,),
            const Text("Sign in with Facebook",),
          ],
        ),
      ),
    );

    Widget appleLoginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white
      ),
      onPressed: () {},
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/apple_icon.png",
              height: 24.0,
            ),
            const SizedBox(width: 10.0,),
            const Text("Sign in with Apple",),
          ],
        ),
      ),
    );

    Widget emailLogin = Column(
      children: [
        TextField(
          autocorrect: false,
          decoration: const InputDecoration(
            labelText: "Email",
          ),
          onChanged: (String newVal) { viewModel.setEmail(newVal); },
        ),
        TextField(
          autocorrect: false,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Password",
          ),
          onChanged: (String newVal) { viewModel.setPassword(newVal); },
        ),
        const SizedBox(height: 10.0,),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    await viewModel.signup(context, errorDialogBox);
                    viewModel.sendVerificationEmail();
                    if (context.mounted) {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EmailVerificationScreen(),
                          ),
                      );
                    }
                  } catch (_) {
                    showDialog(context: context,
                      builder: (context) => errorDialogBox,
                    );
                  }
                },
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: FilledButton(
                onPressed: () async {
                  try {
                    await viewModel.login(context, errorDialogBox);
                    if (context.mounted) {
                      if (!(viewModel.isUserVerified ?? true)) {
                        viewModel.sendVerificationEmail();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const EmailVerificationScreen(),)
                        );
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const HomeScreen(),)
                        );
                      }
                    }
                  } catch (_) {
                    showDialog(context: context,
                      builder: (context) => errorDialogBox,
                    );
                  }

                },
                child: const Text("Login"),
              ),
            ),
          ],
        )
      ],
    );

    Widget loginCardBody = Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailLogin,
          const SizedBox(height: 10.0,),
          Text(
            "OR",
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer)
          ),
          const SizedBox(height: 10.0,),
          googleLoginButton,
          const SizedBox(height: 10.0,),
          appleLoginButton,
          const SizedBox(height: 10.0,),
          facebookLoginButton,
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Theme.of(context).colorScheme.primaryContainer
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  loginCardHeader,
                  loginCardBody,
                ],
              ),
            ),
          ),
          if (viewModel.status == LoginStatus.busy)
            Expanded(child: Container(color: Colors.black45,)),
          if (viewModel.status == LoginStatus.busy)
            const Center(child: CircularProgressIndicator(),),

        ],
      ),
    );

  }
}
