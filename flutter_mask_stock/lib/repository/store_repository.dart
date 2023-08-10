import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/store.dart';

class StoreRepository {
  Future<List<Store>> fetch(double lat, double lng) async {
    final List<Store> stores = [];

    String urlString = 'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    Uri url = Uri.parse(urlString);

    try {

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
        final jsonStores = jsonResult['stores'];

        jsonStores.forEach((e) {
          if (e != null) {
            final store = Store.fromJson(e);

            if (store.lat != null && store.lng != null) {
              final meter = Geolocator.distanceBetween(
                store.lat!,
                store.lng!,
                lat ?? 0.0, // Provide a default value if lat is null
                lng ?? 0.0, // Provide a default value if lng is null
              );

              store.km = meter / 5000;
              stores.add(store);
            }
          }
        });

        print(stores);
        return stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).toList()
          ..sort((a, b) => a.km.compareTo(b.km));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
