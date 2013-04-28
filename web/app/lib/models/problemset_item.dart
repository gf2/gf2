part of models;

/**
 * Problemset item in the problemset list.
 */
@observable
class ProblemsetItem {
  
  Map data;
  String name;
  String problemset_id;
  bool is_free;
  bool has_paid;
  bool has_completed;
  
  ProblemsetItem(Map data) {
    data = data;
    name = data['name'];
    problemset_id = data['problemset_id'];
    is_free = data['is_free'];
    has_paid = data['has_paid'];
    has_completed = data['has_completed'];
  }
}
