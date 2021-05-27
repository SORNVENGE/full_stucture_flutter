import 'database.dart';

class Model extends Database {

  Map attribute = {};
  Map original = {};
  Map relations = {};

  Model({
    this.attribute,
    this.original,
    this.table,
    this.relations});

  @override
  String table;

  id(){
    return this.attribute['docId'];
  }

  Map all() {
    return this.attribute;
  }

  noSuchMethod(Invocation invocation) {
    // attribute['name']
    if(invocation.isMethod){
      String arg = invocation.positionalArguments[0];
      if(this.attribute[arg] != null){
        return this.attribute[arg];
      }
    }

    // attribute.name
    if (invocation.isGetter) {
      String arg = invocation.memberName
        .toString()
        .split("\"")[1];
      
      if(this.attribute[arg] != null){
        if(this.attribute[arg] is List){
          return Collections(this.attribute[arg]);
        }
        return this.attribute[arg];
      }

    }

    // attribute.name = 'arg'
    if (invocation.isSetter) {
      String arg = invocation.positionalArguments[0];
      String prop = invocation.memberName
        .toString()
        .split("\"")[1]
        .replaceAll("=", "");

      this.attribute[prop] = arg;
    }

    return 'null';
  }

  Future<Model> save() async {
    await this.collectionRef
      .doc(this.id())
      .update({...this.attribute});
    
    return super.onUpdate(this);
  }

  Future<Model> create(Map data) async {
    String id = this.collectionRef.doc().id;

    await this.collectionRef.doc(id).set({...data, "docId": id});

    return super.onCreate(Model(
      attribute: {...data, "docId": id},
      original: {...data},
      table: table
    ));
  }

  Future<Model> delete() async {
    await this.collectionRef
      .doc(this.id())
      .delete();

      return super.onDelete(this);
  }

  Future<Model> update(Map data) async {
    
    this.attribute = {
      ...this.attribute,
      ...data
    };
    
    await this.collectionRef
      .doc(this.id())
      .update({...this.attribute});

    return super.onUpdate(this);
  }

  @override
  String toString() {
    return this.attribute.toString();
  }

}

class Collections
{
  List<dynamic> items;
  Collections(this.items);

  List<dynamic> data() {
    return this.items;
  }

  dynamic index(int index){
    return this.items[index];
  }

  dynamic at(int index){
    return this.items[index];
  }

  List<dynamic> where(field, {dynamic isEqualTo }){
    return this.items.where((item) => item[field] == isEqualTo).toList();
  }

  first(){
    return this.items[0];
  }

  last(){
    int index = (this.items.length - 1);
    return this.items[index];
  }

  int count() {
    return this.items.length;
  }
}