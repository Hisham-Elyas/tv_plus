import 'package:flutter/material.dart';

import 'video_player_screen.dart';

class TVChannelListScreen extends StatelessWidget {
  final List<Map<String, String>> channels = [
    {
      'name': 'Dubai Sports 1',
      'description': '',
      'logo': 'https://i.imgur.com/Poxw8lG.png',
      'videoUrl':
          'https://dmidspta.cdn.mgmlcdn.com/dubaisports/smil:dubaisports.stream.smil/chunklist.m3u8',
    },
    {
      'name': 'Sky News Arabia Vertical',
      'description': '',
      'logo': 'https://i.imgur.com/FjtzQQs.png',
      'videoUrl': 'https://stream.skynewsarabia.com/vertical/vertical.m3u8',
    },
    {
      'name': 'Al Jazeera',
      'description': '',
      'logo': 'https://i.imgur.com/7bRVpnu.png',
      'videoUrl': 'https://live-hls-v3-aja.getaj.net/AJA-V3/index.m3u8',
    },
    {
      'name': 'MBC 1',
      'description': '',
      'logo': 'https://i.imgur.com/CiA3plN.png',
      'videoUrl':
          'https://d3o3cim6uzorb4.cloudfront.net/out/v1/0965e4d7deae49179172426cbfb3bc5e/index.m3u8',
    },
    {
      'name': 'MBC 3',
      'description': "",
      'logo': 'https://i.imgur.com/PVt8OPN.png',
      'videoUrl':
          'https://shls-mbc3-prod-dub.shahid.net/out/v1/d5bbe570e1514d3d9a142657d33d85e6/index.m3u8',
    },
    {
      'name': 'MBC 4',
      'description': '',
      'logo': 'https://i.imgur.com/BcXASJp.png',
      'videoUrl':
          'https://shls-mbc4-prod-dub.shahid.net/out/v1/c08681f81775496ab4afa2bac7ae7638/index.m3u8',
    },
    {
      'name': 'MBC 5',
      'description': '',
      'logo': 'https://i.imgur.com/fRWaDyF.png',
      'videoUrl':
          'https://shls-mbc5-prod-dub.shahid.net/out/v1/2720564b6a4641658fdfb6884b160da2/index.m3u8',
    },
  ];

  TVChannelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H TV Channels'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: channels.length,
        itemBuilder: (context, index) {
          final channel = channels[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: SizedBox(
                  width: 150,
                  child: Image.network(
                    channel['logo']!,
                  )),
              title: Text(channel['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(channel['description']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      channelName: channel['name']!,
                      videoUrl: channel['videoUrl']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
