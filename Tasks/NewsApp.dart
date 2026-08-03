import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "dart:convert";
import "package:http/http.dart" as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "News app", home: NewsHome());
  }
}

class Article {
  final String title;
  final String? description;
  final String? urlToImage;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json["title"] ?? "No available",
      description: json["description"],
      urlToImage: json["urlToImage"],
    );
  }

  Article({required this.title, this.description, this.urlToImage});
}

class NewsHome extends StatefulWidget {
  @override
  State<NewsHome> createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  late Future<List<Article>> futureArticles;

  final String apiUrl =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=1ca6ee05d5964af9a96287b3b1ce257d";

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles();
  }

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> articlesJson = jsonResponse["articles"];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load news. try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Latest news")),
      body: FutureBuilder<List<Article>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(padding: EdgeInsets.all(10), child: Text("Error")),
            );
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (article.urlToImage != null &&
                            article.urlToImage!.isNotEmpty)
                          Image.network(
                            article.urlToImage!,
                            height: 180,
                            width: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, StackTrace) {
                              return SizedBox.shrink();
                            },
                          ),
                        Text(
                          article.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          article.description ?? "No available detail",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
