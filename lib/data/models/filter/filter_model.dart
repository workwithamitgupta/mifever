class PreferenceFilter {
  final String country;
  final String city;
  final double distance;
  final double ageRangeStart;
  final double ageRangeEnd;
  final String interestedIn;
  final String locationText;
  final double lat;
  final double lng;

  PreferenceFilter({
    required this.country,
    required this.city,
    required this.distance,
    required this.ageRangeStart,
    required this.ageRangeEnd,
    required this.interestedIn,
    required this.locationText,
    required this.lat,
    required this.lng,
  });

  factory PreferenceFilter.fromJson(Map<String, dynamic> json) =>
      PreferenceFilter(
        country: json['country'],
        city: json['city'],
        distance: json['distance'],
        ageRangeStart: json['ageRangeStart'],
        ageRangeEnd: json['ageRangeEnd'],
        interestedIn: json['interestedIn'],
        locationText: json['locationText'],
        lat: json['lat'],
        lng: json['lng'],
      );
  Map<String, dynamic> toJson() => {
        'country': country,
        'city': city,
        'distance': distance,
        'ageRangeStart': ageRangeStart,
        'ageRangeEnd': ageRangeEnd,
        'interestedIn': interestedIn,
        'locationText': locationText,
        'lat': lat,
        'lng': lng,
      };
}
