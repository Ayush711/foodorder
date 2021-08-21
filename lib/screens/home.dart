import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_order/helpers/commons.dart';
import 'package:food_order/helpers/screen_navigation.dart';
import 'package:food_order/providers/app.dart';
import 'package:food_order/providers/category.dart';
import 'package:food_order/providers/product.dart';
import 'package:food_order/providers/restaurants.dart';
import 'package:food_order/providers/user.dart';
import 'package:food_order/screens/order.dart';
import 'package:food_order/screens/product_search.dart';
import 'package:food_order/screens/restaurant.dart';
import 'package:food_order/screens/restaurant_search.dart';
import 'package:food_order/widgets/categories..dart';
import 'package:food_order/widgets/custom_text.dart';
import 'package:food_order/widgets/featured_product.dart';
import 'package:food_order/widgets/loading.dart';
import 'package:food_order/widgets/restaurant.dart';

import 'package:provider/provider.dart';

import 'bags.dart';
import 'category.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    restaurantProvider.loadSingleRestaurant();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: Colors.deepOrange,
        title: CustomText(
          text: "FoodApp",
          color: white,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changescreen(context, CartScreen());
                },
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              accountName: CustomText(
                text: user.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {
                changescreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),

            ListTile(
              onTap: () async{
                await user.getOrders();
                changescreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                changescreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changescreenReplacment(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Loading()],
        ),
      )
          : SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: red,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern)async{
                        app.changeLoading();
                        if(app.search == SearchBy.PRODUCTS){
                          await productProvider.search(productName: pattern);
                          changescreen(context, ProductSearchScreen());
                        }else{
                          await restaurantProvider.search(name: pattern);
                          changescreen(context, RestaurantsSearchScreen());
                        }
                        app.changeLoading();
                      },
                      decoration: InputDecoration(
                        hintText: "Find food and restaurant",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomText(text: "Search by:", color: grey, weight: FontWeight.w300,),
                DropdownButton<String>(
                  value: app.filterBy,
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w300
                  ),
                  icon: Icon(Icons.filter_list,
                    color: Colors.deepOrange,),
                  elevation: 0,
                  onChanged: (value){
                    if (value == "Products"){
                      app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                    }else{
                      app.changeSearchBy(newSearchBy: SearchBy.RESTAURANTS);
                    }
                  },
                  items: <String>["Products", "Restaurants"].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value));
                  }).toList(),

                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
//                              app.changeLoading();
                        await productProvider.loadProductsByCategory(
                            categoryName:
                            categoryProvider.categories[index].name);

                        changescreen(
                            context,
                            CategoryScreen(
                              categoryModel:
                              categoryProvider.categories[index],
                            ));

//                              app.changeLoading();

                      },
                      child: CategoryWidget(
                        category: categoryProvider.categories[index],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: "Featured",
                    size: 20,
                    color: grey,
                  ),
                ],
              ),
            ),
            Featured(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: "Popular restaurants",
                    size: 20,
                    color: grey,
                  ),
                ],
              ),
            ),
            Column(
              children: restaurantProvider.restaurants
                  .map((item) => GestureDetector(
                onTap: () async {
                  app.changeLoading();

                  await productProvider.loadProductsByRestaurant(
                      restaurantId: item.id);
                  app.changeLoading();

                  changescreen(
                      context,
                      RestaurantScreen(
                        restaurantModel: item,
                      ));
                },
                child: RestaurantWidget(
                  restaurant: item,
                ),
              ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}