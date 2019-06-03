enum SpecType { SCREEN, DESIGN, PERFORMANCE, FEATURES }

class Specification {
  final SpecType type;
  final String name;
  final Map<Specification, dynamic> specs;

  Specification({this.type, this.name, this.specs});

  Specification.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        name = json['name'],
        specs = json['specs'];
}
