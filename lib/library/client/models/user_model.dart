import 'package:g_json/g_json.dart';

class UserModel {
  final int isPolitical;
  final String modifiedUserName;
  final String lastName;
  final String firstName2;
  final String countryName2;
  final String modifiedDatetime;
  final String createdUserName;
  final int countryCode;
  final int taxExemption;
  final String sexName;
  final String statusName;
  final String lastName2;
  final int modifiedBy;
  final String statusName2;
  final String registerCode;
  final String email;
  final int custSegCode;
  final int companyCode;
  final int registerMaskCode;
  final int isBl;
  final int isCompanyCustomer;
  final String mobile;
  final String fullName;
  final String fullName2;
  final String custCode;
  final String birthDate;
  final int isVatPayer;
  final String firstName;
  final int sexCode;
  final String phone;
  final int createdBy;
  final String lastRenewDate;
  final String shortName2;
  final String createdDatetime;
  final String countryName;
  final String sexName2;
  final String shortName;
  final int status;
  final bool hasPincode;
  final String bankAccount;
  final String bankName;

  bool get hasBankAccount => bankAccount.isNotEmpty;

  UserModel.fromJson(JSON json)
      : isPolitical = json['isPolitical'].integerValue,
        lastName = json['lastName'].stringValue,
        firstName2 = json['firstName2'].stringValue,
        countryName2 = json['countryName2'].stringValue,
        modifiedDatetime = json['modifiedDatetime'].stringValue,
        modifiedUserName = json['modifiedUserName'].stringValue,
        createdUserName = json['createdUserName'].stringValue,
        countryCode = json['countryCode'].integerValue,
        taxExemption = json['taxExemption'].integerValue,
        sexName = json['sexName'].stringValue,
        statusName = json['statusName'].stringValue,
        lastName2 = json['lastName2'].stringValue,
        modifiedBy = json['modifiedBy'].integerValue,
        statusName2 = json['statusName2'].stringValue,
        registerCode = json['registerCode'].stringValue,
        email = json['email'].stringValue,
        custSegCode = json['custSegCode'].integerValue,
        companyCode = json['companyCode'].integerValue,
        registerMaskCode = json['registerMaskCode'].integerValue,
        isBl = json['isBl'].integerValue,
        isCompanyCustomer = json['isCompanyCustomer'].integerValue,
        mobile = json['mobile'].stringValue,
        fullName = json['fullName'].stringValue,
        fullName2 = json['fullName2'].stringValue,
        custCode = json['custCode'].stringValue,
        birthDate = json['birthDate'].stringValue,
        isVatPayer = json['isVatPayer'].integerValue,
        firstName = json['firstName'].stringValue,
        sexCode = json['sexCode'].integerValue,
        phone = json['phone'].stringValue,
        createdBy = json['createdBy'].integerValue,
        lastRenewDate = json['lastRenewDate'].stringValue,
        shortName2 = json['shortName2'].stringValue,
        createdDatetime = json['createdDatetime'].stringValue,
        countryName = json['countryName'].stringValue,
        sexName2 = json['sexName2'].stringValue,
        shortName = json['shortName'].stringValue,
        status = json['status'].integerValue,
        hasPincode = json['has_pincode'].booleanValue,
        bankAccount = json['bank_account'].stringValue,
        bankName = json['bank_name'].stringValue;

  Map<String, dynamic> toMap() {
    return {
      'isPolitical': isPolitical,
      'lastName': lastName,
      'firstName2': firstName2,
      'countryName2': countryName2,
      'modifiedDatetime': modifiedDatetime,
      'modifiedUserName': modifiedUserName,
      'createdUserName': createdUserName,
      'countryCode': countryCode,
      'taxExemption': taxExemption,
      'sexName': sexName,
      'statusName': statusName,
      'lastName2': lastName2,
      'modifiedBy': modifiedBy,
      'statusName2': statusName2,
      'registerCode': registerCode,
      'email': email,
      'custSegCode': custSegCode,
      'companyCode': companyCode,
      'registerMaskCode': registerMaskCode,
      'isBl': isBl,
      'isCompanyCustomer': isCompanyCustomer,
      'mobile': mobile,
      'fullName': fullName,
      'fullName2': fullName2,
      'custCode': custCode,
      'birthDate': birthDate,
      'isVatPayer': isVatPayer,
      'firstName': firstName,
      'sexCode': sexCode,
      'phone': phone,
      'createdBy': createdBy,
      'lastRenewDate': lastRenewDate,
      'shortName2': shortName2,
      'createdDatetime': createdDatetime,
      'countryName': countryName,
      'sexName2': sexName2,
      'shortName': shortName,
      'status': status,
      'has_pincode': hasPincode,
      'bank_account': bankAccount,
      'bank_name': bankName,
    };
  }
}
