class UserAddress {
  String? street;
  String? district;
  String? city;
  String? province;
  String? country;
  double? latitude;
  double? longitude;

  UserAddress(
      {this.street,
      this.district,
      this.city,
      this.province,
      this.country,
      required this.latitude,
      required this.longitude});

  UserAddress.fromMap(Map<String, dynamic> map) {
    street = map['street'] as String;
    district = map['district'] as String;
    city = map['city'] as String;
    province = map['province'] as String;
    country = map['country'] as String;
    latitude = map['latitude'] as double;
    longitude = map['longitude'] as double;
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'district': district,
      'city': city,
      'province': province,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }



  @override
  String toString() {
    return 'UserAddress{street: $street, district: $district, city: $city, province: $province, country: $country, latitude: $latitude, longitude: $longitude}';
  }
}
