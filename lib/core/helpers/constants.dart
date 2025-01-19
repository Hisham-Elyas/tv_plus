import '../../features/home/data/models/channel_category_model.dart';

bool isLoggedInUser = false;
bool isOnBordingView = false;

class SharedPrefKeys {
  static const String userToken = 'userToken';
}

class ImageAssets {
  static const String logo = 'assets/images/Tv Channel.png';
  static const String bgImage = 'assets/images/bg_image.png';
}

final List onBoardingListDescription = [
  "شاهد مبارياتك المفضلة بلا انقطاع",
  "جميع الدوريات العالمية والمحلية بضغطة زر واحدة",
  "اشتراك سنوي وشهري متميز",
];
final List<Map<String, dynamic>> events = [
  {
    "team1": "الدينزي",
    "team2": "فالنسيا",
    "team1Logo": "https://imgs.ysscores.com/teams/150/1701690118820.png",
    "team2Logo": "https://imgs.ysscores.com/teams/150/4871690119302.png",
    "status": "جارية الآن",
    "league": "كأس ملك إسبانيا",
    "commentator": "عبدالعزيز السير",
    "channel": "SSC Extra 2",
  },
  {
    "team1": "التعاون",
    "team2": "القادسية",
    "team1Logo": "https://imgs.ysscores.com/teams/150/1701690118820.png",
    "team2Logo": "https://imgs.ysscores.com/teams/150/4871690119302.png",
    "status": "انتهت المباراة",
    "league": "كأس الملك السعودي",
    "commentator": "خالد المديفر",
    "channel": "SSC Extra 1",
  },
  {
    "team1": "الهلال",
    "team2": "الاتحاد",
    "team1Logo": "https://imgs.ysscores.com/teams/150/1701690118820.png",
    "team2Logo": "https://imgs.ysscores.com/teams/150/4871690119302.png",
    "status": "انتهت المباراة",
    "league": "كأس الملك السعودي",
    "commentator": "عبدالله الحربي",
    "channel": "SSC SPORTS 1",
  },
];

final Map<String, List<Map<String, String>>> channels = {
  "beIN Sports ᴴᴰ": [
    {
      'name': 'beIN Sport 1',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544835',
    },
    {
      'name': 'beIN Sport 2',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544834',
    },
    {
      'name': 'beIN Sport 3',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544833',
    },
    {
      'name': 'beIN Sport 4',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544832',
    },
    {
      'name': 'beIN Sport 5',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544831',
    },
    {
      'name': 'beIN Sport 6',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544830',
    },
    {
      'name': 'beIN Sport 7',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544829',
    },
    {
      'name': 'beIN Sport 8',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544828',
    },
    {
      'name': 'beIN Sport 9',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544827',
    },
    {
      'name': 'beIN Sport XTRA 1',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544826',
    },
    {
      'name': 'beIN Sport XTRA 2',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544825',
    },
    {
      'name': 'beIN Sport XTRA 3',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544824',
    },
  ],
  "SCC ᴴᴰ": [
    {
      'name': 'SCC 1 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844321',
    },
    {
      'name': 'SCC 2 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844320',
    },
    {
      'name': 'SCC 3 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844319',
    },
    {
      'name': 'SCC 4 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844318',
    },
    {
      'name': 'SCC 5 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844317',
    },
    {
      'name': 'SS XTRAC  1 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844316',
    },
    {
      'name': 'SS XTRAC  2 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844315',
    },
    {
      'name': 'SS XTRAC  3 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl':
          'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844314',
    },
  ]
};

// Parse the data into a list of ChannelCategory objects
List<ChannelCategory> channelCategories = channels.entries.map((entry) {
  return ChannelCategory.fromMap(entry.key, entry.value);
}).toList();
final List<Map<String, String>> beINandCSSchannels = [
  {
    'name': 'beIN Sport 1',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544835',
  },
  {
    'name': 'beIN Sport 2',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544834',
  },
  {
    'name': 'beIN Sport 3',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544833',
  },
  {
    'name': 'beIN Sport 4',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544832',
  },
  {
    'name': 'beIN Sport 5',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544831',
  },
  {
    'name': 'beIN Sport 6',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544830',
  },
  {
    'name': 'beIN Sport 7',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544829',
  },
  {
    'name': 'beIN Sport 8',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544828',
  },
  {
    'name': 'beIN Sport 9',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544827',
  },
  {
    'name': 'beIN Sport XTRA 1',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544826',
  },
  {
    'name': 'beIN Sport XTRA 2',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544825',
  },
  {
    'name': 'beIN Sport XTRA 3',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544824',
  },
  {
    'name': 'SCC 1 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844321',
  },
  {
    'name': 'SCC 2 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844320',
  },
  {
    'name': 'SCC 3 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844319',
  },
  {
    'name': 'SCC 4 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844318',
  },
  {
    'name': 'SCC 5 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844317',
  },
  {
    'name': 'SS XTRAC  1 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844316',
  },
  {
    'name': 'SS XTRAC  2 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844315',
  },
  {
    'name': 'SS XTRAC  3 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/844314',
  },
];
