import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';
import '../models/auth.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  String _selProductId;
  User _authenticatedUser;
  bool _isLoading = false;
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    /*
      NOTE: For the sake of immuatability (The act of NOT mutating/editing our state from outside),
      we must return a brand new copy of out products list. Because lists in dart are refrences
      and if we don't want to change the original list, we have to return a new one.
      This logic only applies to [List]s not to [int], [String], ... types.
    */
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      // Just return favorite products
      return _products.where((Product product) => product.isFavorite).toList();
    }
    // Otherwise return all products
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  String get selectedProductId {
    return _selProductId;
  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  bool get showFavorites {
    return _showFavorites;
  }

  Future<bool> addProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();
    final String token = _authenticatedUser.token;
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://localtvkdvr.files.wordpress.com/2019/01/gettyimages-932817986-e1547580064551.jpg?quality=85&strip=all&w=400&h=225&crop=1',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    return http
        .post(
            'https://flutter-products-fbf3d.firebaseio.com/products.json?auth=$token',
            body: json.encode(productData))
        .then((http.Response response) {
      /*
        Response object has a "body" variable that is in JSON format
        and a "statusCode" that is an integer.
      */
      if (response.statusCode != 200 && response.statusCode != 201) {
        // There is something wrong on server side.
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Product newProduct = Product(
        id: responseData['name'],
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
      );
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();
    final String token = _authenticatedUser.token;
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'https://localtvkdvr.files.wordpress.com/2019/01/gettyimages-932817986-e1547580064551.jpg?quality=85&strip=all&w=400&h=225&crop=1',
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };
    return http
        .put(
            'https://flutter-products-fbf3d.firebaseio.com/products/${selectedProduct.id}.json?auth=$token',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
      );
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    final String token = _authenticatedUser.token;
    _selProductId = null;
    notifyListeners();
    return http
        .delete(
            'https://flutter-products-fbf3d.firebaseio.com/products/$deletedProductId.json?auth=$token')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchProducts() {
    final String token = _authenticatedUser.token;
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://flutter-products-fbf3d.firebaseio.com/products.json?auth=$token')
        .then<Null>((http.Response response) {
      // print(json.decode(response.body));
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      // print(productListData);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      } // if()
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          userEmail: productData['userEmail'],
          userId: productData['userId'],
        ); // Product()
        fetchedProductList.add(product);
      }); // ForEach()
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
      id: selectedProduct.id,
      title: selectedProduct.title,
      description: selectedProduct.description,
      price: selectedProduct.price,
      image: selectedProduct.image,
      isFavorite: newFavoriteStatus,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners(); // Rebuild current screen whenever that toggle function invoked! (like setState)
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    Map<String, dynamic> returnMessage = {
      'success': false,
      'message': 'Something went wrong :('
    };
    const String key = 'AIzaSyAwDLCA1WOhGLKgpQ88W-sDTgxEpVn4d0c';
    String url = mode == AuthMode.Login
        ? 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key='
        : 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=';
    return http
        .post(
      '$url$key',
      headers: {'Content-Type': 'application/json'},
      body: json.encode(authData),
    )
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      if (mode == AuthMode.Login) {
        if (responseData.containsKey('idToken')) {
          _authenticatedUser = User(
              id: responseData['localId'],
              email: responseData['email'],
              token: responseData['idToken']);
          returnMessage['success'] = true;
          returnMessage['message'] = 'You logged in successfully :)';
        } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
          returnMessage['message'] = 'Password is invalid.';
        } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
          returnMessage['message'] = 'This user did not exist.';
        }
      } else {
        if (responseData.containsKey('idToken')) {
          _authenticatedUser = User(
              id: responseData['localId'],
              email: responseData['email'],
              token: responseData['idToken']);
          returnMessage['success'] = true;
          returnMessage['message'] = 'You signed up successfully :)';
        } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
          returnMessage['message'] = 'This email already exists.';
        }
      }
      _isLoading = false;
      notifyListeners();
      return returnMessage;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return returnMessage;
    });
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
