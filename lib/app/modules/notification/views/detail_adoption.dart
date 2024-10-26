import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:newlife_app/app/modules/notification/views/confirm_dialog.dart';

class DetailAdoption extends GetView<NotificationController> {
  final int notiAdopReqId;
  final requestDetails = Rxn<Map<String, dynamic>>();

  DetailAdoption({required this.notiAdopReqId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRequestDetails();
    });

    return WillPopScope(
      onWillPop: () async {
        Get.until((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดผู้ขอรับเลี้ยง',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.until((route) => route.isFirst),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final details = requestDetails.value;
          if (details == null) {
            return Center(child: Text('กำลังโหลดข้อมูล...'));
          }

          print('Details received: $details');

          final user = details['user'] as Map<String, dynamic>?;
          if (user == null) {
            return Center(child: Text('ไม่พบข้อมูลผู้ใช้'));
          }

          final reasonForAdoption = details['reasonForAdoption'];
          print('ReasonForAdoption: $reasonForAdoption');

          final profilePicUrl = user['profilePic'] != null
              ? 'http://10.0.2.2:5296/User/getImage/${user['profilePic']}'
              : null;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profilePicUrl != null)
                    Center(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(profilePicUrl),
                        onBackgroundImageError: (_, __) {},
                        child: profilePicUrl == null
                            ? Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),
                  SizedBox(height: 24),
                  _buildInfoSection(user, reasonForAdoption),
                  SizedBox(height: 24),
                  if (!controller.isLoading.value)
                    _buildActionButtons(context, user['name'] ?? 'ผู้ใช้'),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInfoSection(
      Map<String, dynamic> user, String? reasonForAdoption) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('ชื่อ', user['name']),
        _buildInfoRow('อีเมล', user['email']),
        _buildInfoRow('อายุ', user['age']?.toString()),
        _buildInfoRow('เบอร์โทร', user['tel']),
        _buildInfoRow('อาชีพ', user['career']),
        _buildInfoRow(
            'จำนวนสมาชิกในครอบครัว', user['numOfFamMembers']?.toString()),
        _buildInfoRow('ประสบการณ์ในการเลี้ยงสัตว์',
            user['isHaveExperience'] == true ? "มี" : "ไม่มี"),
        _buildInfoRow('ขนาดที่อยู่อาศัย', user['sizeOfResidence']),
        _buildInfoRow('ประเภทที่อยู่อาศัย', user['typeOfResidence']),
        _buildInfoRow('เวลาว่างต่อวัน', '${user['freeTimePerDay']} ชั่วโมง'),
        _buildInfoRow('รายได้ต่อเดือน', '${user['monthlyIncome']} บาท'),
        SizedBox(height: 16),
        Text(
          'เหตุผลในการรับเลี้ยง:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(reasonForAdoption?.isNotEmpty == true
            ? reasonForAdoption!
            : 'ไม่ระบุ'),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.check_circle_outline),
          label: Text('อนุมัติ'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () => _handleApprove(context, userName),
        ),
        SizedBox(width: 20),
        ElevatedButton.icon(
          icon: Icon(Icons.cancel_outlined),
          label: Text('ไม่อนุมัติ'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () => _handleDeny(context, userName),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value ?? 'ไม่ระบุ'),
          ),
        ],
      ),
    );
  }

  void _handleApprove(BuildContext context, String userName) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ConfirmDialog(
          title: 'อนุมัติ',
          name: userName,
          message: 'ต้องการอนุมัติให้ $userName รับเลี้ยงหรือไม่',
          onConfirm: () {
            Navigator.of(dialogContext).pop(true);
          },
        );
      },
    );

    if (result == true) {
      try {
        await controller.handleApproveRequest(notiAdopReqId);
      } catch (e) {
        print('Error in approve: $e');
      }
    }
  }

  void _handleDeny(BuildContext context, String userName) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ConfirmDialog(
          title: 'ไม่อนุมัติ',
          name: userName,
          message: 'ต้องการปฏิเสธคำขอรับเลี้ยงของ $userName หรือไม่',
          onConfirm: () {
            Navigator.of(dialogContext).pop(true);
          },
        );
      },
    );

    if (result == true) {
      try {
        await controller.handleDenyRequest(notiAdopReqId);
      } catch (e) {
        print('Error in deny: $e');
      }
    }
  }

  Future<void> _loadRequestDetails() async {
    try {
      final notification = controller.postOwnerNotifications
          .firstWhere((n) => n.notiAdopReqId == notiAdopReqId);

      final details =
          await controller.fetchAdoptionRequestDetails(notification.requestId);

      if (details != null) {
        print('Request Details loaded: $details');
        print('ReasonForAdoption in details: ${details['reasonForAdoption']}');

        requestDetails.value = details;
      } else {
        Get.snackbar(
          'ข้อผิดพลาด',
          'ไม่พบข้อมูลที่ต้องการ',
          backgroundColor: Colors.red.withOpacity(0.1),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error loading request details: $e');
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถโหลดข้อมูลได้ กรุณาลองใหม่',
        backgroundColor: Colors.red.withOpacity(0.1),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
