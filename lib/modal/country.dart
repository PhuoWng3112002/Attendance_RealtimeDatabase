class Country {
  String name;
  String developerTypes;
  String date;
  List<String> skills;

  Country(this.name, this.developerTypes, this.skills, this.date);

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'developer': developerTypes,
      'date': date,
      'skills': skills
          .map(
            (e) => e,
          )
          .toList(),
    };
  }
}
