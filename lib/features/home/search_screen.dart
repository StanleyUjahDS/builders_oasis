import 'package:flutter/material.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<String> allItems = [
    "Math",
    "Science",
    "Flutter",
    "Dart",
    "Physics",
    "Chemistry",
    "AI",
    "Machine Learning",
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void _search(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) =>
          item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
      
              //  HERO SEARCH INPUT (matches Home)
              Hero(
                tag: "search_bar",
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),

                      border: Border(
                        top: BorderSide(
                          color: AppColors.red200.withValues(alpha: 0.6),
                          width: 1.2,
                        ),
                        bottom: BorderSide(
                          color: AppColors.red200.withValues(alpha: 0.6),
                          width: 1.2,
                        ),
                        left: BorderSide.none,
                        right: BorderSide.none,
                      ),
                    ),

                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      onChanged: _search,

                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search topics...",
                        filled: true,
                        fillColor: Colors.transparent,

                        border: InputBorder.none, // 🔥 IMPORTANT
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
      
              const SizedBox(height: 16),
      
              //  RESULTS
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(filteredItems[index]),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}