class Recipes {
    Recipes({
        required this.id,
        required this.title,
    });

    int id;
    String title;

    factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}