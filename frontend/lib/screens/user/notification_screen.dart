// import 'package:flutter/material.dart';
// import 'package:frontend/services/notification_service.dart';
// import 'package:frontend/widgets/user/bottom_nav_bar.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   List<Map<String, dynamic>> notifications = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchNotifications();
//   }

//   Future<void> fetchNotifications() async {
//     try {
//       final userId = 'USER_ID'; // Replace with logged-in user ID
//       final fetched = await NotificationService.fetchUserNotifications(userId);
//       setState(() {
//         notifications = fetched;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ... same banner and header
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : ListView.separated(
//                 itemCount: notifications.length,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 separatorBuilder: (_, __) => const Divider(height: 24),
//                 itemBuilder: (context, index) {
//                   final notif = notifications[index];
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Icon(Icons.check_circle, color: Color(0xFFB3D9F5)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               notif['title'] ?? '',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               notif['message'] ?? '',
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),

//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: 1,
//         onTap: (index) {
//           if (index == 1) Navigator.pushNamed(context, '/userHome');
//           if (index == 0) Navigator.pushNamed(context, '/usertips');
//           if (index == 2) Navigator.pushNamed(context, '/profile');
//         },
//       ),
//     );
//   }
// }
