import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_layout.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';


class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: ProductDetailsContent(product: product),
      currentPage: ProductDetailsPage,
    );
  }
}
class ProductDetailsContent extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsContent({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with back button + title + edit/delete buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button + Title
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Back',
                      onPressed: () {
                        Navigator.pop(context); // Go back to products_screen.dart
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "PID-${product['id'].toString().toUpperCase()} : ${product['name']}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Edit/Delete Buttons
              Row(
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      minimumSize: const Size(0, 30),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text('Edit', style: TextStyle(color: Colors.white)),
                    onPressed: () => _showEditDialog(context, product),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 145, 20, 11),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: const Size(0, 30),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text('Delete', style: TextStyle(color: Colors.white)),
                    onPressed: () => _confirmDelete(context),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Info Cards
          Row(
            children: [
              _infoCard(Icons.inventory, "Total Quantity", product['quantity'].toString(), width: 140, height: 60),
              const SizedBox(width: 12),
              _infoCard(Icons.shopping_cart, "Recent Orders", product['recentOrders'].toString(), width: 140, height: 60),
            ],
          ),

          const SizedBox(height: 20),

          // Details and Image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _dataRow("Price", "Rs. ${product['price']}"),
                      const Divider(),
                      _dataRow("Category", product['category']),
                      const Divider(),
                      _dataRow("Stock", product['stock'] ? "In Stock" : "Out of Stock",
                          color: product['stock'] ? Colors.green : Colors.red),
                      const Divider(),
                      _dataRow("Supplier", product['supplier']),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Right Column (Image)
              Expanded(
                flex: 1,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: product['imageUrl'] != null
                      ? Image.network(product['imageUrl'], fit: BoxFit.cover)
                      : const Text("Image", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Description
          const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              product['description'] ?? "No description available.",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// Info card widget
Widget _infoCard(IconData icon, String title, String value, {double width = 200, double height = 70}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.purple.shade50,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 24, color: Colors.purple),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    ),
  );
}

// Data row widget
Widget _dataRow(String label, String value, {Color? color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      Text(value, style: TextStyle(fontSize: 14, color: color ?? Colors.black87)),
    ],
  );
}

// Show edit dialog
void _showEditDialog(BuildContext context, Map<String, dynamic> product) {
  final nameController = TextEditingController(text: product['name']);
  final priceController = TextEditingController(text: product['price'].toString());
  final quantityController = TextEditingController(text: product['quantity'].toString());
  final supplierController = TextEditingController(text: product['supplier']);
  final descriptionController = TextEditingController(text: product['description'] ?? '');
  final categories = ['Monitoring Device', 'Therapeutic Device', 'Diagnostic Device'];

  String selectedCategory = categories.contains(product['category'])
      ? product['category']
      : categories.first;

  File? selectedImageFile;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        Future<void> pickImage() async {
          final result = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );
          if (result != null && result.files.single.path != null) {
            setState(() {
              selectedImageFile = File(result.files.single.path!);
            });
          }
        }

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            width: 750,
            height: 470,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Edit Product",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabeledField("Product Name", nameController),
                                _buildLabeledField("Price", priceController, inputType: TextInputType.number),
                                _buildDropdownField("Category", selectedCategory, categories, (val) {
                                  setState(() => selectedCategory = val!);
                                }),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildLabeledField("Quantity", quantityController,
                                          inputType: TextInputType.number),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _buildLabeledField("Suppliers", supplierController),
                                    ),
                                  ],
                                ),
                                _buildLabeledField("Description", descriptionController,
                                    minLines: 2, maxLines: 2),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: selectedImageFile != null
                                      ? Image.file(
                                    selectedImageFile!,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                      : product['imageUrl'] != null
                                      ? Image.network(
                                    product['imageUrl'],
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    height: 150,
                                    color: Colors.grey[200],
                                    child: const Center(child: Text("No Image")),
                                  ),
                                ),
                                IconButton(
                                  onPressed: pickImage,
                                  icon: const Icon(Icons.camera_alt),
                                  tooltip: 'Change Image',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel", style: TextStyle(fontSize: 14)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Save updated data
                          // selectedImageFile can be used here to upload the new image
                          Navigator.pop(context);
                        },
                        child: const Text("Save", style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}


Widget _buildLabeledField(String label, TextEditingController controller,
    {int minLines = 1, int maxLines = 1, TextInputType inputType = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          minLines: minLines,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDropdownField(String label, String value, List<String> options, void Function(String?) onChanged) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          items: options.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            isDense: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  );
}


// Confirm delete dialog
void _confirmDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this product?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Center( child:  Text("Product deleted."),),),
            );
            // Add your actual delete logic here.
          },
          style: ElevatedButton.styleFrom(backgroundColor:  Color.fromARGB(255, 151, 28, 19)),
          child: const Text("Delete"),
        ),
      ],
    ),
  );
}
