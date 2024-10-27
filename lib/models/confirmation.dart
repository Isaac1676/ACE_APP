class Confirmation {
  final int? id;
  final int userId;
  final DateTime date;

  Confirmation({
    this.id,
    required this.userId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(), // Convert to ISO format
    };
  }

  factory Confirmation.fromMap(Map<String, dynamic> map) {
    return Confirmation(
      id: map['id'],
      userId: map['userId'],
      date: DateTime.parse(map['date']),
    );
  }
}