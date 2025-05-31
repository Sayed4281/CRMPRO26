import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';

class EditProductDialog extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onSave;

  const EditProductDialog({
    super.key,
    required this.product,
    required this.onSave,
  });

  @override
  _EditProductDialogState createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController supplierController;
  late TextEditingController descriptionController;
  final List<String> categories = ['Monitoring Device', 'Therapeutic Device', 'Diagnostic Device'];
  late String selectedCategory;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product['name']?.toString() ?? '');
    priceController = TextEditingController(text: widget.product['price']?.toString() ?? '');
    quantityController = TextEditingController(text: widget.product['quantity']?.toString() ?? '');
    supplierController = TextEditingController(text: widget.product['supplier']?.toString() ?? '');
    descriptionController = TextEditingController(text: widget.product['description']?.toString() ?? '');
    selectedCategory = categories.contains(widget.product['category']?.toString())
        ? widget.product['category'].toString()
        : categories.first;
    imagePath = widget.product['imageUrl']?.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    supplierController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
              'Edit Product',
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: Form fields
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabeledField("Product Name", nameController, isDarkMode),
                      _buildLabeledField("Price", priceController, inputType: TextInputType.number, isDarkMode),
                      _buildDropdownField("Category", selectedCategory, categories, (val) {
                        setState(() => selectedCategory = val!);
                      }, isDarkMode),
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
                      _buildLabeledField("Description", descriptionController,
                          minLines: 2, maxLines: 2, isDarkMode),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Right side: Product Image
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imagePath != null && imagePath!.isNotEmpty
                              ? Image.network(
                            imagePath!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 200,
                              width: 200,
                              color: isDarkMode ? DarkTheme.backgroundColor : Colors.grey.shade200,
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                              ),
                            ),
                          )
                              : Container(
                            height: 200,
                            width: 200,
                            color: isDarkMode ? DarkTheme.backgroundColor : Colors.grey.shade200,
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedProduct = {
                'index': widget.product['index'],
                'id': widget.product['id'],
                'name': nameController.text,
                'category': selectedCategory,
                'price': int.tryParse(priceController.text) ?? 0,
                'quantity': int.tryParse(quantityController.text) ?? 0,
                'supplier': supplierController.text,
                'stock': widget.product['stock'],
                'recentOrders': widget.product['recentOrders'],
                'description': descriptionController.text,
                'imageUrl': imagePath,
              };
              widget.onSave(updatedProduct);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Product updated successfully',
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
              'Save',
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
            icon: Icon(
              Icons.arrow_drop_down,
              color: isDarkMode ? DarkTheme.textColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}