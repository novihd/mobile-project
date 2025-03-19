import 'package:flutter/material.dart';
import 'package:klontong/features/products/data/models/product_payload.dart';
import 'package:klontong/features/products/persentation/provider/add_product_notifier.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddProductNotifier>(context);
    final formKey = GlobalKey<FormState>();

    final TextEditingController categoryNameController = TextEditingController();
    final TextEditingController skuController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController widthController = TextEditingController();
    final TextEditingController lengthController = TextEditingController();
    final TextEditingController heightController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController stockController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();
    final TextEditingController soldController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: categoryNameController,
                decoration: decoration("Category Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: skuController,
                decoration: decoration("SKU"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: nameController,
                decoration: decoration("Product Name"),
                validator: (value) => value!.isEmpty ? "Enter product name" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                decoration: decoration("Description"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: weightController,
                decoration: decoration("Weight"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: widthController,
                decoration: decoration("Width"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: lengthController,
                decoration: decoration("Length"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: heightController,
                decoration: decoration("Height"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: priceController,
                decoration: decoration("Price"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: stockController,
                decoration: decoration("Stock"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: ratingController,
                decoration: decoration("Rating"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: soldController,
                decoration: decoration("Sold"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                }
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      provider.postAddProduct(
                        ProductPayload(
                          categoryId: 2, 
                          categoryName: categoryNameController.text, 
                          sku: skuController.text, 
                          name: nameController.text, 
                          description: descriptionController.text, 
                          weight: int.tryParse(weightController.text) ?? 0, 
                          width: int.tryParse(widthController.text) ?? 0,
                          length: int.tryParse(lengthController.text) ?? 0, 
                          height: int.tryParse(heightController.text) ?? 0, 
                          image: 'image_${nameController.text}', 
                          price: int.tryParse(priceController.text) ?? 0,
                          stock: int.tryParse(stockController.text) ?? 0,
                          rating: double.tryParse(ratingController.text) ?? 0.0,
                          sold: int.tryParse(soldController.text) ?? 0)).then((v) {
                            Navigator.pop(context);
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Add Product",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }
}
