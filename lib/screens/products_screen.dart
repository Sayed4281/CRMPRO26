import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/dark_theme.dart';
import 'main_layout.dart';
import 'product_details.dart';
import 'add_product_dialog.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedStockFilter = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 1;
  final int productsPerPage = 3;
  List<Map<String, dynamic>> products = [
    {
      'index': '01',
      'id': '223',
      'name': 'ECG Machine',
      'category': 'Monitoring Device',
      'price': 25000,
      'quantity': 100,
      'supplier': 'BPL Medical Technologies',
      'stock': true,
      'recentOrders': 75,
      'description': 'ECG Machine is a compact, portable 12-lead electrocardiographic device...',
      'imageUrl': 'https://example.com/ecg_machine.jpg',
    },
    {
      'index': '02',
      'id': '224',
      'name': 'Ultrasound Scanner',
      'category': 'Diagnostic Device',
      'price': 200000,
      'quantity': 50,
      'supplier': 'Philips Healthcare India',
      'stock': true,
      'recentOrders': 30,
      'description': 'Ultrasound Scanner for high-resolution imaging...',
      'imageUrl': null,
    },
    {
      'index': '03',
      'id': '225',
      'name': 'Defibrillator',
      'category': 'Therapeutic Device',
      'price': 150000,
      'quantity': 20,
      'supplier': 'Medtronic India',
      'stock': false,
      'recentOrders': 10,
      'description': 'Automated external defibrillator for emergency use...',
      'imageUrl': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleStock(int index) {
    setState(() {
      products[index]['stock'] = !(products[index]['stock'] as bool);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MainLayout(
      currentPage: ProductsScreen,
      content: Container(
        color: isDarkMode ? DarkTheme.backgroundColor : const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Dashboard > Products',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: isDarkMode ? DarkTheme.textColor : const Color.fromARGB(255, 1, 7, 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSummaryCard('Total Products', products.length.toString(), Icons.inventory, isDarkMode),
                      const SizedBox(width: 8),
                      _buildSummaryCard('In Stock', products.where((p) => p['stock'] == true).length.toString(), Icons.check_circle, isDarkMode),
                      const SizedBox(width: 8),
                      _buildSummaryCard('Out of Stock', products.where((p) => p['stock'] != true).length.toString(), Icons.error, isDarkMode),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Products List',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 800,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name, ID',
                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFD9D9D9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFD9D9D9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF6C5DD3),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black54,
                        builder: (BuildContext context) {
                          return AddProductDialog(
                            products: products,
                            onSave: (newProduct) {
                              setState(() {
                                products.add(newProduct);
                                int totalPages = (products.length / productsPerPage).ceil();
                                if (currentPage > totalPages && totalPages > 0) {
                                  currentPage = totalPages;
                                }
                              });
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                    ),
                    label: Text(
                      'Add Product',
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _buildFilterButton('All', isDarkMode),
                  _buildFilterButton('In Stock', isDarkMode),
                  _buildFilterButton('Out of Stock', isDarkMode),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : const Color(0xFFE8E8E8),
                      ),
                    ),
                    defaultColumnWidth: const FixedColumnWidth(150),
                    children: [
                      TableRow(
                        children: [
                          _buildTableHeader('Sl No', TextAlign.center, isDarkMode),
                          _buildTableHeader('Product ID', TextAlign.center, isDarkMode),
                          _buildTableHeader('Product Name', TextAlign.left, isDarkMode),
                          _buildTableHeader('Category', TextAlign.center, isDarkMode),
                          _buildTableHeader('Price', TextAlign.center, isDarkMode),
                          _buildTableHeader('Supplier', TextAlign.center, isDarkMode),
                          _buildTableHeader('Stock', TextAlign.center, isDarkMode),
                        ],
                      ),
                      ..._buildFilteredTableRows(isDarkMode),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: currentPage > 1
                        ? () {
                      setState(() {
                        currentPage--;
                      });
                    }
                        : null,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_left,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                        Text(
                          'Previous',
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ..._buildPageNumbers(isDarkMode),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: currentPage < (products.length / productsPerPage).ceil()
                        ? () {
                      setState(() {
                        currentPage++;
                      });
                    }
                        : null,
                    child: Row(
                      children: [
                        Text(
                          'Next',
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, bool isDarkMode) {
    return Card(
      elevation: 2,
      color: isDarkMode ? DarkTheme.whiteColor : const Color(0xFFF7F6FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 140,
        height: 108,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDarkMode ? DarkTheme.accentColor : const Color(0xFF8C1AFC),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDarkMode ? DarkTheme.textColor.withOpacity(0.7) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, bool isDarkMode) {
    return ChoiceChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isDarkMode
                ? selectedStockFilter == label
                ? DarkTheme.textColor
                : DarkTheme.textColor.withOpacity(0.7)
                : selectedStockFilter == label
                ? AppTheme.textColor
                : AppTheme.secondaryTextColor,
          ),
        ),
      ),
      selected: selectedStockFilter == label,
      selectedColor: isDarkMode ? DarkTheme.primaryColor.withOpacity(0.2) : Colors.transparent,
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isDarkMode ? DarkTheme.textColor.withOpacity(0.3) : Colors.transparent,
      ),
      labelStyle: GoogleFonts.poppins(
        color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        fontWeight: selectedStockFilter == label ? FontWeight.w600 : FontWeight.normal,
      ),
      onSelected: (selected) {
        setState(() {
          selectedStockFilter = label;
          currentPage = 1;
        });
      },
    );
  }

  Widget _buildTableHeader(String title, TextAlign alignment, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
        ),
        textAlign: alignment,
      ),
    );
  }

  List<TableRow> _buildFilteredTableRows(bool isDarkMode) {
    List<Map<String, dynamic>> filteredProducts = selectedStockFilter == 'All'
        ? products
        : selectedStockFilter == 'In Stock'
        ? products.where((product) => product['stock'] == true).toList()
        : products.where((product) => product['stock'] != true).toList();

    if (searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts.where((product) {
        final name = product['name']!.toLowerCase();
        final productId = 'PID-${product['id']}'.toLowerCase();
        return name.contains(searchQuery) || productId.contains(searchQuery);
      }).toList();
    }

    final startIndex = (currentPage - 1) * productsPerPage;
    final endIndex = startIndex + productsPerPage;
    final paginatedProducts = filteredProducts.asMap().entries.where((entry) => entry.key >= startIndex && entry.key < endIndex).toList();

    return paginatedProducts.map((entry) {
      int filteredIndex = entry.key;
      Map<String, dynamic> product = entry.value;
      // Find the original index in the products list
      int originalIndex = products.indexWhere((p) => p['id'] == product['id']);

      return TableRow(
        decoration: const BoxDecoration(),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: Map<String, dynamic>.from(product),
                    onDelete: () {
                      setState(() {
                        products.removeAt(originalIndex);
                        for (int i = 0; i < products.length; i++) {
                          products[i]['index'] = (i + 1).toString().padLeft(2, '0');
                        }
                        int totalPages = (products.length / productsPerPage).ceil();
                        if (currentPage > totalPages && totalPages > 0) {
                          currentPage = totalPages;
                        }
                      });
                    },
                    onUpdate: (updatedProduct) {
                      setState(() {
                        products[originalIndex] = updatedProduct;
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(
                product['index']!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: Map<String, dynamic>.from(product),
                    onDelete: () {
                      setState(() {
                        products.removeAt(originalIndex);
                        for (int i = 0; i < products.length; i++) {
                          products[i]['index'] = (i + 1).toString().padLeft(2, '0');
                        }
                        int totalPages = (products.length / productsPerPage).ceil();
                        if (currentPage > totalPages && totalPages > 0) {
                          currentPage = totalPages;
                        }
                      });
                    },
                    onUpdate: (updatedProduct) {
                      setState(() {
                        products[originalIndex] = updatedProduct;
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(
                'PID-${product['id']}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: Map<String, dynamic>.from(product),
                    onDelete: () {
                      setState(() {
                        products.removeAt(originalIndex);
                        for (int i = 0; i < products.length; i++) {
                          products[i]['index'] = (i + 1).toString().padLeft(2, '0');
                        }
                        int totalPages = (products.length / productsPerPage).ceil();
                        if (currentPage > totalPages && totalPages > 0) {
                          currentPage = totalPages;
                        }
                      });
                    },
                    onUpdate: (updatedProduct) {
                      setState(() {
                        products[originalIndex] = updatedProduct;
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(
                product['name']!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: Map<String, dynamic>.from(product),
                    onDelete: () {
                      setState(() {
                        products.removeAt(originalIndex);
                        for (int i = 0; i < products.length; i++) {
                          products[i]['index'] = (i + 1).toString().padLeft(2, '0');
                        }
                        int totalPages = (products.length / productsPerPage).ceil();
                        if (currentPage > totalPages && totalPages > 0) {
                          currentPage = totalPages;
                        }
                      });
                    },
                    onUpdate: (updatedProduct) {
                      setState(() {
                        products[originalIndex] = updatedProduct;
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(
                product['category']!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: Map<String, dynamic>.from(product),
                    onDelete: () {
                      setState(() {
                        products.removeAt(originalIndex);
                        for (int i = 0; i < products.length; i++) {
                          products[i]['index'] = (i + 1).toString().padLeft(2, '0');
                        }
                        int totalPages = (products.length / productsPerPage).ceil();
                        if (currentPage > totalPages && totalPages > 0) {
                          currentPage = totalPages;
                        }
                      });
                    },
                    onUpdate: (updatedProduct) {
                      setState(() {
                        products[originalIndex] = updatedProduct;
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(
                'Rs. ${product['price']}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: Map<String, dynamic>.from(product),
                    onDelete: () {
                      setState(() {
                        products.removeAt(originalIndex);
                        for (int i = 0; i < products.length; i++) {
                          products[i]['index'] = (i + 1).toString().padLeft(2, '0');
                        }
                        int totalPages = (products.length / productsPerPage).ceil();
                        if (currentPage > totalPages && totalPages > 0) {
                          currentPage = totalPages;
                        }
                      });
                    },
                    onUpdate: (updatedProduct) {
                      setState(() {
                        products[originalIndex] = updatedProduct;
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Text(
                product['supplier']!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? DarkTheme.textColor : AppTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: GestureDetector(
              onTap: () => _toggleStock(originalIndex),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: product['stock'] == true ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  product['stock'] == true ? 'In Stock' : 'Out of Stock',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  List<Widget> _buildPageNumbers(bool isDarkMode) {
    final totalPages = (products.length / productsPerPage).ceil();
    List<Widget> pageNumbers = [];
    for (int i = 1; i <= totalPages && i <= 3; i++) {
      pageNumbers.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildPageNumber(i, isDarkMode),
        ),
      );
    }
    return pageNumbers;
  }

  Widget _buildPageNumber(int number, bool isDarkMode) {
    bool isSelected = currentPage == number;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = number;
        });
      },
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: isSelected
            ? BoxDecoration(
          color: isDarkMode ? DarkTheme.primaryColor : const Color(0xFF6C5DD3),
          borderRadius: BorderRadius.circular(4),
        )
            : null,
        child: Text(
          number.toString(),
          style: GoogleFonts.poppins(
            color: isSelected
                ? (isDarkMode ? DarkTheme.textColor : AppTheme.whiteColor)
                : (isDarkMode ? DarkTheme.textColor : AppTheme.textColor),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}