class CategoryModel {
  final String id;
  final String title;
  final String slug;
  final String parent;
  final String leval;
  final String description;
  final String image;
  final String status;
  final String Count;
  final String PCount;

  CategoryModel(this.id, this.title, this.slug, this.parent, this.leval,
      this.description, this.image, this.status, this.Count, this.PCount);
}
