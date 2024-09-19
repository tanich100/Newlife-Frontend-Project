import 'package:get/get.dart';
import '../modules/adoptionHistory/bindings/adoption_history_binding.dart';
import '../modules/adoptionHistory/views/adoption_history_view.dart';
import '../modules/camera/bindings/camera_binding.dart';
import '../modules/camera/views/camera_view.dart';
import '../modules/donate/bindings/donate_binding.dart';
import '../modules/donate/views/donate_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/petsDetail/bindings/pets_detail_binding.dart';
import '../modules/petsDetail/views/pets_detail_view.dart';
import '../modules/postPet/bindings/post_pet_binding.dart';
import '../modules/postPet/views/post_pet_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DONATE,
      page: () => DonateView(),
      binding: DonateBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PETS_DETAIL,
      page: () => const PetsDetailView(),
      binding: PetsDetailBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.POST_PET,
      page: () => const PostPetView(),
      binding: PostPetBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => CameraView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.ADOPTION_HISTORY,
      page: () => const AdoptionHistoryView(),
      binding: AdoptionHistoryBinding(),
    ),
  ];
}
