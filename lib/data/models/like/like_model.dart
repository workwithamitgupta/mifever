class LikeModel {
  final String? roomId;
  final List? userIds;
  final List? notSeenUserIds;
  final String? timestamp;
  final String? updateTimestamp;
  final bool? isMatched;
  final bool? isSuperLiked;

  LikeModel({
    this.roomId,
    this.userIds,
    this.notSeenUserIds,
    this.timestamp,
    this.updateTimestamp,
    this.isMatched,
    this.isSuperLiked,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
        roomId: json['roomId'] ?? '',
        userIds: json['userIds'] ?? [],
        notSeenUserIds: json['notSeenUserIds'] ?? [],
        timestamp: json['timestamp'],
        updateTimestamp: json['updateTimestamp'],
        isMatched: json['isMatched'] ?? false,
        isSuperLiked: json['isSuperLiked'] ?? false,
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (roomId != null) data['roomId'] = roomId;
    if (userIds != null) data['userIds'] = userIds;
    if (notSeenUserIds != null) data['notSeenUserIds'] = notSeenUserIds;
    if (timestamp != null) data['timestamp'] = timestamp;
    if (updateTimestamp != null) data['updateTimestamp'] = updateTimestamp;
    if (isMatched != null) data['isMatched'] = isMatched;
    if (isSuperLiked != null) data['isSuperLiked'] = isSuperLiked;
    return data;
  }
}
