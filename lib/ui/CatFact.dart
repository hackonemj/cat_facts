import 'dart:convert';

CatFacts catFactsFromJson(String str) => CatFacts.fromJson(json.decode(str));

String catFactsToJson(CatFacts data) => json.encode(data.toJson());

class CatFacts {
  List<GetFact> lista;

  CatFacts({
    this.lista,
  });

  factory CatFacts.fromJson(Map<String, dynamic> json) => CatFacts(
        lista: List<GetFact>.from(json["all"].map((x) => GetFact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all": List<dynamic>.from(lista.map((x) => x.toJson())),
      };
}

class GetFact {
  String id;
  String text;
  Type type;

  GetFact({
    this.id,
    this.text,
    this.type,
  });

  factory GetFact.fromJson(Map<String, dynamic> json) => GetFact(
        id: json["_id"],
        text: json["text"],
        type: typeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "type": typeValues.reverse[type],
      };
}

enum Type { CAT }

final typeValues = EnumValues({"cat": Type.CAT});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
