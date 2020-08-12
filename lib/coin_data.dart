import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "https://rest.coinapi.io/v1/exchangerate";

String apiKey = "9DD345B9-3A79-4FA0-B617-43AB3E8D1601";
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getData(String country) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$url/$crypto/$country?apikey=$apiKey';
      print(requestURL);
      var response = await http.get(requestURL);
      if (response.statusCode == 200) {
        String data = response.body;

        var decodedData = jsonDecode(data);
        double lastprice = decodedData['rate'];
        cryptoPrices[crypto] = lastprice.toStringAsFixed(0);
        print(decodedData);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
