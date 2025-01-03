import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/adopted_history/bindings/adopted_history_binding.dart';
import '../modules/adopted_history/views/adopted_history_view.dart';
import '../modules/adoption_history/bindings/adoption_history_binding.dart';
import '../modules/adoption_history/views/adoption_history_view.dart';
import '../modules/camera/bindings/camera_binding.dart';
import '../modules/camera/views/camera_view.dart';
import '../modules/donate/bindings/donate_binding.dart';
import '../modules/donate/views/donate_view.dart';
import '../modules/edit_user_info/bindings/edit_user_info_binding.dart';
import '../modules/edit_user_info/views/edit_user_info_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/petsDetail/bindings/pets_detail_binding.dart';
import '../modules/petsDetail/views/pets_detail_view.dart';
import '../modules/postPet/bindings/post_pet_binding.dart';
import '../modules/postPet/views/new_post_cate_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/promote/bindings/promote_binding.dart';
import '../modules/promote/views/promote_view.dart';
import '../modules/ranking/bindings/ranking_binding.dart';
import '../modules/ranking/views/ranking_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.DONATE,
      page: () => DonateView(),
      binding: DonateBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.PETS_DETAIL,
      page: () => PetsDetailView(),
      binding: PetsDetailBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.POST_PET,
      page: () => NewPostCateView(),
      binding: PostPetBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => CameraView(),
      binding: CameraBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: _Paths.RANKING,
      page: () => const RankingView(),
      binding: RankingBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.PROMOTE,
      page: () => const PromoteView(),
      binding: PromoteBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // GetPage(
    //   name: _Paths.USER,
    //   page: () => const UserView(),
    //   binding: UserBinding(),
    //   middlewares: [AuthMiddleware()],
    // ),
    GetPage(
        name: _Paths.ADOPTED_HISTORY,
        page: () => AdoptedHistoryView(),
        binding: AdoptedHistoryBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.ADOPTION_HISTORY,
        page: () => AdoptionHistoryView(),
        binding: AdoptionHistoryBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.EDIT_USER_INFO,
      page: () => EditUserInfoView(),
      binding: EditUserInfoBinding(),
    ),
  ];
}
