
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowMoreDetails extends StatefulWidget {
  final SessionEntity session;
  final SessionsViewModel sessionsViewModel;

  const ShowMoreDetails({super.key, 
    required this.session,
    required this.sessionsViewModel,
  });

  @override
  State<ShowMoreDetails> createState() => ShowMoreDetailsState();
}

class ShowMoreDetailsState extends State<ShowMoreDetails> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    final session = widget.session;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Text(
                _expanded ? locale.showLess : locale.showMore,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: AppColors.primary,
                size: 16.sp,
              ),
            ],
          ),
        ),
        if (_expanded) ...[
          SizedBox(height: 8.h),
          _detailRow(Icons.person_outline, session.staffMember?.name ?? ''),
          _detailRow(
            Icons.location_on_outlined,
            session.service?.location ?? '',
          ),
          _detailRow(
            Icons.people_outline,
            '${session.currentParticipants ?? 0}/${session.maxParticipants ?? 0} participants',
          ),
          if (session.service?.description != null)
            _detailRow(
              Icons.info_outline,
              session.service!.description!,
              maxLines: 3,
            ),
        ],
      ],
    );
  }

  Widget _detailRow(IconData icon, String text, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: maxLines > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 14.sp,
            color: AppColors.accentColor,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              text,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
