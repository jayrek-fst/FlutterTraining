import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/app_color_util.dart';
import '../../util/image_path_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../util/text_style_util.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class SignUpDetailsScreen extends StatelessWidget {
  SignUpDetailsScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

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
                      child: Image.asset(ImagePathUtil.stepFourPath)),
                  const SizedBox(height: 20),
                  FormBuilder(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _nickNameWidget(),
                            _fullNameWidget(),
                            _kanaFullNameWidget(),

                            ///birthdate here

                            _genderWidget(),
                            const SizedBox(height: 20),
                            _addressNote(),
                            _postalCodeWidget(),
                            const SizedBox(height: 20),
                            _prefectureWidget(),
                            _cityWidget(),
                            _addressNumberWidget(),
                            _addressStructureWidget(),
                            _phoneNumberWidget(),
                            _linksWidget(),
                            _buttonWidget(context)
                          ]))
                ])
              ]),
        ));
  }

  _nickNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              const Text('ニックネーム'),
              Container(
                  color: AppColorUtil.appGreenColor,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text('必須'))
            ])),
        TextFormFieldWidget(
            name: StringConstants.nickName,
            textInputType: TextInputType.text,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Nickname is required')
            ])),
        Text('※chatなどのコメントにはこちらが表示されます。'),
      ],
    );
  }

  _fullNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text('氏名'),
                Container(
                    color: AppColorUtil.appGreenColor,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('必須'))
              ],
            )),
        Row(
          children: [
            Flexible(
              child: TextFormFieldWidget(
                  name: StringConstants.lastName,
                  textInputType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Lastname is required')
                  ])),
            ),
            SizedBox(width: 20),
            Flexible(
              child: TextFormFieldWidget(
                  name: StringConstants.firstName,
                  textInputType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'First is required')
                  ])),
            ),
          ],
        ),
      ],
    );
  }

  _kanaFullNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 10), child: Text('フリガナ')),
        Row(
          children: const [
            Flexible(
              child: TextFormFieldWidget(
                  name: StringConstants.kanaLastName,
                  textInputType: TextInputType.text),
            ),
            SizedBox(width: 20),
            Flexible(
              child: TextFormFieldWidget(
                  name: StringConstants.kanaFirstName,
                  textInputType: TextInputType.text),
            ),
          ],
        ),
      ],
    );
  }

  _genderWidget() {
    return FormBuilderSegmentedControl<String>(
        padding: const EdgeInsets.symmetric(vertical: 5),
        initialValue: StringConstants.genderList.asMap()[2],
        name: StringConstants.gender,
        selectedColor: AppColorUtil.appBlueDarkColor,
        options: StringConstants.genderList
            .map((gender) =>
                FormBuilderFieldOption(value: gender, child: Text(gender)))
            .toList(),
        decoration: const InputDecoration(
          border: InputBorder.none,
          filled: false,
        ));
  }

  _addressNote() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Text(
          '※プレゼント企画等を行う際に住所が必要となりますので、参加希望の方は必ず住所入力をお願いいたします。（特典の配送は日本国内のみになります。）'),
    );
  }

  _postalCodeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('郵便番号')),
        TextFormFieldWidget(
            name: StringConstants.postalCode,
            textInputType: TextInputType.number),
      ],
    );
  }

  _prefectureWidget() {
    return FormBuilderDropdown(
      name: StringConstants.prefecture,
      isExpanded: false,
      items: StringConstants.prefectureList
          .map((prefecture) => DropdownMenuItem(
                value: prefecture,
                child: Text(prefecture),
              ))
          .toList(),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: StringConstants.prefectureList.asMap()[0],
      ),
    );
  }

  _cityWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('市区町村')),
        TextFormFieldWidget(
            name: StringConstants.city,
            textInputType: TextInputType.streetAddress),
      ],
    );
  }

  _addressNumberWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('番地')),
        TextFormFieldWidget(
            name: StringConstants.addressNumber,
            textInputType: TextInputType.streetAddress),
      ],
    );
  }

  _addressStructureWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('建物名・部屋番号')),
        TextFormFieldWidget(
            name: StringConstants.addressStructure,
            textInputType: TextInputType.streetAddress),
      ],
    );
  }

  _phoneNumberWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('電話番号')),
        TextFormFieldWidget(
            name: StringConstants.phoneNumber,
            textInputType: TextInputType.phone),
      ],
    );
  }

  _linksWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text('規約について'),
                  Container(
                      color: AppColorUtil.appGreenColor,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text('必須'))
                ],
              )),
          TextButton(
              onPressed: () {},
              child: Text('・サービス利用規約', style: underlineTextStyle)),
          TextButton(
              onPressed: () {},
              child: Text('・個人情報保護方針', style: underlineTextStyle)),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.center,
          child: SizedBox(
              width: 150,
              child: FormBuilderCheckbox(
                  name: StringConstants.agreeCheckBox,
                  initialValue: false,
                  title: Text('同意します'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.equal(true,
                        errorText:
                            'You must accept terms and conditions to continue')
                  ])))),
      ElevatedButtonWidget(
          label: '確認',
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              FocusScope.of(context).unfocus();
              Navigator.of(context)
                  .pushNamed(RouteUtil.signUpDetailsConfirmation);
            }
          })
    ]);
  }
}
