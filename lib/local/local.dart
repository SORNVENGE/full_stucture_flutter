import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/state/languages.dart';

class AppLocalizations {
  static Languages of(BuildContext context) {
    return Provider.of<Languages>(context,listen: false);
  }
}