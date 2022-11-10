import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../util/app_color_util.dart';
import '../../util/image_path_util.dart';

class SignUpDetailsConfirmationScreen extends StatelessWidget {
  SignUpDetailsConfirmationScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorUtil.appBlueColor,
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text('新規会員登録',
                style: TextStyle(color: AppColorUtil.appBlueDarkColor))),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Column(children: [
                  Text('会員情報入力'),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
                      child: Image.asset(ImagePathUtil.stepFivePath)),
                  const SizedBox(height: 20),
                  FormBuilder(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Text('ニックネーム'),
                                    Container(
                                        color: AppColorUtil.appGreenColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text('必須'))
                                  ],
                                )),]))
                ])
              ]),
        ));
  }
}
