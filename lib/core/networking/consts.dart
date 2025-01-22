import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';

final String baseUrl = "https://student.valuxapps.com/api/";
final String token = 'token';
final headers = {
    'lang': 'en',
    'Authorization': CacheNetwork.getCacheData(key: token)
  };