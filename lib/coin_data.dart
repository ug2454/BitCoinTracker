import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "https://rest.coinapi.io/v1/exchangerate/BTC";

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
    Map<String,String> cryptoPrices={};
    for(String crypto)
    var response = await http.get('$url/$country?apikey=$apiKey');
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);
      print(decodedData);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
