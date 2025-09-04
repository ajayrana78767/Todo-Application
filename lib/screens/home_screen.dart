import 'package:flutter/material.dart';
import 'package:todo_application/models/home_model.dart';
import 'package:todo_application/screens/todo_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HomeModel> _categories = [
    HomeModel(
      categoryTitle: 'My Tasks',
      categorySubTitle: 'Important tasks',
      categoryImage: Icons.assignment,
    ),
    HomeModel(
      categoryTitle: 'Notes',
      categorySubTitle: 'Important notes',
      categoryImage: Icons.notes,
    ),
        HomeModel(
      categoryTitle: 'Notes',
      categorySubTitle: 'Important notes',
      categoryImage: Icons.notes,
    ),
        HomeModel(
      categoryTitle: 'Notes',
      categorySubTitle: 'Important notes',
      categoryImage: Icons.notes,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final category = _categories[index];
            return InkWell(
              onTap: () {
                debugPrint('Taped');
                print(category.categoryImage.runtimeType); 
                if (category.categoryTitle == "My Tasks") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TodoListScreen()),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category.categoryImage),
                    SizedBox(height: 16),
                    Text(
                      category.categoryTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      category.categorySubTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
