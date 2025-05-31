import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';
import 'main_layout.dart';
import 'products_screen.dart';
import 'edit_product_dialog.dart';
import 'home_screen.dart'; // Import the HomeScreen (adjust the path as needed)

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onDelete;
  final Function(Map<String, dynamic>) onUpdate;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onUpdate,
  });

  void _showDeleteConfirmationDialog(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
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
                  'Confirm Delete',
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
              width: 300,
              child: Text(
                'Are you sure you want to delete this product? This action cannot be undone.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.black87,
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
                  try {
                    onDelete();
                    Navigator.pop(context);
                    Navigator.pop(context); // Return to ProductsScreen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Product deleted successfully',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                          ),
                        ),
                        backgroundColor: isDarkMode ? DarkTheme.accentColor : Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } catch (e) {
                    Navigator.pop(context); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error deleting product: $e',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                          ),
                        ),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(
                  'Delete',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: isDarkMode ? DarkTheme.errorColor : Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MainLayout(
      currentPage: ProductsScreen,
      content: Container(
        color: const Color(0xFFFFFFFF), // Updated to always use white background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumb with clickable links
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dashboard',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                                  (route) => false,
                            );
                          },
                      ),
                      TextSpan(
                        text: ' > ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Products',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const ProductsScreen()),
                                  (route) => false,
                            );
                          },
                      ),
                      TextSpan(
                        text: ' > PID-${product['id'] ?? 'N/A'}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? DarkTheme.textColor : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Title and Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'PID-${product['id'] ?? 'N/A'}: ${product['name'] ?? 'N/A'}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.whiteColor,
                            backgroundColor: const Color(0xFF6C5DD3),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(
                            Icons.edit,
                            color: AppTheme.whiteColor,
                            size: 16,
                          ),
                          label: Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppTheme.whiteColor,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black54,
                              builder: (BuildContext context) {
                                return EditProductDialog(
                                  product: product,
                                  onSave: (updatedProduct) {
                                    onUpdate(updatedProduct);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.whiteColor,
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(
                            Icons.delete,
                            color: AppTheme.whiteColor,
                            size: 16,
                          ),
                          label: Text(
                            'Delete',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppTheme.whiteColor,
                            ),
                          ),
                          onPressed: () => _showDeleteConfirmationDialog(context),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Split layout: Details on the left, Image on the right
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: Summary Cards and Details
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Summary Cards
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _infoCard(Icons.inventory, "Total Quantity", product['quantity']?.toString() ?? '0', isDarkMode),
                              const SizedBox(width: 12),
                              _infoCard(Icons.shopping_cart, "Recent Orders", product['recentOrders']?.toString() ?? '0', isDarkMode),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Details Table
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: isDarkMode ? DarkTheme.whiteColor : AppTheme.whiteColor,
                            ),
                            child: Column(
                              children: [
                                _dataRow("Price", "Rs. ${product['price']?.toString() ?? '0'}", isDarkMode),
                                const Divider(),
                                _dataRow("Category", product['category']?.toString() ?? 'N/A', isDarkMode),
                                const Divider(),
                                _dataRow(
                                  "Stock",
                                  product['stock'] == true ? "In Stock" : "Out of Stock",
                                  isDarkMode,
                                  color: product['stock'] == true ? Colors.green : Colors.red,
                                ),
                                const Divider(),
                                _dataRow("Supplier", product['supplier']?.toString() ?? 'N/A', isDarkMode),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Right side: Product Image
                    Expanded(
                      flex: 1,
                      child: Container(
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
                          child: product['imageUrl'] != null && product['imageUrl'].toString().isNotEmpty
                              ? Image.network(
                            product['imageUrl'],
                            height: 300,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 300,
                              color: isDarkMode ? DarkTheme.backgroundColor : Colors.grey.shade200,
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                              ),
                            ),
                          )
                              : Container(
                            height: 300,
                            color: isDarkMode ? DarkTheme.backgroundColor : Colors.grey.shade200,
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Description (below both sections)
                Text(
                  "Description",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDarkMode ? DarkTheme.backgroundColor : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    product['description']?.toString() ?? "No description available.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value, bool isDarkMode) {
    return Container(
      width: 160,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDarkMode ? DarkTheme.primaryColor.withOpacity(0.1) : const Color(0xFFF7F6FF),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF8C1AFC),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.black54,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dataRow(String label, String value, bool isDarkMode, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: color ?? (isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.black87),
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}