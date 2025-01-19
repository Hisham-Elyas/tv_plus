import 'package:flutter/material.dart';

import '../../../core/theming/colors.dart';
import '../widgets/custom_drawer_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My profile", style: TextStyle(color: Colors.white)),
        backgroundColor: ColorsManager.mainBlack,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: ColorsManager.white, // Change this to your desired color
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: CustomDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person),
                  // backgroundImage:
                  //     AssetImage('assets/avatar.jpg'), // Add your image here
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mohamed',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'mohamed@mail.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'My orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Already have 12 orders'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Shipping addresses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('3 addresses'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
