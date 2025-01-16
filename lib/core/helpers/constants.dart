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

final List<Map<String, String>> beINandCSSchannels = [
  {
    'name': '◉: beIN Sp⚽rts 1 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544835',
  },
  {
    'name': '◉: beIN Sp⚽rts 2 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544834',
  },
  {
    'name': '◉: beIN Sp⚽rts 3 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544833',
  },
  {
    'name': '◉: beIN Sp⚽rts 4 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544832',
  },
  {
    'name': '◉: beIN Sp⚽rts 5 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544831',
  },
  {
    'name': '◉: beIN Sp⚽rts 6 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544830',
  },
  {
    'name': '◉: beIN Sp⚽rts 7 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544829',
  },
  {
    'name': '◉: beIN Sp⚽rts 8 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544828',
  },
  {
    'name': '◉: beIN Sp⚽rts 9 HD',
    'logo': 'http://icon-tmdb.me/stalker_portal/misc/logos/320/12782.png?95032',
    'videoUrl':
        'http://plots95882.cdngold.me:80/5f64535c9e59/75309ce8fa/544827',
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
];
