import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class NotificationModel {
  final String type; // 'hired' or 'payment'
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final Map<String, dynamic> data;

  NotificationModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.data,
  });
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 7) {
      return "Now";
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildNotificationIcon(String type) {
    IconData iconData;
    Color iconColor = Colors.white;

    switch (type) {
      case 'hired':
        iconData = Icons.work;
        break;
      case 'payment':
        iconData = Icons.payments;
        break;
      default:
        iconData = Icons.notifications;
    }

    return Icon(iconData, color: iconColor, size: 20);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final lightContainerHeight = screenHeight * 0.85;

    return Scaffold(
      backgroundColor: const Color(0xFF233A66),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: lightContainerHeight,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF2F5F9),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFF233A66),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Notifications',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF233A66),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<NotificationModel>>(
                      stream: _getCombinedNotifications(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_off,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No notifications',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'You have no notifications yet',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final notification = snapshot.data![index];

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEDF5FF),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[200]!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFF233A66,
                                            ).withOpacity(0.8),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: _buildNotificationIcon(
                                            notification.type,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      notification.title,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Color(
                                                          0xFF233A66,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    _formatTime(
                                                      notification.timestamp,
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                notification.subtitle,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stream<List<NotificationModel>> _getCombinedNotifications() {
    final userEmail = _auth.currentUser?.email;
    if (userEmail == null) return Stream.value([]);

    // Get hired notifications
    final hiredStream = _firestore
        .collection('hired_users')
        .where('userEmail', isEqualTo: userEmail)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                return NotificationModel(
                  type: 'hired',
                  title: 'You have been hired for ${data['jobTitle']}',
                  subtitle: 'Company: ${data['company']}',
                  timestamp: (data['hiredAt'] as Timestamp).toDate(),
                  data: data,
                );
              }).toList(),
        );

    // Get payment notifications
    final paymentStream = _firestore
        .collection('payments')
        .where('userEmail', isEqualTo: userEmail)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                return NotificationModel(
                  type: 'payment',
                  title: 'Payment received',
                  subtitle: 'Amount: Rs ${data['amount']}',
                  timestamp: (data['submittedAt'] as Timestamp).toDate(),
                  data: data,
                );
              }).toList(),
        );

    // Combine and sort both streams
    return Rx.combineLatest2(hiredStream, paymentStream, (
      List<NotificationModel> hired,
      List<NotificationModel> payments,
    ) {
      final allNotifications = [...hired, ...payments];
      allNotifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return allNotifications;
    });
  }
}
