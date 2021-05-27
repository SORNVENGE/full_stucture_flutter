class CheckOut {
  
  String firstName;
  String middleName;
  String lastName;

  String country;
  String city;
  String streetName;
  String houseNumber;
  String postcode;

  CheckOut(
      {this.firstName,
      this.middleName,
      this.lastName,

      this.country,
      this.city,
      this.streetName,
      this.houseNumber,
      this.postcode});

  factory CheckOut.fromMap(Map<String, dynamic> json) {
    return CheckOut(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],

      country: json['country'],
      city: json['city'],
      streetName: json['streetName'],
      houseNumber: json['houseNumber'],
      postcode: json['postcode'],
    );
  }
}
