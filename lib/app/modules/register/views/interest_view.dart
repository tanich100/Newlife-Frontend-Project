import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestView extends StatefulWidget {
  @override
  AddDetailPageState createState() => AddDetailPageState();
}

class AddDetailPageState extends State<InterestView> {
  List<String> selectedDogCategories = [];
  List<String> selectedCatCategories = [];
  bool isIncome = true;
  bool isConfirmed = false;
  String searchQuery = '';
  final int maxSelections = 5;

  // Categories data with image paths for expenses
  final List<Category> expenseCategories = [
    Category('มอลติพู', 'images/dogs/dog1.png'),
    Category('ปั๊ก', 'images/dogs/dog2.png'),
    Category('แจ็ครัสเซลล์', 'images/dogs/dog3.png'),
    Category('บีเกิ้ล', 'images/dogs/dog4.png'),
    Category('ดัลเมเชียน', 'images/dogs/dog5.png'),
    Category('ยอร์คเชียร์', 'images/dogs/dog6.png'),
    Category('บอร์เดอร์', 'images/dogs/dog7.png'),
    Category('เยอรมันเชพเพิร์ด', 'images/dogs/dog8.png'),
    Category('ลาบราดอร์', 'images/dogs/dog9.png'),
  ];

  final List<Category> incomeCategories = [
    Category('เปอร์เซีย', 'images/cats/cat1.png'),
    Category('เตอร์กิชแองโกรา', 'images/cats/cat2.png'),
    Category('สยาม', 'images/cats/cat3.png'),
    Category('ผสม', 'images/cats/cat4.png'),
    Category('ชอร์ตแฮร์', 'images/cats/cat5.png'),
    Category('เปอร์เซียผสม', 'images/cats/cat6.png'),
    Category('เมนคูน', 'images/cats/cat7.png'),
    Category('รัสเซียนบลู', 'images/cats/cat8.png'),
    Category('พันธุ์ผสม', 'images/cats/cat9.png'),
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
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
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
                suffixIcon: IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    Get.toNamed('/camera');
                  },
                ),
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
                _buildToggleButton('สุนัข', false),
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
                  mainAxisSpacing: 30,
                ),
                itemCount: _filteredCategories().length,
                itemBuilder: (context, index) {
                  final category = _filteredCategories()[index];
                  final isSelected =
                      _getSelectedCategories().contains(category.name);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _getSelectedCategories().remove(category.name);
                        } else if (_getAllSelectedCategories().length <
                            maxSelections) {
                          _getSelectedCategories().add(category.name);
                        }
                        isConfirmed = _getSelectedCategories().isNotEmpty;
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
                if (_getSelectedCategories().isNotEmpty) {
                  List<Category> selectedCategoryObjects =
                      _getSelectedCategories().map((categoryName) {
                    final category =
                        (isIncome ? incomeCategories : expenseCategories)
                            .firstWhere((cat) => cat.name == categoryName);
                    return category;
                  }).toList();

                  Get.toNamed('/home',arguments: selectedCategoryObjects);
                }
              },
              child: Text(
                'เริ่มใช้งาน',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),

            if (selectedDogCategories.isNotEmpty ||
                selectedCatCategories.isNotEmpty)
              Text(
                'ชนิดที่เลือก: ${selectedDogCategories.join(', ')} ${selectedCatCategories.join(', ')}',
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
  return Container(
    width: 120, // ปรับขนาดความกว้างของ Card ตามที่ต้องการ
    height: 150, // ปรับขนาดความสูงของ Card ตามที่ต้องการ
    child: Card(
      color: Color(0xFFFEF1E1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  category.imagePath,// ปรับขนาดของภาพ
                  fit: BoxFit.cover,
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 5,
                  right: 5,
                  child:
                      Icon(Icons.check_circle, color: Colors.green, size: 24),
                ),
            ],
          ),
          SizedBox(height: 8),
          // Category name
          Text(
            category.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

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

  List<String> _getSelectedCategories() {
    return isIncome ? selectedCatCategories : selectedDogCategories;
  }

  List<String> _getAllSelectedCategories() {
    return selectedDogCategories + selectedCatCategories;
  }
}

class Category {
  final String name;
  final String imagePath;

  Category(this.name, this.imagePath);
}
