import 'dart:convert';

class VideoItem {
  final String name;
  final String path;
  final int duration;
  VideoItem({
    required this.name,
    required this.path,
    required this.duration,
  });

  VideoItem copyWith({
    String? name,
    String? path,
    int? duration,
  }) {
    return VideoItem(
      name: name ?? this.name,
      path: path ?? this.path,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
      'duration': duration,
    };
  }

  factory VideoItem.fromMap(Map<Object?, Object?> map) {
    return VideoItem(
      name: map['name'].toString(),
      path: map['path'].toString(),
      duration: int.parse(map['duration'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoItem.fromJson(String source) =>
      VideoItem.fromMap(json.decode(source));

  @override
  String toString() => 'VideoItem(name: $name, path: $path, duration: $duration)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoItem &&
        other.name == name &&
        other.path == path &&
        other.duration == duration;
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode ^ duration.hashCode;
}
