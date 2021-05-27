import 'package:rare_pair/services/db/model.dart';

class CategoryTable extends Model {
  @override
  String table = 'categories';
  parent({int parent = 0}){
    return this.where('parent', isEqualTo: parent);
  }
}