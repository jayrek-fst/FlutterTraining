import 'package:flutter/material.dart';

import '../../util/string_constants.dart';
import '../../widget/common_widget.dart';

class StationScreen extends StatelessWidget {
  const StationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: StringConstants.park, onTap: null),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.warning_amber_outlined,
                      size: 50, color: Colors.yellow),
                  SizedBox(height: 10),
                  Text('STATION is Under Construction!')
                ])));
  }
}
