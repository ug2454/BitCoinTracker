import 'dart:io' show Platform;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  CoinData coinData = CoinData();
  var bitCoinData;
  double price;
  int bitCoinPrice;
  Map<String, String> coinValues = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print('hello');
  }

  Future getData() async {
    bitCoinData = await coinData.getData(selectedCurrency);

    setState(() {
      coinValues = bitCoinData;
    });
  }

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text('$currency'),
        value: currency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: pickerItems);
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    }
    return androidDropdownButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
              cryptoCurrency: 'BTC',
              coinData: coinData,
              selectedCurrency: selectedCurrency,
              bitCoinPrice: coinValues['BTC']),
          CryptoCard(
              cryptoCurrency: 'ETH',
              coinData: coinData,
              selectedCurrency: selectedCurrency,
              bitCoinPrice: coinValues['ETH']),
          CryptoCard(
              cryptoCurrency: 'LTC',
              coinData: coinData,
              selectedCurrency: selectedCurrency,
              bitCoinPrice: coinValues['LTC']),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.coinData,
    @required this.selectedCurrency,
    @required this.bitCoinPrice,
    this.cryptoCurrency,
  }) : super(key: key);

  final CoinData coinData;
  final String selectedCurrency;
  final String bitCoinPrice;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: FutureBuilder(
            future: coinData.getData(selectedCurrency),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  '1 $cryptoCurrency = $bitCoinPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                );
              } else {
                return Center(
                  child: SpinKitDoubleBounce(
                    color: Colors.blue,
                    size: 23.0,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
