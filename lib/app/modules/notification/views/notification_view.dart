import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:newlife_app/app/modules/notification/views/detail_adoption.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    _initialLoad();
  }

  Future<void> _initialLoad() async {
    await controller.getPostOwnerNotifications();
    await controller.getRequesterNotifications();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) return;

    controller.currentTab.value = _tabController.index;
    _loadTabData(_tabController.index);
  }

  Future<void> _loadTabData(int index) async {
    controller.isLoading.value = true;
    try {
      switch (index) {
        case 0: // แจ้งเตือน
          await controller.getRequesterNotifications();
          break;
        case 1: // คำขอรับเลี้ยง
          await controller.getPostOwnerNotifications();
          break;
        case 2: // การขอรับเลี้ยง
          await controller.getRequesterNotifications();
          break;
      }
    } finally {
      controller.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(tabType: TabType.notification),
          _buildTabContent(tabType: TabType.requests, isTappable: true),
          _buildTabContent(tabType: TabType.myRequests),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'การแจ้งเตือน',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: [
        Obx(() {
          final hasUnreadNotifications = controller.currentTab.value == 1
              ? controller.postOwnerNotifications.any((n) => !n.isRead)
              : controller.requesterNotifications.any((n) => !n.isRead);

          if (hasUnreadNotifications) {
            return IconButton(
              icon: Icon(Icons.clear_all, color: Colors.grey[800]),
              onPressed: () => _showClearConfirmationDialog(),
            );
          }
          return SizedBox.shrink();
        }),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: _buildTabBar(),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Color(0xFFFFD54F),
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.symmetric(horizontal: 16),
      tabs: [
        _buildTab('แจ้งเตือน', TabType.notification),
        _buildTab('คำขอรับเลี้ยง', TabType.requests),
        _buildTab('การขอรับเลี้ยง', TabType.myRequests),
      ],
    );
  }

  Widget _buildTab(String text, TabType type) {
    return Obx(() {
      final notifications = type == TabType.requests
          ? controller.postOwnerNotifications
          : controller.requesterNotifications;
      final hasUnread = notifications.any((n) => !n.isRead);

      return Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            if (hasUnread) ...[
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  notifications.where((n) => !n.isRead).length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Future<void> _showClearConfirmationDialog() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text('ล้างการแจ้งเตือน'),
        content: Text('คุณต้องการล้างการแจ้งเตือนทั้งหมดหรือไม่?'),
        actions: [
          TextButton(
            child: Text('ยกเลิก'),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
            child: Text('ตกลง'),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ),
    );

    if (result == true) {
      await controller.clearAllNotifications();
    }
  }

  Widget _buildTabContent({
    required TabType tabType,
    bool isTappable = false,
  }) {
    return Obx(
      () {
        final notifications = tabType == TabType.notification
            ? controller.combinedNotifications
            : tabType == TabType.requests
                ? controller.postOwnerNotifications
                : controller.requesterNotifications;

        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (notifications.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () => _loadTabData(_tabController.index),
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final isPostOwnerNotification = controller.postOwnerNotifications
                  .any((n) => n.notiAdopReqId == notification.notiAdopReqId);

              return _buildNotificationCard(
                notification: notification,
                isTappable: tabType == TabType.notification
                    ? isPostOwnerNotification
                    : isTappable,
                tabType: tabType,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'ไม่มีการแจ้งเตือนในขณะนี้',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required NotificationAdoptionRequest notification,
    required bool isTappable,
    required TabType tabType,
  }) {
    final bool isHandled =
        notification.status == 'accepted' || notification.status == 'declined';

    void onCardTap() async {
      await controller.markNotificationAsRead(notification);

      // สำหรับ PostOwner notifications
      if (isTappable && !isHandled) {
        Get.to(() => DetailAdoption(notiAdopReqId: notification.notiAdopReqId));
      }
      // สำหรับ Requester notifications ที่มีสถานะ accepted หรือ declined
      else if (tabType == TabType.myRequests ||
          (tabType == TabType.notification && !isTappable && isHandled)) {
        controller.showNotificationDetails(notification);
      }
    }

    return GestureDetector(
      onTap: onCardTap,
      child: Stack(
        children: [
          Card(
            elevation: 2,
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isHandled ? Colors.grey.shade300 : Colors.transparent,
                width: 1,
              ),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.mail_outline,
                        size: 24,
                        color: Colors.grey[700],
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    isHandled ? Colors.grey[600] : Colors.black,
                              ),
                            ),
                            if (notification.postName != null) ...[
                              SizedBox(height: 4),
                              Text(
                                'สัตว์เลี้ยง: ${notification.postName}',
                                style: TextStyle(
                                  color:
                                      isHandled ? Colors.grey : Colors.black87,
                                ),
                              ),
                            ],
                            SizedBox(height: 4),
                            Text(
                              _formatDate(notification.notiDate),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (notification.status != null)
                    _buildStatusIndicator(notification.status!),
                  if (isTappable && !isHandled) _buildTapIndicator(),
                ],
              ),
            ),
          ),
          if (!notification.isRead)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationHeader(
      NotificationAdoptionRequest notification, bool isHandled) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfilePicture(notification),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isHandled ? Colors.grey[600] : Colors.black,
                ),
              ),
              if (notification.postName != null) ...[
                SizedBox(height: 4),
                Text(
                  'สัตว์เลี้ยง: ${notification.postName}',
                  style: TextStyle(
                    color: isHandled ? Colors.grey : Colors.black87,
                  ),
                ),
              ],
              SizedBox(height: 4),
              Text(
                _formatDate(notification.notiDate),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePicture(NotificationAdoptionRequest notification) {
    String? profilePicUrl = notification.requestingUser?.profilePic != null
        ? 'http://10.0.2.2:5296/User/getImage/${notification.requestingUser!.profilePic}'
        : null;

    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.grey.shade200,
      backgroundImage:
          profilePicUrl != null ? NetworkImage(profilePicUrl) : null,
      child:
          profilePicUrl == null ? Icon(Icons.person, color: Colors.grey) : null,
    );
  }

  Widget _buildStatusIndicator(String status) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: status == 'accepted'
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          status == 'accepted' ? 'อนุมัติแล้ว' : 'ปฏิเสธแล้ว',
          style: TextStyle(
            color: status == 'accepted' ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTapIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Text(
        'แตะเพื่อดูรายละเอียด',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[700],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

enum TabType {
  notification,
  requests,
  myRequests,
}
