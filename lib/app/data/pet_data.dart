class Pet {
  final int id;
  final String name;
  final String imageUrl;
  final String category;
  final String description;
  final String tag;

  Pet({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.tag,
  });
}

// Example data
final List<Pet> pets = [
  Pet(
    id: 1,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    imageUrl:
        'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
    category: 'Dog',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
  Pet(
    id: 2,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    imageUrl:
        'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
    category: 'Dog',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
  Pet(
    id: 3,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    imageUrl:
        'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
    category: 'Cat',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
  Pet(
    id: 4,
    name: 'น้องตุ๊ต๊ะ(8 เดือน)',
    imageUrl:
        'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg',
    category: 'Cat',
    description: 'friendly and energetic dog.',
    tag: 'Recommend',
  ),
];
