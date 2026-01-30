class Gym {
  final String id;
  final String name;
  final String ownerUserId;

  Gym({required this.id, required this.name, required this.ownerUserId});

  factory Gym.fromMap(String id, Map<String, dynamic> map) {
    return Gym(
      id: id,
      name: (map['name'] ?? '') as String,
      ownerUserId: (map['ownerUserId'] ?? '') as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ownerUserId': ownerUserId,
      'createdAt': DateTime.now().toUtc(),
    };
  }
}
