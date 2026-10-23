class AppCategories {
  String id;
  String name;
  String image;

  AppCategories({required this.id,required this.image,required this.name});


  static List categories=[
    AppCategories(id: "general", image: "assets/categories/general.png", name: "General"),
    AppCategories(id: "business", image: "assets/categories/business.png", name: "Business"),
    AppCategories(id: "sportS", image: "assets/categories/sport.png", name: "Sports"),
    AppCategories(id: "technology", image: "assets/categories/technology.png", name: "Technology"),
    AppCategories(id: "entertainment", image: "assets/categories/entertainment.png", name: "Entertainment"),
    AppCategories(id: "health", image: "assets/categories/health.png", name: "Health"),
    AppCategories(id: "science", image: "assets/categories/science.png", name: "science"),


  ];

}