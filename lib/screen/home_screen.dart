import 'package:flutter/material.dart';

import 'tv_channel_list_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TVChannelListScreen(),
    );
  }
}
