// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../features/home/data/models/channel_and_commentator_model.dart';
import '../../features/home/data/models/channel_category_model.dart';
import '../../features/home/data/models/league_model.dart';
import '../../features/home/data/models/match_model.dart';
import '../localization/constants.dart';

bool isLoggedInUser = false;
bool isOnBordingView = false;

class SharedPrefKeys {
  static const String userToken = 'userToken';
}

class ImageAssets {
  static const String textTvChannellogo = 'assets/images/Tv Channel.png';
  static const String logo = 'assets/images/faisal_log_off_bg.png';
  static const String bgImage = 'assets/images/bg_image.png';
  static const String saFlags = 'assets/images/sa.png';
  static const String usFlags = 'assets/images/us.png';
}

List<String> FAISAL_Tv_Abut_us_list = [
  Our_Vision,
  Our_Services,
  About,
  Our_Mission,
  Who_We_Are,
];
List<String> FAISAL_Tv_Abut_us_desc_list = [
  Our_Vision_desc,
  Our_Services_desc,
  About_desc,
  Our_Mission_desc,
  Who_We_Are_desc,
];
final List onBoardingListDescription = [
  WatchYourFavouriteMatches.tr,
  All_international_and_local_leagues_with_one_click_of_a_button.tr,
  Premium_annual_and_monthly_subscription.tr,
];
const String beinSport1_Original_Url =
    "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/544835";
const String beinSport1_480p_url =
    "http://172.105.81.117:3000/output/beInSport1_beInSport1_480p_stream.m3u8";
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
      'name': 'SCC 1',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297366',

      ///1297366  / 301068
    },
    {
      'name': 'SCC 2',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297365',
    },
    {
      'name': 'SCC 3',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297364',
    },
    {
      'name': 'SCC 4',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297363',
    },
    {
      'name': 'SCC 5',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297362',
    },
    {
      'name': 'SSC XTRAC 1',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297361',
    },
    {
      'name': 'SS XTRAC 2',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297360',
    },
    {
      'name': 'SS XTRAC 3',
      'logo':
          'http://icon-tmdb.me/stalker_portal/misc/logos/320/8514.png?22097',
      'videoUrl': 'http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/1297359',
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
      "name": "AD Sports Premium 1",
      'videoUrl': "http://cf.iptgateway.com:80/f2fcc4fcd680/cvpjkxrnyd/987087"
    },
    {
      "logo":
          "http://icon-tmdb.me/stalker_portal/misc/logos/320/13656.png?ver=86715",
      "name": "AD Sports Premium 2",
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

// Parse the data into a list of ChannelCategory objects
List<ChannelCategory> channelCategories = channels.entries.map((entry) {
  return ChannelCategory.fromMap(entry.key, entry.value);
}).toList();

List<LeagueModel> dummyleaguesList = [
  LeagueModel(
    league: BoneMock.name,
    leagueLogo: BoneMock.name,
    matches: [
      MatchModel(
          league: BoneMock.name,
          leagueLogo: BoneMock.name,
          homeTeam: BoneMock.name,
          awayTeam: BoneMock.name,
          homeTeamLogo: BoneMock.name,
          awayTeamLogo: BoneMock.name,
          matchDate: '   ',
          matchTime: '   ',
          channelsAndCommentators: [
            ChannelAndCommentator(
              channel: BoneMock.name,
              commentator: BoneMock.name,
            )
          ]),
      MatchModel(
          league: BoneMock.name,
          leagueLogo: BoneMock.name,
          homeTeam: BoneMock.name,
          awayTeam: BoneMock.name,
          homeTeamLogo: BoneMock.name,
          awayTeamLogo: BoneMock.name,
          matchDate: '   ',
          matchTime: '   ',
          channelsAndCommentators: [
            ChannelAndCommentator(
              channel: BoneMock.name,
              commentator: BoneMock.name,
            )
          ]),
      MatchModel(
          league: BoneMock.name,
          leagueLogo: BoneMock.name,
          homeTeam: BoneMock.name,
          awayTeam: BoneMock.name,
          homeTeamLogo: BoneMock.name,
          awayTeamLogo: BoneMock.name,
          matchDate: '   ',
          matchTime: '   ',
          channelsAndCommentators: [
            ChannelAndCommentator(
              channel: BoneMock.name,
              commentator: BoneMock.name,
            )
          ]),
    ],
  ),
  LeagueModel(
    league: BoneMock.name,
    leagueLogo: BoneMock.name,
    matches: [
      MatchModel(
          league: BoneMock.name,
          leagueLogo: BoneMock.name,
          homeTeam: BoneMock.name,
          awayTeam: BoneMock.name,
          homeTeamLogo: BoneMock.name,
          awayTeamLogo: BoneMock.name,
          matchDate: '   ',
          matchTime: '   ',
          channelsAndCommentators: [
            ChannelAndCommentator(
              channel: BoneMock.name,
              commentator: BoneMock.name,
            )
          ]),
      MatchModel(
          league: BoneMock.name,
          leagueLogo: BoneMock.name,
          homeTeam: BoneMock.name,
          awayTeam: BoneMock.name,
          homeTeamLogo: BoneMock.name,
          awayTeamLogo: BoneMock.name,
          matchDate: '   ',
          matchTime: '   ',
          channelsAndCommentators: [
            ChannelAndCommentator(
              channel: BoneMock.name,
              commentator: BoneMock.name,
            )
          ]),
    ],
  ),
  LeagueModel(
    league: BoneMock.name,
    leagueLogo: BoneMock.name,
    matches: [
      MatchModel(
          league: BoneMock.name,
          leagueLogo: BoneMock.name,
          homeTeam: BoneMock.name,
          awayTeam: BoneMock.name,
          homeTeamLogo: BoneMock.name,
          awayTeamLogo: BoneMock.name,
          matchDate: '   ',
          matchTime: '   ',
          channelsAndCommentators: [
            ChannelAndCommentator(
              channel: BoneMock.name,
              commentator: BoneMock.name,
            )
          ]),
      MatchModel(
          league: BoneMock.name,
          leagueLogo: BoneMock.name,
          homeTeam: BoneMock.name,
          awayTeam: BoneMock.name,
          homeTeamLogo: BoneMock.name,
          awayTeamLogo: BoneMock.name,
          matchDate: '   ',
          matchTime: '   ',
          channelsAndCommentators: [
            ChannelAndCommentator(
              channel: BoneMock.name,
              commentator: BoneMock.name,
            )
          ]),
    ],
  ),
];
