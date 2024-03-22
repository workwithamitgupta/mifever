import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mifever/data/models/user/about_me_model.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? nameAudio;
  final String? gender;
  final String? dob;
  final List<dynamic>? interestList;
  final String? country;
  final String? city;
  final List<dynamic>? availableCountry;
  final List<dynamic>? availableCity;
  final String? whatDoYouWant;
  final List<dynamic>? wayAlbum;
  final List<dynamic>? lifeAlbum;
  final String? token;
  final bool? isProfileComplete;
  final AboutMe? aboutMe;
  final GeoPoint? location;
  final Timestamp? lasOnline;
  final String? profileImage;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.nameAudio,
    this.gender,
    this.dob,
    this.interestList,
    this.country,
    this.city,
    this.availableCountry,
    this.availableCity,
    this.whatDoYouWant,
    this.wayAlbum,
    this.lifeAlbum,
    this.isProfileComplete,
    this.token,
    this.aboutMe,
    this.location,
    this.lasOnline,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      nameAudio: json['nameAudio'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      interestList: json['interestList'] ?? [],
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      availableCountry: json['availableCountry'] ?? [],
      availableCity: json['availableCity'] ?? [],
      whatDoYouWant: json['whatDoYouWant'] ?? '',
      wayAlbum: json['wayAlbum'] ?? [],
      lifeAlbum: json['lifeAlbum'] ?? [],
      token: json['token'] ?? '',
      isProfileComplete: json['isProfileComplete'] ?? false,
      aboutMe:
          json['aboutMe'] != null ? AboutMe.fromJson(json['aboutMe']) : null,
      location: json['location'] ?? GeoPoint(0.0, 0.0),
      lasOnline: json['lasOnline'] ?? Timestamp(0, 0),
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    // Create a map to store non-null fields
    Map<String, dynamic> jsonMap = {};

    // Add non-null fields to the map
    if (id != null) jsonMap['id'] = id;
    if (email != null) jsonMap['email'] = email;
    if (name != null) jsonMap['name'] = name;
    if (nameAudio != null) jsonMap['nameAudio'] = nameAudio;
    if (gender != null) jsonMap['gender'] = gender;
    if (dob != null) jsonMap['dob'] = dob;
    if (interestList != null) jsonMap['interestList'] = interestList;
    if (country != null) jsonMap['country'] = country;
    if (city != null) jsonMap['city'] = city;
    if (availableCountry != null)
      jsonMap['availableCountry'] = availableCountry;
    if (availableCity != null) jsonMap['availableCity'] = availableCity;
    if (whatDoYouWant != null) jsonMap['whatDoYouWant'] = whatDoYouWant;
    if (wayAlbum != null) jsonMap['wayAlbum'] = wayAlbum;
    if (lifeAlbum != null) jsonMap['lifeAlbum'] = lifeAlbum;
    if (token != null) jsonMap['token'] = token;
    if (isProfileComplete != null)
      jsonMap['isProfileComplete'] = isProfileComplete;
    if (aboutMe != null) jsonMap['aboutMe'] = aboutMe?.toJson();
    if (location != null) jsonMap['location'] = location;
    if (lasOnline != null) jsonMap['lasOnline'] = lasOnline;
    if (profileImage != null) jsonMap['profileImage'] = profileImage;

    return jsonMap;
  }
}
