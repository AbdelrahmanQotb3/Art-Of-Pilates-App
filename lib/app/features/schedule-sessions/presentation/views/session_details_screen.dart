import 'package:art_of_pilates/app/config/di/di.dart';
import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/core/util/app_images.dart';
import 'package:art_of_pilates/app/core/util/app_locale.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_states.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SessionDetailsScreen extends StatefulWidget {
  final String sessionId;

  const SessionDetailsScreen({super.key, required this.sessionId});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  late final SessionsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SessionsViewModel>();
    viewModel.getOneSession(widget.sessionId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocListener<SessionsViewModel, SessionsStates>(
        listenWhen: (prev, curr) =>
            prev.getOneSessionStateParams != curr.getOneSessionStateParams,
        listener: (context, state) {
          if (state.getOneSessionStateParams?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.getOneSessionStateParams!.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: _buildAppBar(context),
          body: BlocBuilder<SessionsViewModel, SessionsStates>(
            buildWhen: (prev, curr) =>
                prev.getOneSessionStateParams != curr.getOneSessionStateParams,
            builder: (context, state) {
              if (state.getOneSessionStateParams?.isLoading ?? false) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.getOneSessionStateParams?.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Something went wrong',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        onPressed: () =>
                            viewModel.getOneSession(widget.sessionId),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final session = state.getOneSessionStateParams?.data;
              if (session == null) return const SizedBox.shrink();

              return _buildBody(context, session);
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final locale = appLocale(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        locale.bookThisSession,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SessionEntity session) {
    final locale = appLocale(context);
    final spotsLeft =
        (session.maxParticipants ?? 0) - (session.currentParticipants ?? 0);
    final durationMinutes = session.startTime != null && session.endTime != null
        ? DateTime.parse(
            session.endTime!,
          ).difference(DateTime.parse(session.startTime!)).inMinutes
        : 0;
    final formattedTime = session.startTime != null
        ? DateFormat(
            'h:mm a',
          ).format(DateTime.parse(session.startTime!).toLocal())
        : '';

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 160.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Image Header ──
              _buildImageHeader(),

              // ── Session Info ──
              _buildSection(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.service?.name ?? '',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildInfoRow(
                      Icons.calendar_today_outlined,
                      'Today, $formattedTime ($durationMinutes minutes)',
                    ),
                    _buildInfoRow(
                      Icons.monetization_on_outlined,
                      'SAR ${session.service?.price ?? ''} • Payable with plan',
                    ),
                    _buildInfoRow(
                      Icons.person_outline,
                      session.staffMember?.name ?? '',
                    ),
                    _buildInfoRow(
                      Icons.location_on_outlined,
                      session.service?.name ?? '',
                      underline: true,
                    ),
                  ],
                ),
              ),

              Divider(color: AppColors.accentColor.withOpacity(0.1), height: 1),

              // ── About ──
              _buildSection(
                child: _AboutSection(description: session.service?.description ?? ''),
              ),

              Divider(color: AppColors.accentColor.withOpacity(0.1), height: 1),

              // ── Spots Left ──
              _buildSection(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$spotsLeft ${locale.spotsLeft}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.accentColor,
                      ),
                    ),
                    SizedBox(
                      width: 32.w,
                      height: 32.h,
                      child: CircleAvatar(
                        backgroundColor: AppColors.secondary,

                        child: Icon(
                          Icons.person_2,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(color: AppColors.accentColor.withOpacity(0.1), height: 1),

              // ── Price ──
              _buildSection(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.price,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.accentColor.withOpacity(0.5),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'SAR ${session.service?.price ?? ''} per session',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(color: AppColors.accentColor.withOpacity(0.1), height: 1),

              // ── Coupon Code ──
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                title: Text(
                  locale.enterCouponcode,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.accentColor,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: AppColors.accentColor,
                ),
                onTap: () {
                  // TODO: open coupon input
                },
              ),

              Divider(color: AppColors.accentColor.withOpacity(0.1), height: 1),
            ],
          ),
        ),

        // ── Fixed Bottom Bar ──
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: AppColors.backgroundColor,
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SAR ${session.service?.price ?? ''} ${locale.dueNow}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.accentColor,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: handle booking
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      locale.bookAndPay,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    // TODO: navigate to payment options
                  },
                  child: Text(
                    locale.viewPaymentOptions,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Helpers ──

  Widget _buildSection({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: child,
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool underline = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: AppColors.accentColor.withOpacity(0.5),
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.accentColor,
              decoration: underline ? TextDecoration.underline : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHeader() => Image.asset(
    AppImages.homeLogo,
    width: double.infinity,
    height: 120.h,
    fit: BoxFit.cover,
  );
}

// ── About Section with Show More/Less ──
class _AboutSection extends StatefulWidget {
  final String description;
  const _AboutSection({required this.description});

  @override
  State<_AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<_AboutSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final locale = appLocale(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.about,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.accentColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          widget.description,
          maxLines: _expanded ? null : 3,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(fontSize: 13.sp, color: AppColors.accentColor),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: AppColors.primary,
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                _expanded ? locale.showLess : locale.showMore,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
