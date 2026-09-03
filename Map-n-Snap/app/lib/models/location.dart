class Location {
  final String id;
  final String title;
  final String notes;
  final double latitude;
  final double longitude;
  final DateTime date;
  final List<String> photoUrls;
  final String placeName;

  Location({
    required this.id,
    required this.title,
    required this.notes,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.photoUrls,
    required this.placeName,
  });

  factory Location.fromMap(Map<String, dynamic> map, String docId) {
    return Location(
      id: docId,
      title: map['title'] ?? '',
      notes: map['notes'] ?? '',
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      photoUrls: List<String>.from(map['photoUrls'] ?? []),
      placeName: map['placeName'] ?? 'Unknown Location',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
      'date': date.toIso8601String(),
      'photoUrls': photoUrls,
      'placeName': placeName,
    };
  }
}
