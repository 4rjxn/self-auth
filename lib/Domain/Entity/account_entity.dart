/*
This is the Entity or model which the presentation layer directly interact 
this is the AccountEntity where all details about an Account is kept 
*/

class AccountEntity {
  final int id;
  final String secretKey;
  final String title;
  final int length;
  final int interval;
  final String issuer;
  AccountEntity({
    this.id = -1,
    required this.title,
    this.length = 6,
    this.interval = 30,
    this.issuer = '',
    required this.secretKey,
  });
}
