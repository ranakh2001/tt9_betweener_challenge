// To parse this JSON data, do
//
//     final searchUser = searchUserFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

SearchUser searchUserFromJson(String str) => SearchUser.fromJson(json.decode(str));

String searchUserToJson(SearchUser data) => json.encode(data.toJson());

class SearchUser {
    int? id;
    String? name;
    String? email;
    dynamic emailVerifiedAt;
    String? createdAt;
    String? updatedAt;
    int? isActive;
    dynamic country;
    dynamic ip;
    double? long;
    double? lat;
    List<dynamic>? links;

    SearchUser({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.country,
        this.ip,
        this.long,
        this.lat,
        this.links,
    });

    factory SearchUser.fromJson(Map<String, dynamic> json) => SearchUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isActive: json["isActive"],
        country: json["country"],
        ip: json["ip"],
        long: json["long"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        links: json["links"] == null ? [] : List<dynamic>.from(json["links"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "isActive": isActive,
        "country": country,
        "ip": ip,
        "long": long,
        "lat": lat,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
    };
}
