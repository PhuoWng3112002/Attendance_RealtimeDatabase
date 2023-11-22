class Developer {
  String name;
  String developerTypes;
  List<String> skills;

  Developer(this.name, this.developerTypes, this.skills);

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'developer': developerTypes,
      'skills': skills
          .map(
            (e) => e,
          )
          .toList(),
    };
  }
}
