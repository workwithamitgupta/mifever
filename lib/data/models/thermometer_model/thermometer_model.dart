class ThermometerModel {
  final String roomId;
  final int percentageValue;

  ThermometerModel({
    required this.roomId,
    required this.percentageValue,
  });

  factory ThermometerModel.fromJson(Map<String, dynamic> json) =>
      ThermometerModel(
          roomId: json['roomId'], percentageValue: json['percentageValue']);

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'percentageValue': percentageValue,
      };
}
