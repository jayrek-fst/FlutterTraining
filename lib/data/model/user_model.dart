import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? sex;
  String? mail;
  String? icon;
  FullName? fullName;
  KanaFullName? kanaFullName;
  String? phoneNumber;
  String? platform;
  String? role;
  Address? address;
  BirthDate? birthDate;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  Subscription? subscription;

  UserModel(
      {this.uid,
      this.sex,
      this.mail,
      this.icon = '',
      this.fullName,
      this.kanaFullName,
      this.phoneNumber,
      this.platform = 'android',
      this.role = '',
      this.address,
      this.birthDate,
      this.createdAt,
      this.updatedAt,
      this.subscription});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    sex = json['sex'];
    mail = json['mail'];
    icon = json['icon'];
    fullName =
        json['fullName'] != null ? FullName.fromJson(json['fullName']) : null;
    kanaFullName = json['kanaFullName'] != null
        ? KanaFullName.fromJson(json['kanaFullName'])
        : null;
    phoneNumber = json['phoneNumber'];
    platform = json['platform'];
    role = json['role'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    birthDate = json['birthDate'] != null
        ? BirthDate.fromJson(json['birthDate'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      sex: data?['sex'],
      mail: data?['mail'],
      icon: data?['icon'],
      phoneNumber: data?['phoneNumber'],
      platform: data?['platform'],
      role: data?['role'],
      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (sex != null) "sex": sex,
      if (mail != null) "mail": mail,
      if (icon != null) "icon": icon,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (platform != null) "platform": platform,
      if (role != null) "role": role,
      if (createdAt != null) "role": createdAt,
      if (updatedAt != null) "role": updatedAt,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['sex'] = sex;
    data['mail'] = mail;
    data['icon'] = icon;
    if (fullName != null) {
      data['fullName'] = fullName!.toJson();
    }
    if (kanaFullName != null) {
      data['kanaFullName'] = kanaFullName!.toJson();
    }
    data['phoneNumber'] = phoneNumber;
    data['platform'] = platform;
    data['role'] = role;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (birthDate != null) {
      data['birthDate'] = birthDate!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    return data;
  }
}

class FullName {
  String? nickName;
  String? firstName;
  String? lastName;

  FullName({this.nickName, this.firstName, this.lastName});

  FullName.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickName'] = nickName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}

class KanaFullName {
  String? firstNameKana;
  String? lastNameKana;

  KanaFullName({this.firstNameKana = '', this.lastNameKana = ''});

  KanaFullName.fromJson(Map<String, dynamic> json) {
    firstNameKana = json['firstNameKana'];
    lastNameKana = json['lastNameKana'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstNameKana'] = firstNameKana;
    data['lastNameKana'] = lastNameKana;
    return data;
  }
}

class Address {
  String? postalCode;
  String? addressPrefecture;
  String? addressCity;
  String? addressStructure;
  String? addressNumber;

  Address(
      {this.postalCode = '',
      this.addressPrefecture = '',
      this.addressCity = '',
      this.addressStructure = '',
      this.addressNumber = ''});

  Address.fromJson(Map<String, dynamic> json) {
    postalCode = json['postalCode'];
    addressPrefecture = json['addressPrefecture'];
    addressCity = json['addressCity'];
    addressStructure = json['addressStructure'];
    addressNumber = json['addressNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postalCode'] = postalCode;
    data['addressPrefecture'] = addressPrefecture;
    data['addressCity'] = addressCity;
    data['addressStructure'] = addressStructure;
    data['addressNumber'] = addressNumber;
    return data;
  }
}

class BirthDate {
  int? birthYear;
  int? birthMonth;
  int? birthDay;

  BirthDate({this.birthYear = -1, this.birthMonth = -1, this.birthDay = -1});

  BirthDate.fromJson(Map<String, dynamic> json) {
    birthYear = json['birthYear'];
    birthMonth = json['birthMonth'];
    birthDay = json['birthDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birthYear'] = birthYear;
    data['birthMonth'] = birthMonth;
    data['birthDay'] = birthDay;
    return data;
  }
}

class Subscription {
  String? firstBillingDate;
  String? membersNo;
  bool? subscription;
  bool? subscriptionPaused;
  String? subscriptionStartDate;
  String? subscriptionUpdateDate;
  bool? withdraw;

  Subscription(
      {this.firstBillingDate = '',
      this.membersNo = '',
      this.subscription = false,
      this.subscriptionPaused = false,
      this.subscriptionStartDate = '',
      this.subscriptionUpdateDate = '',
      this.withdraw = false});

  Subscription.fromJson(Map<String, dynamic> json) {
    firstBillingDate = json['firstBillingDate'];
    membersNo = json['membersNo'];
    subscription = json['subscription'];
    subscriptionPaused = json['subscriptionPaused'];
    subscriptionStartDate = json['subscriptionStartDate'];
    subscriptionUpdateDate = json['subscriptionUpdateDate'];
    withdraw = json['withdraw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstBillingDate'] = firstBillingDate;
    data['membersNo'] = membersNo;
    data['subscription'] = subscription;
    data['subscriptionPaused'] = subscriptionPaused;
    data['subscriptionStartDate'] = subscriptionStartDate;
    data['subscriptionUpdateDate'] = subscriptionUpdateDate;
    data['withdraw'] = withdraw;
    return data;
  }
}
