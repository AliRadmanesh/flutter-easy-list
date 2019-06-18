import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/images/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product title'),
      initialValue: widget.product == null ? '' : widget.product['title'],
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.trim().length < 5) {
          return 'Title is required and should be 5+ characters long.'; // Return error message
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(labelText: 'Product description'),
      initialValue: widget.product == null ? '' : widget.product['description'],
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.trim().length < 10) {
          return 'Description is required and should be 10+ characters long.'; // Return error message
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      initialValue:
          widget.product == null ? '' : widget.product['price'].toString(),
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      // If validation failed, just return nothing :)
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        deviceWidth > 640.0 ? deviceWidth * 0.70 : deviceWidth * 0.90;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        // [ListView] items will always take the full available space,
        // so they don't take effect by MediaQuery size.
        // And instead of setting "width: targetWidth" in [Container]
        // we should use padding in [ListView]
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                // color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: _submitForm,
              ),
              // GestureDetector(
              //   onDoubleTap: _submitForm, // Many gestures can be handled here!
              //   child: Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('My Button'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
