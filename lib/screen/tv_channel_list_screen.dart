import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_tv/screen/tv2_screen.dart';

import 'video_player_screen.dart';
// import 'package:m3u_parser/m3u_parser.dart';

import 'package:m3u_parser_nullsafe/m3u_parser_nullsafe.dart';
import 'package:flutter/services.dart';

Future<List<Map<String, String>>> parseM3U() async {
  List<Map<String, String>> channels = [];
  try {
    final String m3uContent =
        await rootBundle.loadString('assets/playlist.m3u');
    final lines = m3uContent.split("\n");

    String? currentTitle;

    for (var line in lines) {
      if (line.startsWith("#EXTINF")) {
        final titleMatch = RegExp(r'#EXTINF:.*?,(.*)').firstMatch(line);
        currentTitle = titleMatch?.group(1);
      } else if (line.startsWith("http")) {
        if (currentTitle != null) {
          channels.add({"title": currentTitle, "url": line});
          currentTitle = null;
        }
      }
    }

    // for (var channel in channels) {
    //   print("Channel: ${channel['title']}, URL: ${channel['url']}");
    // }
  } catch (e) {
    print("Error parsing M3U: $e");
  }
  return channels;
}

class TVChannelListScreen extends StatefulWidget {
  const TVChannelListScreen({super.key});

  @override
  State<TVChannelListScreen> createState() => _TVChannelListScreenState();
}

class _TVChannelListScreenState extends State<TVChannelListScreen> {
// Future<List<String>> parseM3UFile(String filePath) async {
  List<Map<String, String>> channels1 = [];

  UnmodifiableListView<M3uItem> channels2 = UnmodifiableListView([]);

  // Future<List<String>> parseM3UFile(String filePath) async {
  //   final String m3uContent = await rootBundle.loadString(filePath);
  //   print('m3uContent: $m3uContent');
  //   print('===================================');
  //   final m3uList = await M3uList.loadFromFile(m3uContent);
  //   channels1 = m3uList.items.map((entry) => entry.link).toList();
  //   // for (var item in m3uList.items) {
  //   //   print('Title: ${item.title}');
  //   //   print('link: ${item.link}');
  //   // }
  //   return channels1;
  // }

  Future<M3uList> parseM3UFile2(String filePath) async {
    final String m3uContent = await rootBundle.loadString(filePath);
    final m3uList = await M3uList.loadFromFile(m3uContent);
    channels2 = m3uList.items;
    // return m3uList.items.map((entry) => entry.link).toList();
    // for (var item in m3uList.items) {
    //   print('Title: ${item.title}');
    // }
    return m3uList;
  }

  final List<Map<String, String>> channels0 = [
    {
      'name': 'UK: BEIN SPORTS AU 1 ᴴᴰ ◉',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/1366.png?57527',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/595835',
    },
    {
      'name': '◉: beIN Sp⚽rts 1 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544835',
    },
    {
      'name': '◉: beIN Sp⚽rts 2 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544834',
    },
    {
      'name': '◉: beIN Sp⚽rts 3 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544833',
    },
    {
      'name': '◉: beIN Sp⚽rts 4 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544832',
    },
    {
      'name': '◉: beIN Sp⚽rts 5 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544831',
    },
    {
      'name': '◉: beIN Sp⚽rts 6 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544830',
    },
    {
      'name': '◉: beIN Sp⚽rts 7 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544829',
    },
    {
      'name': '◉: beIN Sp⚽rts 8 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544828',
    },
    {
      'name': '◉: beIN Sp⚽rts 9 HD',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544827',
    },
    {
      'name': 'SCC 1 ᴴᴰ',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844321',
    },
    {
      'name': 'SCC 2 ᴴᴰ',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844320',
    },
    {
      'name': 'SCC 3 ᴴᴰ',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844319',
    },
    {
      'name': 'SCC 4 ᴴᴰ',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844318',
    },
    {
      'name': 'SCC 5 ᴴᴰ',
      'description': '',
      // 'logo': 'https://i.imgur.com/Poxw8lG.png',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844317',
    },
    {
      'name': 'Dubai Sports 1',
      'description': '',
      'logo': 'https://i.imgur.com/Poxw8lG.png',
      // 'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8088.jpg?85674',
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
  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero, () async {
    //   channels1 = await parseM3U();
    //   setState(() {});
    // });
    // parseM3UFile0("assets/playlist.m3u");
    // parseM3UFile("assets/playlist.m3u");
    // parseM3UFile2('assets/playlist.m3u');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H TV Channels'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: channels0.length,
        itemBuilder: (context, index) {
          final channel = channels0[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: SizedBox(
                  width: 150,
                  child: Image.network(
                    // channels0[2]['logo']!,
                    channel['logo']!,
                  )),
              title: Text(
                  // channels1[index]["title"]!,
                  channel["name"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(channel['description']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VideoPlayerScreen2(url: channel["videoUrl"]!)),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => VideoPlayerScreen(
                //       channelName: channels0[1]['name']!,
                //       // videoUrl: channel['videoUrl']!,
                //       videoUrl: channels1[index]["url"]!,
                //     ),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
