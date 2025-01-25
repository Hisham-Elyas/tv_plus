import 'package:get/get.dart';
import 'package:h_tv/core/localization/constants.dart';

import '../../features/home/data/models/channel_category_model.dart';
import '../../features/home/data/models/league_model.dart';
import '../../features/home/data/models/match_model.dart';

bool isLoggedInUser = false;
bool isOnBordingView = false;

class SharedPrefKeys {
  static const String userToken = 'userToken';
}

class ImageAssets {
  static const String logo = 'assets/images/Tv Channel.png';
  static const String bgImage = 'assets/images/bg_image.png';
  static const String saFlags = 'assets/images/sa.png';
  static const String usFlags = 'assets/images/us.png';
}

final List onBoardingListDescription = [
  WatchYourFavouriteMatches.tr,
  All_international_and_local_leagues_with_one_click_of_a_button.tr,
  Premium_annual_and_monthly_subscription.tr,
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
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544835',
    },
    {
      'name': 'beIN Sport 2',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544834',
    },
    {
      'name': 'beIN Sport 3',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544833',
    },
    {
      'name': 'beIN Sport 4',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544832',
    },
    {
      'name': 'beIN Sport 5',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544831',
    },
    {
      'name': 'beIN Sport 6',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544830',
    },
    {
      'name': 'beIN Sport 7',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544829',
    },
    {
      'name': 'beIN Sport 8',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544828',
    },
    {
      'name': 'beIN Sport 9',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544827',
    },
    {
      'name': 'beIN Sports Xtra 1',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544826',
    },
    {
      'name': 'beIN Sports XTRA 2',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544825',
    },
    {
      'name': 'beIN Sports XTRA 3',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544824',
    },
  ],
  "BEIN ENTERTAINMENT": [
    {
      'name': 'beIN MOVIES 1 ᴴᴰ',
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/11506.jpg?47971",
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201419',
    },
    {
      'name': 'beIN MOVIES 2 ᴴᴰ',
      'logo': "http://icon-tmdb.me/stalker_portal/misc/logos/320/531.png?66704",
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201418',
    },
    {
      'name': 'beIN MOVIES 3 ᴴᴰ',
      'logo': "http://icon-tmdb.me/stalker_portal/misc/logos/320/530.png?10213",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201417"
    },
    {
      'name': 'beIN MOVIES 4 ᴴᴰ',
      'logo': "http://icon-tmdb.me/stalker_portal/misc/logos/320/6150.png?2523",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201416"
    },
    {
      'name': "beIN SERIES 1 ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/12236.jpg?43000",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201415"
    },
    {
      'name': "beIN SERIES  ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/12236.jpg?ver=10771",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201414"
    },
    {
      'name': "beIN DRAMA ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/1363.png?36584",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201413"
    },
    {
      'name': "beIN GOURMET ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/6157.jpg?11485",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201410"
    },
    {
      'name': "beIN STAR ACTION ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/12146.jpg?75124",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201407"
    },
    {
      'name': "beIN STAR MOVIES ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/11044.png?99544",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201406"
    },
    {
      'name': "beIN STAR LIFE ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/9400.png?61771",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201405"
    },
    {
      'name': "beIN STAR WORLD ᴴᴰ",
      'logo':
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/9333.jpg?86309",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1201404"
    },
  ],
  "NATIONAL GEOGRAPHIC": [
    {
      'name': 'NATIONAL GEOGRAPHIC HD',
      'logo': "http://icon-tmdb.me/stalker_portal/misc/logos/320/59.jpg?66642",
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/479851',
    },
  ],
  "SCC ᴴᴰ": [
    {
      'name': 'SCC 1 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844321',
    },
    {
      'name': 'SCC 2 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844320',
    },
    {
      'name': 'SCC 3 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844319',
    },
    {
      'name': 'SCC 4 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844318',
    },
    {
      'name': 'SCC 5 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844317',
    },
    {
      'name': 'SSC XTRAC  1 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844316',
    },
    {
      'name': 'SS XTRAC  2 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844315',
    },
    {
      'name': 'SS XTRAC  3 ᴴᴰ',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844314',
    },
  ],
  "OSN PLATINUM": [
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " YAHALA ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887309"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " YAHALA BIL ARABI 1 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887308"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " YAHALA BIL ARABI 2 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887307"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " YAHALA AFLAM ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887306"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MUSALSALAT 1 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887305"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MUSALSALAT 2 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887304"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ALYAWM ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887303"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " CINEMA 1 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887302"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " CINEMA 2 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887301"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " FAN ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887300"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " SAFWAH ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887299"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ART AFLAM 1 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887298"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ART AFLAM 2 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887297"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ART CINEMA ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887296"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ART HEKAYAT 1 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887295"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ART HEKAYAT 2 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887294"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MOVIES ACTION ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887293"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MOVIES PREMIERE ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887292"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MOVIES HOLLOWAY ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887291"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " COMDEY ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887290"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MOVIES FAMILY ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887289"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " KIDS ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887288"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " CRIME ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887287"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " SHOWCASE ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887286"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " SHOWCASE CLASSICS ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887285"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MOVIES HORROR ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887284"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MOVIES COMEDY ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887283"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ONE ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887282"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " NOW ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887281"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " NICK JR. ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887280"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " NICKTOONS ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887279"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " KID ZONE TV ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887278"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " NICKELODEON ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887277"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MOONBUG KIDS ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887276"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " FATAFEAT ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887275"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " CARTOON NETWORK ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887273"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " DISCOVERY HD ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887272"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " DISCOVERY IDX ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887271"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " ANIMAL PLANET HD ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887274"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " HISTORY ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887270"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " HISTORY 2 ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887269"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MEZZE ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887268"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " TLC ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887267"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " E!",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887266"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " POP UP ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887265"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " GINX ESPORTS ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887264"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " BLOOMBERG ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887263"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " NEWS ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887262"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MTV 00S ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887261"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " MTV LIVE ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887260"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " FASHIONTV ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887259"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " TFC ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887258"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/6623.jpg",
      "name": " FOX-NEWS ᵁᴴᴰ",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/887257"
    }
  ],
  "NEWS ᴴᴰ": [
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/1182.jpg",
      "name": " Al Jazeera HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/499084"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/1182.jpg",
      "name": " Al Jazeera 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/107160"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/1182.jpg",
      "name": " Al Jazeera UHD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/2319"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/218.jpg",
      "name": " Al Jazeera English 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3254"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/218.jpg",
      "name": " Al Jazeera English HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/499085"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/354.png",
      "name": " Al Jazeera Mubasher",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4301"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/354.png",
      "name": " Al Jazeera Mubasher HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/499087"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/354.png",
      "name": " Al Jazeera Mubasher 2 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/191259"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/354.png",
      "name": " Al Jazeera Mubasher 2 HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/499086"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/1186.png?82115",
      "name": " Al Arabiya 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/2328"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/1186.png?82115",
      "name": " Al Arabiya HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/281938"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/292.jpg",
      "name": " Al Arabiya Hadath 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/2284"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/292.jpg",
      "name": " Al Arabiya Hadath HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/281939"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/292.jpg",
      "name": " Al Arabiya Hadath SD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/281937"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/12490.jpg?84280",
      "name": " Al Arabiya Business 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/619549"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/12490.jpg?84280",
      "name": " Al Arabiya Business HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/619546"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/12819.png",
      "name": " Al Araby 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/2329"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/475.jpg?36736",
      "name": " Al Araby 2 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/342427"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/475.jpg?36736",
      "name": " Al Araby 2 HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/342428"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/9671.jpg?78641",
      "name": " Al Qahera News 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/406151"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/149.jpg",
      "name": " Al Ghad Al Araby 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/818450"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/37.jfif?ver=49046",
      "name": " Al Mayadeen",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/818448"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/304.jpg",
      "name": " Al Ayam TV 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4259"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/304.jpg",
      "name": " Al Ayam TV HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/499152"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/502.jpg",
      "name": " Al Haqeqa Dawalah",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4493"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/441.jpg",
      "name": " Al Hurra HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4417"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/419.jpg",
      "name": " Alaan TV 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4395"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/120/12885.png?71080",
      "name": " Al Alam News TV 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/426011"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/12885.png?71080",
      "name": " Al Alam News TV HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/759823"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/120/3117.png?7375",
      "name": " Al Mashhad TV 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/446464"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/120/3117.png?7375",
      "name": " Al Mashhad TV HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/499134"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/1187.jpg",
      "name": " Alyaum TV 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/2330"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/158.png",
      "name": " BBC World News ARABIC",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3151"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/192.png",
      "name": " BBC World News ENGLISH",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3193"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/11570.jpg?12297",
      "name": " China Global Arabic News TV",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/287734"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/404.png?69255",
      "name": " CNBC Arabic",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/283609"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/234.png",
      "name": " CNN News",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3274"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/8044.jpg",
      "name": " DW Arabic 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3407"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/397.png",
      "name": " DW English",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4361"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/202.png",
      "name": " El Sharq",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3224"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/238.png",
      "name": " Extra News",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3280"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/338.jpg",
      "name": " France 24 ARABIC",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3283"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/338.jpg",
      "name": " France 24 ARABIC 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4292"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/328.jpg",
      "name": " France 24 ENGLISH 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4369"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/422.png",
      "name": " i24 News France 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4513"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/1159.png",
      "name": " I24 News English",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/2293"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/147.jpg",
      "name": " iNews TV Arabic 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3118"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/480.jpg",
      "name": " Press TV 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4456"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/508.png",
      "name": " Rusia Today Arabic",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4497"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/508.png",
      "name": " Rusia Today English",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/459700"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/12963.png?ver=30376",
      "name": " Saudia Asharq News 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/236659"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/163.jpg",
      "name": " Sky News 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/3097"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/163.jpg",
      "name": " Sky News HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/498832"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/283.jpg?30808",
      "name": " TRT Al Arabia 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/157587"
    },
    {
      "logo": "http://icon-tmdb.me/stalker_portal/misc/logos/320/283.jpg?30808",
      "name": " TRT NEWS ARABIC",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/4244"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/9671.jpg?78641",
      "name": " Al Qahera News HD",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/497883"
    }
  ],
  "TOD ᴴᴰ": [
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD UNA 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575747"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD DOS 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575746"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD TRES 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575745"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD CUATRO 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575744"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD CINCO 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575743"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD SEIS 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575742"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD SIETE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575741"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD OCHO 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575740"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD NUEVE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575739"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD DIEZ 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575738"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TDO ONCE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575737"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD DOCE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575736"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD TRECE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575735"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD CATORCE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575734"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD QUINCE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575733"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD DIECISÉIS 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575732"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD DIECISIETE 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575731"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13544.jpg?78268",
      "name": " TOD DIECIOCHO 4K",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/575730"
    }
  ],
  "STC EXCLUSIVE ᴴᴰ": [
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "AD SPORTS PREMIUM 1",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987087"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "AD SPORTS PREMIUM 2",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987086"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "AD SPORTS 1",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987084"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "AD SPORTS 2",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987083"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "SAUDI SPORTS 1",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987078"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "SAUDI SPORTS 2",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987077"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "SAUDI SPORTS 3",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987076"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "DUBAI SPORTS",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987082"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "DUBAI SPORTS 2",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987081"
    },
  ]
};

final List<Map<String, dynamic>> matches = [
  {
    "league": "Premier League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/3411694791422.png",
    "homeTeam": "Everton",
    "awayTeam": "Tottenham",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8461690118694.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2501692467226.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 2", "Commentator": "Khalil Al Balushi"},
      {"Channel": "beIN 4K", "Commentator": "Khalil Al Balushi"}
    ]
  },
  {
    "league": "Premier League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/3411694791422.png",
    "homeTeam": "Man United",
    "awayTeam": "Brighton",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/4871690119302.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2271696710594.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sport 1", "Commentator": "Ali Muhammad Ali"},
      {"Channel": "beIN Sport 1", "Commentator": "Ali Muhammad Ali"}
    ]
  },
  {
    "league": "Premier League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/3411694791422.png",
    "homeTeam": "Nottingham",
    "awayTeam": "Southampton",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7741690119007.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/3521690370525.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports Xtra 2", "Commentator": "Ahmed Al Balushi"},
      {"Channel": "beIN Sports Xtra 2", "Commentator": "Ahmed Al Balushi"}
    ]
  },
  {
    "league": "Premier League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/3411694791422.png",
    "homeTeam": "Ipswich",
    "awayTeam": "Man City",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8291690370545.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/4481690118308.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:30 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sport 1", "Commentator": "Ali Saeed Al Kaabi"},
      {"Channel": "beIN 4K", "Commentator": "Ali Saeed Al Kaabi"}
    ]
  },
  {
    "league": "LaLiga",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/8641690196626.png",
    "homeTeam": "Celta Vigo",
    "awayTeam": "A.Bilbao",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/9611690196747.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/1061690197944.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports Xtra 3", "Commentator": "Mohamed Assadi"},
      {"Channel": "beIN Sports Xtra 3", "Commentator": "Mohamed Assadi"}
    ]
  },
  {
    "league": "LaLiga",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/8641690196626.png",
    "homeTeam": "Real Madrid",
    "awayTeam": "Las Palmas",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1871690196746.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/791690196744.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "05:15 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 3", "Commentator": "Hafeez Darraji"},
      {"Channel": "Bein Sport 3", "Commentator": "Hafeez Darraji"}
    ]
  },
  {
    "league": "LaLiga",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/8641690196626.png",
    "homeTeam": "Osasuna",
    "awayTeam": "Vallecano",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7961690196745.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/1511690196745.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "07:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 2", "Commentator": "Ahmed Al Balushi"},
      {"Channel": "Bein Sport 2", "Commentator": "Ahmed Al Balushi"}
    ]
  },
  {
    "league": "LaLiga",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/8641690196626.png",
    "homeTeam": "Valencia",
    "awayTeam": "Sociedad",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7881690196747.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/9441690196745.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "10:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 3", "Commentator": "Montaser Al-Azhari"},
      {"Channel": "Bein Sport 3", "Commentator": "Montaser Al-Azhari"}
    ]
  },
  {
    "league": "CAF Champions League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/5061696621582.png",
    "homeTeam": "Raja Club",
    "awayTeam": "Maniema",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/6421692794445.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/6691732567930.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 6", "Commentator": "Issam Chaouali"},
      {"Channel": "Arryadia TNT", "Commentator": "Muhammad Al-Adali"}
    ]
  },
  {
    "league": "CAF Champions League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/5061696621582.png",
    "homeTeam": "Sundowns",
    "awayTeam": "FAR Rabat",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/5061694715092.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/4171692205946.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 4", "Commentator": "Noffal Bachi"},
      {"Channel": "Bein Sport 4", "Commentator": "Noffal Bachi"}
    ]
  },
  {
    "league": "Serie A",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6281692568873.png",
    "homeTeam": "Fiorentina",
    "awayTeam": "Torino",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1231690283002.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/7501690283003.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "01:30 pm",
    "channelsAndCommentators": [
      {"Channel": "AD Sports Premium 1", "Commentator": "Mohammed Al Shamsi"},
      {"Channel": "STC TV App", "Commentator": "Mohammed Al Shamsi"}
    ]
  },
  {
    "league": "Serie A",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6281692568873.png",
    "homeTeam": "Cagliari",
    "awayTeam": "Lecce",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7311690283001.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/9031690283003.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "AD Sports Premium 1", "Commentator": "Ahmed kher"},
      {"Channel": "STC TV App", "Commentator": "Ahmed kher"}
    ]
  },
  {
    "league": "Serie A",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6281692568873.png",
    "homeTeam": "Parma",
    "awayTeam": "Venezia",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/4061690823331.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/771690370510.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "AD Sports Premium 2", "Commentator": "Ahmed Al-Hamid"},
      {"Channel": "STC TV App", "Commentator": "Mohammed Abu Kabdeh"}
    ]
  },
  {
    "league": "Serie A",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6281692568873.png",
    "homeTeam": "Hellas Verona",
    "awayTeam": "Lazio",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/3871690283003.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/5111690283002.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "07:00 pm",
    "channelsAndCommentators": [
      {"Channel": "AD Sports Premium 1", "Commentator": "Faisal Alhendi"},
      {"Channel": "STC TV App", "Commentator": "Faisal Alhendi"}
    ]
  },
  {
    "league": "Serie A",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6281692568873.png",
    "homeTeam": "Inter",
    "awayTeam": "Empoli",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/3101690283003.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/4281690283002.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "09:45 pm",
    "channelsAndCommentators": [
      {"Channel": "AD Sports Premium 1", "Commentator": "Bilal Allam"},
      {"Channel": "STC TV App", "Commentator": "Bilal Allam"}
    ]
  },
  {
    "league": "Bundesliga",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6171690288722.png",
    "homeTeam": "Union Berlin",
    "awayTeam": "Mainz 05",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/6521690288816.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/8131690288819.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 5", "Commentator": "Mohamed Barakat"},
      {"Channel": "Bein Sport 5", "Commentator": "Mohamed Barakat"}
    ]
  },
  {
    "league": "Bundesliga",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6171690288722.png",
    "homeTeam": "Bremen",
    "awayTeam": "Augsburg",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/9771690288817.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/7221690288817.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:30 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports Xtra 3", "Commentator": "Mohamed Assadi"},
      {"Channel": "beIN Sports Xtra 3", "Commentator": "Mohamed Assadi"}
    ]
  },
  {
    "league": "Ligue 1",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9551719862665.png",
    "homeTeam": "Saint-Etienne",
    "awayTeam": "Nantes",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/9871717020546.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/6071690287626.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports 9", "Commentator": "Basem Al-Zeer"},
      {"Channel": "beIN Sports 9", "Commentator": "Basem Al-Zeer"}
    ]
  },
  {
    "league": "Ligue 1",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9551719862665.png",
    "homeTeam": "Reims",
    "awayTeam": "Le Havre",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8361690287842.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/6941691927287.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:15 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports Xtra 2", "Commentator": "Abdallah Alghamedi"},
      {"Channel": "beIN Sports Xtra 2", "Commentator": "Abdallah Alghamedi"}
    ]
  },
  {
    "league": "Ligue 1",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9551719862665.png",
    "homeTeam": "Angers",
    "awayTeam": "Auxerre",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1121690370513.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/8671690370530.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:15 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports 9", "Commentator": "Samir Al-Yaqoubi"},
      {"Channel": "beIN Sports 9", "Commentator": "Samir Al-Yaqoubi"}
    ]
  },
  {
    "league": "Ligue 1",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9551719862665.png",
    "homeTeam": "Marseille",
    "awayTeam": "Strasbourg",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/6031690287269.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/8951690287872.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "09:45 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 4", "Commentator": "Hassan Aidaroos"},
      {"Channel": "Bein Sport 4", "Commentator": "Hassan Aidaroos"}
    ]
  },
  {
    "league": "Iraq Stars League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9731702381714.png",
    "homeTeam": "Diyala",
    "awayTeam": "Al-Karma",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7671726654821.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2331726654564.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "01:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Iraqia Syriac", "Commentator": "Hussein Al-Saadi"},
      {"Channel": "Iraqia Syriac", "Commentator": "Hussein Al-Saadi"}
    ]
  },
  {
    "league": "Iraq Stars League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9731702381714.png",
    "homeTeam": "Al Karkh",
    "awayTeam": "Erbil",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/3891695656397.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2581695657262.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "01:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Iraqia Sport", "Commentator": "Jamal Darraji"},
      {"Channel": "Iraqia Sport", "Commentator": "Jamal Darraji"}
    ]
  },
  {
    "league": "Iraq Stars League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9731702381714.png",
    "homeTeam": "Al Najaf",
    "awayTeam": "Al Minaa",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8831695656091.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/7791709127942.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Iraqia Sport", "Commentator": "Ali Enab"},
      {"Channel": "Iraqia Sport", "Commentator": "Ali Enab"}
    ]
  },
  {
    "league": "Iraq Stars League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9731702381714.png",
    "homeTeam": "Al Zawraa",
    "awayTeam": "Al Hedood",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/2961729878835.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/5221695656525.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Iraqia Sport", "Commentator": "Ali Lftah"},
      {"Channel": "Iraqia Sport", "Commentator": "Ali Lftah"}
    ]
  },
  {
    "league": "Club Friendlies",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/331690370434.png",
    "homeTeam": "Inter Miami CF",
    "awayTeam": "CF America",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/571691409672.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/7881703173149.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "05:00 am",
    "channelsAndCommentators": [
      {"Channel": "Apple TV", "Commentator": "Unknown"}
    ]
  },
  {
    "league": "Club Friendlies",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/331690370434.png",
    "homeTeam": "AGMK",
    "awayTeam": "CSKA Moscow",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/5831692012626.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/8881690370538.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "01:00 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Süper Lig",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7571723239230.png",
    "homeTeam": "Goztepe",
    "awayTeam": "Antalyaspor",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8741690370493.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/6611690127092.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "12:30 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports HD 1 TR", "Commentator": "Unknown"}
    ]
  },
  {
    "league": "Süper Lig",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7571723239230.png",
    "homeTeam": "Konyaspor",
    "awayTeam": "Kasimpasa",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8771690127634.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/8131690127512.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports HD 1 TR", "Commentator": "Unknown"}
    ]
  },
  {
    "league": "Süper Lig",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7571723239230.png",
    "homeTeam": "Eyupspor",
    "awayTeam": "Alanyaspor",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/891700669405.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/9541690127467.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports HD 2 TR", "Commentator": "Unknown"}
    ]
  },
  {
    "league": "Süper Lig",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7571723239230.png",
    "homeTeam": "Demirspor",
    "awayTeam": "Fenerbahce",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/2061690126996.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/681690127723.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports HD 1 TR", "Commentator": "Unknown"}
    ]
  },
  {
    "league": "Botola",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9671692793781.png",
    "homeTeam": "HUSA",
    "awayTeam": "MAS Fes",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/571704283672.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2161692794229.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Arryadia TV {3}", "Commentator": "Ayoub Adeeb"},
      {"Channel": "Arryadia TV {3}", "Commentator": "Ayoub Adeeb"}
    ]
  },
  {
    "league": "Botola",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9671692793781.png",
    "homeTeam": "Difaâ El Jadida",
    "awayTeam": "Wydad AC",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7531723745308.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/3131694715431.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "08:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Arryadia TV {3}", "Commentator": "Hisham Farag"},
      {"Channel": "Arryadia TV {3}", "Commentator": "Hisham Farag"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "CS Sfaxien",
    "awayTeam": "FC Bravos",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/6131692796238.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2171728321135.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 4", "Commentator": "Noffal Bachi"},
      {"Channel": "Bein Sport 4", "Commentator": "Noffal Bachi"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "Simba SC",
    "awayTeam": "CS Constantine",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/821694715302.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/1891724622719.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 6", "Commentator": "Muhammad Al-Mabrouki"},
      {"Channel": "Bein Sport 6", "Commentator": "Muhammad Al-Mabrouki"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "Al Masry",
    "awayTeam": "Black Bulls",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1521694644423.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/971732736898.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 7", "Commentator": "Ahmed Abdou"},
      {"Channel": "Bein Sport 7", "Commentator": "Ahmed Abdou"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "Zamalek SC",
    "awayTeam": "Enyimba",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7971694082496.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/5681694714987.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports 8", "Commentator": "Mohamed Fawzy"},
      {"Channel": "Time Sport", "Commentator": "Tareq Hasan"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "ASEC Mimosas",
    "awayTeam": "Orapa United",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/5251692205544.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2991728320719.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "09:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 7", "Commentator": "Basem Al-Zeer"},
      {"Channel": "Bein Sport 7", "Commentator": "Basem Al-Zeer"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "USM Alger",
    "awayTeam": "Diaraf",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/9611695834503.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/1571728320893.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "09:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 6", "Commentator": "Mohamed Barakat"},
      {"Channel": "Bein Sport 6", "Commentator": "Mohamed Barakat"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "Stade Malien",
    "awayTeam": "CD Lunda Sul",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8271696629744.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/661734213795.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "09:00 pm",
    "channelsAndCommentators": [
      {"Channel": "beIN Sports 8", "Commentator": "Muhammad Al-Mabrouki"},
      {"Channel": "beIN Sports 8", "Commentator": "Muhammad Al-Mabrouki"}
    ]
  },
  {
    "league": "CAF Confederation Cup",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1931696627235.png",
    "homeTeam": "RSB Berkane",
    "awayTeam": "Stellenbosch",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1121692794477.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2801728321045.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "09:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 5", "Commentator": "Ahmed Abdou"},
      {"Channel": "Arryadia TNT", "Commentator": "Khalil Fayed"}
    ]
  },
  {
    "league": "Liga Portugal",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7301690383928.png",
    "homeTeam": "Moreirense",
    "awayTeam": "Farense",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7031690386044.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/9131690384873.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "05:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Referee", "Commentator": "Sergio Guelho"},
      {"Channel": "Assistant referee", "Commentator": "Hugo Santos"}
    ]
  },
  {
    "league": "Liga Portugal",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7301690383928.png",
    "homeTeam": "Nacional",
    "awayTeam": "Futebol",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8491698965785.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/9461698965717.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "05:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Referee", "Commentator": "Helder Carvalho"},
      {"Channel": "Assistant referee", "Commentator": "Francisco Pereira"}
    ]
  },
  {
    "league": "Liga Portugal",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7301690383928.png",
    "homeTeam": "Estrela",
    "awayTeam": "Braga",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/3151690385137.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2631690385875.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "08:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Referee", "Commentator": "Iancu Vasilica"},
      {"Channel": "Assistant referee", "Commentator": "Carlos Martins"}
    ]
  },
  {
    "league": "Liga Portugal",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7301690383928.png",
    "homeTeam": "Gil Vicente",
    "awayTeam": "FC Porto",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7981690385058.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/4801690385949.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "10:30 pm",
    "channelsAndCommentators": [
      {"Channel": "SSC 1 HD", "Commentator": "Abdullah Al-Shehri"},
      {"Channel": "SSC 5 HD", "Commentator": "Abdullah Al-Shehri"}
    ]
  },
  {
    "league": "Tunisian Professional League 1",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/5641693174914.png",
    "homeTeam": "US Monastir",
    "awayTeam": "CA Bizertin",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/9111692796285.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2171692796264.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:00 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Tunisian Professional League 1",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/5641693174914.png",
    "homeTeam": "Stade Tunisien",
    "awayTeam": "ES Zarzis",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/861692795979.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/7511723790588.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:00 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Tunisian Professional League 1",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/5641693174914.png",
    "homeTeam": "Gafsa",
    "awayTeam": "JS Omrane",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7231692795888.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/1351723790666.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:00 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Kuwait Premier League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/6261723224041.png",
    "homeTeam": "Qadsia",
    "awayTeam": "Al-Arabi",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/451723127217.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/131723157127.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "04:45 pm",
    "channelsAndCommentators": [
      {"Channel": "atv", "Commentator": "Hani Alshehri"},
      {"Channel": "Shasha", "Commentator": "Hani Alshehri"}
    ]
  },
  {
    "league": "EFL Championship",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/4861690937574.png",
    "homeTeam": "Leeds United",
    "awayTeam": "Sheffield",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/4691690458244.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2131690370554.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Bein Sport 3", "Commentator": "Unknown"}
    ]
  },
  {
    "league": "Eredivisie",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/4431690992915.png",
    "homeTeam": "NAC Breda",
    "awayTeam": "FC Twente",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/6521690370538.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/7451690996868.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "01:15 pm",
    "channelsAndCommentators": [
      {"Channel": "Referee", "Commentator": "Rob Dieperink"},
      {"Channel": "Assistant referee", "Commentator": "Yorick Weterings"}
    ]
  },
  {
    "league": "Eredivisie",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/4431690992915.png",
    "homeTeam": "Almere City FC",
    "awayTeam": "Heracles",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/2241690996249.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2091690996504.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:30 pm",
    "channelsAndCommentators": [
      {"Channel": "Referee", "Commentator": "Ingmar Oostrom"},
      {"Channel": "Assistant referee", "Commentator": "Mark Janssen"}
    ]
  },
  {
    "league": "Eredivisie",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/4431690992915.png",
    "homeTeam": "Heerenveen",
    "awayTeam": "Ajax",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/6771725055096.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/5141690476054.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "03:30 pm",
    "channelsAndCommentators": [
      {"Channel": "StarzPlay", "Commentator": "Unknown"}
    ]
  },
  {
    "league": "Eredivisie",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/4431690992915.png",
    "homeTeam": "NEC Nijmegen",
    "awayTeam": "Fortuna Sittard",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/2531690996921.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/1881690997103.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "05:45 pm",
    "channelsAndCommentators": [
      {"Channel": "Referee", "Commentator": "Marc Nagtegaal"},
      {"Channel": "Assistant referee", "Commentator": "Richard Brondijk"}
    ]
  },
  {
    "league": "Eredivisie",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/4431690992915.png",
    "homeTeam": "Sparta Rotterdam",
    "awayTeam": "RKC Waalwijk",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/111690824096.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/6061690457395.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "09:00 pm",
    "channelsAndCommentators": [
      {"Channel": "Referee", "Commentator": "Pol van Boekel"},
      {"Channel": "Assistant referee", "Commentator": "Maarten Ketting"}
    ]
  },
  {
    "league": "Belgian Pro League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9251692797287.png",
    "homeTeam": "Kortrijk",
    "awayTeam": "Anderlecht",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/5911694963389.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/1651733919643.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Belgian Pro League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9251692797287.png",
    "homeTeam": "St.Gilloise",
    "awayTeam": "OH Leuven",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/3651690370510.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/8831690370492.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "05:00 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Belgian Pro League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9251692797287.png",
    "homeTeam": "St.Truiden",
    "awayTeam": "Standard Liege",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/6271690370550.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/4911690370549.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "07:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Belgian Pro League",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/9251692797287.png",
    "homeTeam": "Royal Antwerp",
    "awayTeam": "Westerlo",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1151690370549.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/131690370550.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "08:15 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "Proxy",
    "awayTeam": "Alexandria SC",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1761696284692.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/6721728754944.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "El Dakhleya",
    "awayTeam": "WE",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/7881694082064.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/9521696285165.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "Wadi Degla FC",
    "awayTeam": "Raya",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/2161728755640.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/6531696285484.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "Kahrbaa Alasmalia",
    "awayTeam": "El Mokawloon",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8481728755401.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2721694082551.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "El Sekka",
    "awayTeam": "Montakhab Suez",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8381696284624.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/3691696033928.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "Tanta",
    "awayTeam": "El Mansura",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8591728755099.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/8231728755782.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "La Viena FC",
    "awayTeam": "Aswan FC",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1541696284458.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/4811694082039.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "Abo Qir Semad",
    "awayTeam": "Dayrot",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8611715098753.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/4951728755572.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "El Qanah FC",
    "awayTeam": "Asyut Petroleum",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/5821715097236.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/5831736286055.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": []
  },
  {
    "league": "Egyptian Second Division",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/7581728754011.png",
    "homeTeam": "Al Tersana",
    "awayTeam": "Al-Mehalla",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/1081715096208.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/3151694619467.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "02:30 pm",
    "channelsAndCommentators": [
      {"Channel": "OnTime Sports 2", "Commentator": "Mohamed Azmy"},
      {"Channel": "OnTime Sports 2", "Commentator": "Mohamed Azmy"}
    ]
  },
  {
    "league": "Super Cup QAT-UAE",
    "leagueLogo": "https://imgs.ysscores.com/championship/48/1561733080021.png",
    "homeTeam": "Al-Wahda",
    "awayTeam": "Al-Wakrah",
    "homeTeamLogo": "https://imgs.ysscores.com/teams/64/8811690300661.png",
    "awayTeamLogo": "https://imgs.ysscores.com/teams/64/2361723214425.png",
    "matchDate": "Sunday 19-01-2025",
    "matchTime": "06:00 pm",
    "channelsAndCommentators": [
      {"Channel": "AD Sports 1", "Commentator": "Fares Awad"},
      {"Channel": "Alkass 1", "Commentator": "Khaled Al-Hadi"}
    ]
  }
];

List<MatchModel> matchesList =
    matches.map((match) => MatchModel.fromJson(match)).toList();

List<LeagueModel> leaguesList = matchesList
    .fold<Map<String, LeagueModel>>({}, (Map<String, LeagueModel> map, match) {
      if (!map.containsKey(match.league)) {
        map[match.league] = LeagueModel(
          league: match.league,
          leagueLogo: match.leagueLogo,
          matches: [],
        );
      }
      map[match.league]!.matches.add(match);
      return map;
    })
    .values
    .toList();

// Parse the data into a list of ChannelCategory objects
List<ChannelCategory> channelCategories = channels.entries.map((entry) {
  return ChannelCategory.fromMap(entry.key, entry.value);
}).toList();
final List<Map<String, String>> beINandCSSchannels = [
  {
    'name': 'beIN Sport 1',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544835',
  },
  {
    'name': 'beIN Sport 2',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544834',
  },
  {
    'name': 'beIN Sport 3',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544833',
  },
  {
    'name': 'beIN Sport 4',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544832',
  },
  {
    'name': 'beIN Sport 5',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544831',
  },
  {
    'name': 'beIN Sport 6',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544830',
  },
  {
    'name': 'beIN Sport 7',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544829',
  },
  {
    'name': 'beIN Sport 8',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544828',
  },
  {
    'name': 'beIN Sport 9',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544827',
  },
  {
    'name': 'beIN Sport XTRA 1',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544826',
  },
  {
    'name': 'beIN Sport XTRA 2',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544825',
  },
  {
    'name': 'beIN Sport XTRA 3',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544824',
  },
  {
    'name': 'SCC 1 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844321',
  },
  {
    'name': 'SCC 2 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844320',
  },
  {
    'name': 'SCC 3 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844319',
  },
  {
    'name': 'SCC 4 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844318',
  },
  {
    'name': 'SCC 5 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844317',
  },
  {
    'name': 'SS XTRAC  1 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844316',
  },
  {
    'name': 'SS XTRAC  2 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844315',
  },
  {
    'name': 'SS XTRAC  3 ᴴᴰ',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
    'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/844314',
  },
];
