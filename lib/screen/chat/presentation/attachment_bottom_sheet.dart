import 'package:flutter/material.dart';
import 'package:kawaii_chat/utility/app_colors.dart';

class AttachmentBottomSheet extends StatelessWidget {
  final Function onPhotoTap;
  final Function onFileTap;
  final Function onCancelTap;

  const AttachmentBottomSheet({
    super.key,
    required this.onPhotoTap,
    required this.onFileTap,
    required this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: AppColors.color_F1F1F2,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          const SizedBox(height: 8),
          _buildListItem(Icons.photo_outlined, 'Photo', () {
            onPhotoTap();
          }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: AppColors.color_F1F1F2,
              thickness: 1,
            ),
          ),
          _buildListItem(Icons.file_present_outlined, 'File', () {
            onFileTap();
          }),
          const SizedBox(height: 8),
          _buildCancelButton(context),
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.color_2196F3,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.color_black, // Set text color
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onCancelTap();
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.color_2196F3),
        // Set border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Set border radius
        ),
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        'Cancel',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.color_2196F3, // Set text color
        ),
      ),
    );
  }
}
