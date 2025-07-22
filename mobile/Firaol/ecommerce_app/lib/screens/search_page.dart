import 'package:ecommerce_app/widgets/card.dart';
import 'package:flutter/material.dart';
import '../widgets/price_range.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.arrow_back_ios, color: Color(0xFF3F47FD)),
                Expanded(
                  child: Center(
                    child: Text('search product', style: TextStyle()),
                  ),
                ),

                SizedBox(width: 40),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('leather'),
                        Icon(Icons.arrow_forward, color: Color(0xFF3F47FD)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF3F47FD),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu, color: Colors.white),
                  ),
                ),
              ],
            ),
            Component(),
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/shoes.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Text('Catagory'),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ), // Set your desired border color
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                    ),
                  ),
                  Text('Price'),
                  PriceRange(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3F47FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4),
                        ),
                      ),
                      child: Text(
                        'APPLY',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
