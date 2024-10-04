import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestView extends StatefulWidget {
  @override
  AddDetailPageState createState() => AddDetailPageState();
}

class AddDetailPageState extends State<InterestView> {
  List<String> selectedCategories = []; // Track multiple selected categories
  bool isIncome = true; // Default to Income
  bool isConfirmed = false; // State to show confirmation
  String searchQuery = ''; // Search query string
  final int maxSelections = 5; // Maximum number of selections allowed

  // Categories data with image paths for expenses
  final List<Category> expenseCategories = [
    Category('หมา1', 'images/dogs/dog1.png'),
    Category('หมา2', 'images/dogs/dog2.png'),
    Category('หมา3', 'images/dogs/dog3.png'),
    Category('หมา4', 'images/dogs/dog4.png'),
    Category('หมา5', 'images/dogs/dog5.png'),
    Category('หมา6', 'images/dogs/dog6.png'),
    Category('หมา7', 'images/dogs/dog7.png'),
    Category('หมา8', 'images/dogs/dog8.png'),
    Category('หมา9', 'images/dogs/dog9.png'),
  ];

  // Categories data with image paths for income
  final List<Category> incomeCategories = [
    Category('แมว1', 'images/cats/cat1.png'),
    Category('แมว2', 'images/cats/cat2.png'),
    Category('แมว3', 'images/cats/cat3.png'),
    Category('แมว4', 'images/cats/cat4.png'),
    Category('แมว5', 'images/cats/cat5.png'),
    Category('แมว6', 'images/cats/cat6.png'),
    Category('แมว7', 'images/cats/cat7.png'),
    Category('แมว8', 'images/cats/cat8.png'),
    Category('แมว9', 'images/cats/cat9.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'เลือกสัตว์เลี้ยงที่คุณชื่นชอบ 5 รายการ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black),
                suffixIcon: Icon(Icons.camera_alt_outlined, color: Colors.black),
                hintText: 'ค้นหาสัตว์เลี้ยง...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Toggle Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton('หมา', false),
                SizedBox(width: 16),
                _buildToggleButton('แมว', true),
              ],
            ),
            SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _filteredCategories().length,
                itemBuilder: (context, index) {
                  final category = _filteredCategories()[index];
                  final isSelected = selectedCategories.contains(category.name);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.remove(category.name);
                        } else if (selectedCategories.length < maxSelections) {
                          selectedCategories.add(category.name);
                        }
                        isConfirmed = selectedCategories.isNotEmpty;
                      });
                    },
                    child: _buildCategoryCard(category, isSelected),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (selectedCategories.isNotEmpty) {
                  List<Category> selectedCategoryObjects = selectedCategories.map((categoryName) {
                    final category = (isIncome
                        ? incomeCategories
                        : expenseCategories).firstWhere((cat) => cat.name == categoryName);
                    return category;
                  }).toList();
                  Get.back(result: selectedCategoryObjects);
                }
              },
              child: Text('เริ่มใช้งาน',style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),

            if (isConfirmed)
              Text(
                'หมวดหมู่ที่เลือก: ${selectedCategories.join(', ')}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  // Toggle button widget
  Widget _buildToggleButton(String text, bool value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isIncome = value;
          selectedCategories.clear(); // Reset selected categories when toggling
          isConfirmed = false; // Reset confirmation when toggling
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isIncome == value ? Color(0xFFE8BC41) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE8BC41)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isIncome == value ? Colors.white : Color(0xFFE8BC41),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Card for displaying categories with checkmark overlaying the image
  Widget _buildCategoryCard(Category category, bool isSelected) {
    return Card(
      color: Color(0xFFFEF1E1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              // Category image
              ClipRRect(
                borderRadius: BorderRadius.circular(15), // Ensure image fits rounded corners
                child: Image.asset(
                  category.imagePath,
                  width: 80, // Adjust size as needed
                  height: 110, // Adjust size as needed
                  fit: BoxFit.cover, // Ensure the image fits properly
                ),
              ),
              // Positioned checkmark overlay on top-right of the image
              if (isSelected)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(Icons.check_circle, color: Colors.green, size: 24),
                ),
            ],
          ),
          SizedBox(height: 8),
          // Category name
          Text(
            category.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Function to filter categories based on search query
  List<Category> _filteredCategories() {
    List<Category> categories = isIncome ? incomeCategories : expenseCategories;
    if (searchQuery.isEmpty) {
      return categories;
    } else {
      return categories
          .where((category) => category.name.contains(searchQuery))
          .toList();
    }
  }
}

class Category {
  final String name;
  final String imagePath;

  Category(this.name, this.imagePath);
}
