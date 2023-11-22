class WorkSheet {
  String? key;
  WorkSheetData workSheetData;

  WorkSheet({this.key, required this.workSheetData});
}

class WorkSheetData {
  String? checkIn;
  String? checkOut;
  WorkSheetData({
    this.checkIn,
    this.checkOut,
  });
  WorkSheetData.fromJson(Map<dynamic, dynamic> json) {
    checkIn = json["checkIn"];
    checkOut = json["checkOut"];
  }
}
