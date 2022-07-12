
// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
    SearchResponse({
        this.type,
        this.query,
         this.features,
         this.attribution,
    });

    String? type;
    List<String>? query;
    List<Feature>? features;
    String? attribution;

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query!.map((x) => x)),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.relevance,
        required this.properties,
        required this.textEs,
        required this.placeNameEs,
        required this.text,
        required this.placeName,
        required this.bbox,
        required this.center,
        required this.geometry,
        required this.context,
        required this.matchingText,
        required this.matchingPlaceName,
        required this.languageEs,
        required this.language,
    });

    String id;
    String type;
    List<String> placeType;
    int relevance;
    Properties properties;
    String textEs;
    String placeNameEs;
    String text;
    String placeName;
    List<double>? bbox;
    List<double> center;
    Geometry geometry;
    List<Context> context;
    String matchingText;
    String matchingPlaceName;
    Language? languageEs;
    Language? language;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null ? null : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        // ignore: prefer_if_null_operators
        matchingText: json["matching_text"] == null ? null : json["matching_text"],
        // ignore: prefer_if_null_operators
        matchingPlaceName: json["matching_place_name"] == null ? null : json["matching_place_name"],
        languageEs: json["language_es"] == null ? null : languageValues.map[json["language_es"]],
        language: json["language"] == null ? null : languageValues.map[json["language"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "bbox": bbox == null ? null : List<dynamic>.from(bbox!.map((x) => x)),
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
        // ignore: unnecessary_null_comparison, prefer_if_null_operators
        "matching_text": matchingText == null ? null : matchingText,
        // ignore: prefer_if_null_operators, unnecessary_null_comparison
        "matching_place_name": matchingPlaceName == null ? null : matchingPlaceName,
        "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
        "language": language == null ? null : languageValues.reverse[language],
    };
}

class Context {
    Context({
        required this.id,
        required this.wikidata,
        required this.textEs,
        required this.languageEs,
        required this.text,
        required this.language,
        required this.shortCode,
    });

    String id;
    String wikidata;
    String textEs;
    Language? languageEs;
    String text;
    Language? language;
    String shortCode;

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        // ignore: prefer_if_null_operators
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        textEs: json["text_es"],
        languageEs: json["language_es"] == null ? null : languageValues.map[json["language_es"]],
        text: json["text"],
        language: json["language"] == null ? null : languageValues.map[json["language"]],
        // ignore: prefer_if_null_operators
        shortCode: json["short_code"] == null ? null : json["short_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // ignore: unnecessary_null_comparison, prefer_if_null_operators
        "wikidata": wikidata == null ? null : wikidata,
        "text_es": textEs,
        "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
        "text": text,
        "language": language == null ? null : languageValues.reverse[language],
        // ignore: unnecessary_null_comparison, prefer_if_null_operators
        "short_code": shortCode == null ? null : shortCode,
    };
}

// ignore: constant_identifier_names
enum Language { ES }

final languageValues = EnumValues({
    "es": Language.ES
});

class Geometry {
    Geometry({
        required this.type,
        required this.coordinates,
    });

    String type;
    List<double> coordinates;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Properties {
    Properties({
        required this.foursquare,
        required this.landmark,
        required this.category,
        required this.address,
        required this.wikidata,
    });

    String foursquare;
    bool landmark;
    String category;
    String address;
    String wikidata;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        // ignore: prefer_if_null_operators
        foursquare: json["foursquare"] == null ? null : json["foursquare"],
        // ignore: prefer_if_null_operators
        landmark: json["landmark"] == null ? null : json["landmark"],
        // ignore: prefer_if_null_operators
        category: json["category"] == null ? null : json["category"],
        // ignore: prefer_if_null_operators
        address: json["address"] == null ? null : json["address"],
        // ignore: prefer_if_null_operators
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
    );

    Map<String, dynamic> toJson() => {
        // ignore: prefer_if_null_operators
        "foursquare": foursquare == null ? null : foursquare,
        // ignore: unnecessary_null_comparison
        "landmark": landmark == null ? null : landmark,
        "category": category == null ? null : category,
        "address": address == null ? null : address,
        "wikidata": wikidata == null ? null : wikidata,
    };
}

class EnumValues<T> {
    late Map<String, T> map;
    late Map<T, String> reverseMap;
    
    EnumValues(Map<String, Language> map);

   

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
