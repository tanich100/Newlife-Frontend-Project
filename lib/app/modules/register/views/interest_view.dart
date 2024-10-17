import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/register/controllers/register_controller.dart';
import 'package:newlife_app/app/data/models/breed_model.dart';

class InterestView extends StatefulWidget {
  @override
  _InterestViewState createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {
  final RegisterController controller = Get.find<RegisterController>();
  RxList<String> selectedDogCategories = <String>[].obs;
  RxList<String> selectedCatCategories = <String>[].obs;
  RxBool isIncome = true.obs;
  RxString searchQuery = ''.obs;
  final int maxSelections = 5;

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
  void initState() {
    super.initState();
    controller.fetchBreeds();
  }

  void _registerWithSelectedBreeds() {
    List<String> selectedBreeds = _getAllSelectedCategories();
    List<int> selectedBreedIds = controller.allBreeds
        .where((breed) => selectedBreeds.contains(breed.breedName))
        .map((breed) => breed.breedId!)
        .toList();

    controller.setSelectedBreeds(selectedBreedIds);
    controller.register();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'เลือกสัตว์เลี้ยงที่คุณชื่นชอบ 5 รายการ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.5,
                color: Colors.black),
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
              onChanged: (query) => searchQuery.value = query,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: () => Get.toNamed('/camera'),
                ),
                hintText: 'ค้นหาสัตว์เลี้ยง...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
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
              child: Obx(() => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _filteredCategories().length,
                    itemBuilder: (context, index) {
                      final category = _filteredCategories()[index];
                      final isSelected =
                          _getSelectedCategories().contains(category.name);
                      return GestureDetector(
                        onTap: () => _toggleCategory(category.name),
                        child: _buildCategoryCard(category, isSelected),
                      );
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  if (_getAllSelectedCategories().isNotEmpty) {
                    _registerWithSelectedBreeds();
                  }
                },
                child: Text(
                  'เริ่มใช้งาน',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xfffdcf09),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.setSelectedBreeds([]);
                controller.register();
              },
              child: Text('ข้าม'),
            ),
            // SizedBox(height: 20),
            // Obx(() {
            //   final allSelected = _getAllSelectedCategories();
            //   return allSelected.isNotEmpty
            //       ? Text(
            //           'ชนิดที่เลือก: ${allSelected.join(', ')}',
            //           textAlign: TextAlign.center,
            //           style:
            //               TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //         )
            //       : SizedBox.shrink();
            // }),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool value) {
    return Obx(() => GestureDetector(
          onTap: () => isIncome.value = value,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isIncome.value == value ? Color(0xFFE8BC41) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFE8BC41)),
            ),
            child: Text(
              text,
              style: TextStyle(
                color:
                    isIncome.value == value ? Colors.white : Color(0xFFE8BC41),
                fontSize: 16,
              ),
            ),
          ),
        ));
  }

  Widget _buildCategoryCard(Category category, bool isSelected) {
    return Container(
      width: 150,
      height: 180,
      child: Card(
        color: Color(0xFFFEF1E1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    category.imagePath,
                    fit: BoxFit
                        .cover, // ใช้ BoxFit.cover เพื่อให้รูปพอดีกับพื้นที่
                    height: 85, // กำหนดความสูงของรูปภาพ
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // ป้องกันการล้นของข้อความ
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Category> _filteredCategories() {
    List<Category> categories =
        isIncome.value ? incomeCategories : expenseCategories;
    if (searchQuery.isEmpty) {
      return categories;
    } else {
      return categories
          .where((category) => category.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  List<String> _getSelectedCategories() {
    return isIncome.value ? selectedCatCategories : selectedDogCategories;
  }

  List<String> _getAllSelectedCategories() {
    return [...selectedDogCategories, ...selectedCatCategories];
  }

  void _toggleCategory(String categoryName) {
    final selectedCategories = _getSelectedCategories();
    if (selectedCategories.contains(categoryName)) {
      selectedCategories.remove(categoryName);
    } else if (_getAllSelectedCategories().length < maxSelections) {
      selectedCategories.add(categoryName);
    }
    setState(() {});
  }
}

class Category {
  final String name;
  final String imagePath;

  Category(this.name, this.imagePath);
}
