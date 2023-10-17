class Resource {
  int id;
  String name;
  int year;
  String color;
  String pantoneValue;

  Resource(this.id, this.name, this.year, this.color, this.pantoneValue);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Resource &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          year == other.year &&
          color == other.color &&
          pantoneValue == other.pantoneValue;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      year.hashCode ^
      color.hashCode ^
      pantoneValue.hashCode;

  @override
  String toString() {
    return 'Resource{id: $id, name: $name, year: $year, color: $color, pantoneValue: $pantoneValue}';
  }
}