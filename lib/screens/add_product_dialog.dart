import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class AddProductDialog extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) onSave;

  const AddProductDialog({
    super.key,
    required this.products,
    required this.onSave,
  });

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController supplierController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<String> categories = ['Monitoring Device', 'Therapeutic Device', 'Diagnostic Device'];
  String selectedCategory = 'Monitoring Device';
  String? imagePath;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        imagePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Product',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 18,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        content: SizedBox(
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabeledField("Product Name", nameController, isDarkMode),
                _buildDropdownField("Category", selectedCategory, categories, (val) {
                  setState(() => selectedCategory = val!);
                }, isDarkMode),
                _buildLabeledField("Price", priceController, inputType: TextInputType.number, isDarkMode),
                Row(
                  children: [
                    Expanded(
                      child: _buildLabeledField("Quantity", quantityController,
                          inputType: TextInputType.number, isDarkMode),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildLabeledField("Supplier", supplierController, isDarkMode),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildImagePickerField(isDarkMode),
                const SizedBox(height: 10),
                _buildLabeledField("Description", descriptionController,
                    minLines: 2, maxLines: 2, isDarkMode),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFE6E6FA),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final newProduct = {
                'index': (widget.products.length + 1).toString().padLeft(2, '0'),
                'id': (int.parse(widget.products.last['id']) + 1).toString(),
                'name': nameController.text,
                'category': selectedCategory,
                'price': int.parse(priceController.text),
                'quantity': int.parse(quantityController.text),
                'supplier': supplierController.text,
                'stock': true,
                'recentOrders': 0,
                'description': descriptionController.text,
                'imageUrl': imagePath,
              };
              widget.onSave(newProduct);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Product added successfully',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                    ),
                  ),
                  backgroundColor: isDarkMode ? DarkTheme.accentColor : Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              'Add Product',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledField(String label, TextEditingController controller, bool isDarkMode,
      {int minLines = 1, int maxLines = 1, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            minLines: minLines,
            maxLines: maxLines,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> options,
      void Function(String?) onChanged, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            items: options.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
            onChanged: onChanged,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
            decoration: InputDecoration(
              isDense: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePickerField(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Image",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  imagePath != null ? imagePath!.split('/').last : 'No image selected',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: Text(
                'Choose Image',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}