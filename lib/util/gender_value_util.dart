import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderValueUtil {
  List<String> genderList(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    return [
      appLocalizations.raw_common_gender_female,
      appLocalizations.raw_common_gender_male,
      appLocalizations.raw_common_gender_other
    ];
  }
}
