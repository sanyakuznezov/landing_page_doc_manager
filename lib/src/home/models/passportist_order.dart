
class PassportistOrder {
  final String fullName;
  final String shortName;
  final String unp;
  final String legalAddress;
  final String postalAddress;
  final String iban;
  final String bankName;
  final String bankAddress;
  final String bic;
  final String phone;
  final String accountantPhone;
  final String email;
  final String accountantEmail;
  final String directorPosition;
  final String directorName;
  final String directorAuthority;
  final String contactPosition;
  final String contactName;
  final String contactPhone;
  final String deviceId;

  PassportistOrder({
    required this.fullName,
    required this.shortName,
    required this.unp,
    required this.legalAddress,
    required this.postalAddress,
    required this.iban,
    required this.bankName,
    required this.bankAddress,
    required this.bic,
    required this.phone,
    required this.accountantPhone,
    required this.email,
    required this.accountantEmail,
    required this.directorPosition,
    required this.directorName,
    required this.directorAuthority,
    required this.contactPosition,
    required this.contactName,
    required this.contactPhone,
    this.deviceId = ''
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'shortName': shortName,
      'unp': unp,
      'legalAddress': legalAddress,
      'postalAddress': postalAddress,
      'iban': iban,
      'bankName': bankName,
      'bankAddress': bankAddress,
      'bic': bic,
      'phone': phone,
      'accountantPhone': accountantPhone,
      'email': email,
      'accountantEmail': accountantEmail,
      'directorPosition': directorPosition,
      'directorName': directorName,
      'directorAuthority': directorAuthority,
      'contactPosition': contactPosition,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'deviceId':deviceId
    };
  }
}
