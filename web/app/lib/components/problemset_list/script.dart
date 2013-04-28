import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';
import 'package:app/models.dart';
import 'dart:json';

part of "gf2components";

@observable
ObservableList<ProblemsetItem> problemsets = new ObservableList<ProblemsetItem>();

class ProblemsetListComponent extends WebComponent {
  
  int offset = 0;
  final int limit = 10;
  int num_results = 0;
  
  ProblemsetListComponent() {
    loadProblemsets(this.offset, this.limit);
  }
  
  loadProblemsets(offset, limit) {
    BaseJsonApi.get('a/get_problemsets', {"offset": offset, "limit": limit}).then((res) {
      List problemsets_json = res['results'];
      for (Map p in problemsets_json) {
        problemsets.add(new ProblemsetItem(p));
      }
      num_results = res['num_results'];
    });
  }
}

