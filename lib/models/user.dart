
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item.dart';

class UserModel{
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const PRICESUM="priceSum";



  String _name;
  String _email;
  String _id;
  String _stripeId;
  int _priceSum = 0;
  int _quantitySum = 0;


//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;
  int get quantitySum => _quantitySum;
  int get pricesum => _priceSum;


//  public variable
  List<CartItemModel> cart;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.get(NAME);
    _email = snapshot.get(EMAIL);
    _id = snapshot.get(ID);
    _stripeId = snapshot.get(STRIPE_ID);
    _priceSum=snapshot.get(PRICESUM);
    cart = _convertCartItems(snapshot.get(CART)) ?? [];
    totalCartPrice = snapshot.get(CART) == null ? 0 :getTotalPrice(cart: snapshot.get(CART));
  }

  int getTotalPrice({List cart}){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }

    int total = _priceSum;

    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");

    return total;
  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
