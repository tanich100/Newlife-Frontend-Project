class Pet {
  final int id;
  final String name;
  final String imageUrl;
  final String category;
  final String description;
  final String tag;
  final String gender;

  Pet({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.tag,
    required this.gender,
  });
}

// Example data
final List<Pet> pets = [
  Pet(
    id: 1,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    gender: 'male',
    imageUrl:
        'https://static.scientificamerican.com/sciam/cache/file/2AE14CDD-1265-470C-9B15F49024186C10_source.jpg?w=1200',
    category: 'Dog',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
  Pet(
    id: 2,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    gender: 'female',
    imageUrl:
        'https://cdn.psychologytoday.com/sites/default/files/styles/article-inline-half-caption/public/field_blog_entry_images/2021-12/img_1570.jpg?itok=4nWOikbM',
    category: 'Dog',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
  Pet(
    id: 3,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    gender: 'male',
    imageUrl:
        'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
    category: 'Cat',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
  Pet(
    id: 4,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    gender: 'female',
    imageUrl:
        'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
    category: 'Cat',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
];
