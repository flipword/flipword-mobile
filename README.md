![GitHaction badge](https://github.com/acroquelois/flip-word/actions/workflows/.github/workflows/dart.yml/badge.svg)

# FlipWord
<a href='https://play.google.com/store/apps/details?id=com.flutter_flip_card&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a>

## Command

Generate app icon:
$> flutter packages pub run flutter_launcher_icons:main

Generate store file:
$> flutter packages pub run build_runner build --delete-conflicting-outputs

Build apk:
$> flutter build apk --release --dart-define=ENV=prod

## Naming convention 

* Branch name: kebab-case
* Commit label: gitmoji => https://gitmoji.carloscuesta.me/
