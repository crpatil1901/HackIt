import 'package:flutter/material.dart';
import 'package:hack_it/screens/ProfileScreen.dart';

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
        child: Stack(
          children: [
            ListView(
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
                // Container(
                //   height: double.maxFinite,
                //   child: ListView.builder(
                //     itemBuilder: (context, index) => questionButton(text: "Question ${index+1}",onPressed:  () {}),
                //     itemCount: 8,
                //   ),
                // ),
                TextButton(onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ProfileScreen(),)
                  );
                }, child: Text("Profile")
                )
              ],
            ),

          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hack It"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {},
        icon: Icon(Icons.edit),
        label: Text("Edit"),
      ),
      drawer: drawer,
      body: Center(
        child: Text("Main Screen"),
      )
    );
  }
}