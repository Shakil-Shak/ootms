
class Pagination {
  int totalResults;
  int totalPages;
  int currentPage;
  int limit;

  Pagination({
    this.totalResults = 0,
    this.totalPages = 0,
    this.currentPage = 0,
    this.limit = 10,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalResults: json['totalResults'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      limit: json['limit'] ?? 10,
    );
  }
}