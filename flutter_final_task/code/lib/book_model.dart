class Book {
  final String title;
  final String author;
  final String thumbnail;

  Book({required this.title, required this.author, required this.thumbnail});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? 'Unknown Title',
      author: (json['volumeInfo']['authors'] != null)
          ? json['volumeInfo']['authors'][0]
          : 'Unknown Author',
      thumbnail: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : 'https://via.placeholder.com/150',
    );
  }
}
