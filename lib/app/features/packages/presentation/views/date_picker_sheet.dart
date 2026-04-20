import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/util/app_colors.dart';

class AppDatePickerSheet {
  static void show(
    BuildContext context, {
    required DateTime initialDate,
    required Function(DateTime) onDateSelected,
  }) {
    DateTime tempDate = initialDate;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close, color: AppColors.accentColor, size: 22.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          onDateSelected(tempDate);
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.check, color: AppColors.accentColor, size: 22.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200.h,
                  child: Row(
                    children: [
                      _buildWheel(
                        flex: 1,
                        initialItem: tempDate.day - 1,
                        childCount: 31,
                        onChanged: (index) => setSheetState(() => 
                          tempDate = DateTime(tempDate.year, tempDate.month, index + 1)),
                        labelBuilder: (index) => '${index + 1}',
                      ),
                      _buildWheel(
                        flex: 2,
                        initialItem: tempDate.month - 1,
                        childCount: 12,
                        onChanged: (index) => setSheetState(() => 
                          tempDate = DateTime(tempDate.year, index + 1, tempDate.day)),
                        labelBuilder: (index) => DateFormat('MMMM').format(DateTime(0, index + 1)),
                      ),
                      _buildWheel(
                        flex: 1,
                        initialItem: tempDate.year - 2024,
                        childCount: 10,
                        onChanged: (index) => setSheetState(() => 
                          tempDate = DateTime(2024 + index, tempDate.month, tempDate.day)),
                        labelBuilder: (index) => '${2024 + index}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            );
          },
        );
      },
    );
  }

  static Widget _buildWheel({
    required int flex,
    required int initialItem,
    required int childCount,
    required Function(int) onChanged,
    required String Function(int) labelBuilder,
  }) {
    return Expanded(
      flex: flex,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40.h,
        perspective: 0.005,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: initialItem),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) => Center(
            child: Text(
              labelBuilder(index),
              style: TextStyle(color: AppColors.accentColor, fontSize: 16.sp),
            ),
          ),
        ),
      ),
    );
  }
}