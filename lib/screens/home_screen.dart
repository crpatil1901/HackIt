import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget questionButton({
      required String text,
      required void Function() onPressed
    }) => ListTile(
      onTap: onPressed,
      title: Text(text),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      ),
    );

    Widget drawer = Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pick a question",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10.0,),
                  Text(
                    "16 more stars to collect...",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            Container(
              height: double.maxFinite,
              child: ListView.builder(
                itemBuilder: (context, index) => questionButton(text: "Question ${index+1}",onPressed:  () {}),
                itemCount: 8,
              ),
            ),
          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hack It"),
      ),
      drawer: drawer,
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.account_circle,
              size: 144.0,
            ),
            Text(
              "Chinmay Patil",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email: ",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        "crpatil1901@gmail.com",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).colorScheme.onPrimaryContainer, thickness: 0.5, height: 25.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone number: ",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        "9860767300",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 50.0,),
            Text(
              "Time Remaining:",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "4:00:00",
              style: TextStyle(fontSize: 64.0),
            )
          ],
        )
      ),
    );
  }
}