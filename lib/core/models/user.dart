class User {
  String? name;
  String? id;
  String? email;
  String? city;
  String? country;
  List<String>? wishlist;
  String? image;

  User({
    this.name,
    this.id,
    this.email,
    this.city,
    this.country,
    this.wishlist,
    this.image,
  });

  factory User.fromFireStore(Map<String, dynamic>? data) {
    if (data == null) return User();

    return User(
      name: data["name"] as String?,
      id: data["id"] as String?,
      email: data["email"] as String?,
      city: data["city"],
      country: data["country"],
      wishlist: (data["wishlist"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      image: data["image"],
    );
  }

  Map<String, Object?> toFireStore() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "city": city,
      "country": country,
      "wishlist": wishlist ?? [],
      "image": image ?? "",
    };
  }
}
