import 'package:SuyuListening/entity/entities.dart';
import 'package:SuyuListening/net/translation_api.dart';
import 'package:flutter/material.dart';

class SearchModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SimpleWordEntity> _suggestions = history;
  List<SimpleWordEntity> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  void onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    _isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      _suggestions = history;
    } else {
      final features = await getSimpleWordListByPrefix(query, 20);
      // 判空
      if (features != null && features.isNotEmpty) {
        _suggestions = features;
      } else {
        _suggestions = [
          SimpleWordEntity(word: "Not Found", translation: "未搜索到")
        ];
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _suggestions = history;
    notifyListeners();
  }
}

List<SimpleWordEntity> history = [
  SimpleWordEntity(word: "abandon", translation: "抛弃放弃"),
  SimpleWordEntity(word: "main", translation: "主要的"),
  SimpleWordEntity(word: "system", translation: "系统"),
  SimpleWordEntity(
      word: "light", translation: "光;光线;光亮;(具有某种颜色和特性的)光;发光体;光源;(尤指)电灯"),
];
