class Article {
  final String? id;
  final String? title;
  final String? author;
  final String? category;
  final String? description;
  final int? readTime;
  final String? createdAt;

  Article({
    this.id,
    this.title,
    this.author,
    this.category,
    this.description,
    this.readTime,
    this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      category: json['category'],
      description: json['description'],
      readTime: json['read_time'],
      createdAt: json['createdAt'],
    );
  }
}
