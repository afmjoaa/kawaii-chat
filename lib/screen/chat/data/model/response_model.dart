part of 'models.dart';

@JsonSerializable()
class ResponseModel extends BaseModel<ResponseModel> {
  final int runningIndex;
  final List<Message> messages;

  ResponseModel({
    required this.runningIndex,
    required this.messages,
    required String id,
    DateTime? timestamp,
  }) : super(id, timestamp ?? DateTime.now());

  ResponseModel copyWith({
    String? id,
    int? runningIndex,
    List<Message>? messages,
    DateTime? timestamp,
  }) =>
      ResponseModel(
        id: id ?? this.id,
        runningIndex: runningIndex ?? this.runningIndex,
        messages: messages ?? this.messages,
        timestamp: timestamp ?? this.timestamp,
      );

  @override
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  ResponseEntity toEntity() {
    return ResponseEntity(
      runningIndex: runningIndex,
      messages: messages,
      id: id,
    );
  }

  ResponseModel.fromEntity(ResponseEntity entity):
    this(
      runningIndex: entity.runningIndex,
      messages: entity.messages,
      id: entity.id,
    );
}
