import 'package:art_of_pilates/app/features/announcments/domain/model/announcments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnouncmentTile extends StatelessWidget {
  final AnnouncmentEntity announcement;

  const AnnouncmentTile({super.key, required this.announcement});

  Color _typeColor(String? type, BuildContext context) {
    switch (type) {
      case 'sessionCancellation':
        return Colors.red.shade600;
      case 'sessionReschedule':
        return Colors.orange.shade600;
      case 'newService':
        return Colors.green.shade600;
      case 'newPricingPlan':
        return Colors.blue.shade600;
      case 'newStaffMember':
        return Colors.purple.shade600;
      case 'priceChange':
        return Colors.teal.shade600;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _typeIcon(String? type) {
    switch (type) {
      case 'sessionCancellation':
        return Icons.cancel_outlined;
      case 'sessionReschedule':
        return Icons.schedule_outlined;
      case 'newService':
        return Icons.fiber_new_outlined;
      case 'newPricingPlan':
        return Icons.card_membership_outlined;
      case 'newStaffMember':
        return Icons.person_add_outlined;
      case 'priceChange':
        return Icons.price_change_outlined;
      default:
        return Icons.campaign_outlined;
    }
  }

  String _typeLabel(String? type) {
    switch (type) {
      case 'sessionCancellation':
        return 'Cancellation';
      case 'sessionReschedule':
        return 'Reschedule';
      case 'newService':
        return 'New Service';
      case 'newPricingPlan':
        return 'New Plan';
      case 'newStaffMember':
        return 'New Staff';
      case 'priceChange':
        return 'Price Change';
      default:
        return 'Announcement';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _typeColor(announcement.type, context);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border(left: BorderSide(color: color, width: 4.w)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(_typeIcon(announcement.type), color: color, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          _typeLabel(announcement.type),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    announcement.title ?? '',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    announcement.content ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}