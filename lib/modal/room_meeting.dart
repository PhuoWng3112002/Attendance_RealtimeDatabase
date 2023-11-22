// class Room {
//   String? key;
//   RoomData roomData;

//   Room({this.key, required this.roomData});
// }

// class RoomData {
//   String? name;
//   String? state;

//   RoomData({
//     this.name,
//     this.state,
//   });

//   RoomData.fromJson(Map<dynamic, dynamic> json) {
//     name = json["name"];
//     state = json["state"];
//   }
// }

class RoomData {
  RoomData({
    required this.name,
    required this.status,
  });

  String name;
  String status;

  Map<String, Object> toMap() {
    return {
      'name': name,
      'status': status,
    };
  }

  static RoomData? fromMap(Map value) {
    if (value == null) {
      return null;
    }

    return RoomData(
      name: value['name'],
      status: value['status'],
    );
  }

  @override
  String toString() {
    return ('name: $name, status: $status}');
  }
}
