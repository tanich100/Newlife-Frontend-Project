class AppUrl {
  AppUrl._();

  static const String baseUrl = "http://10.0.2.2:5296";

  //User url
  static const String user = '/User';

//Post url
  static const String adoptionPosts = '/AdoptionPost';
  static const String image = '/getImage';

  static const String findOwnerPosts = '/FindOwnerPosts';
  static const String findOwnerPostImage = '/getFindOwnerPostImage';

//Fav url
  static const String favoriteAnimals = '/FavoriteAnimal';

  // Breed url
  static const String breeds = '/Breed';

  //Notification
  static const String notificationAdoptionPost = '/NotificationAdoptionPost';
  static const String notificationAdoptionPostByUserId =
      '/NotificationAdoptionPost/GetList/';

  static const String notificationAdoptionRequestByUserId =
      '/NotificationAdoptionRequest/GetList/';
}
