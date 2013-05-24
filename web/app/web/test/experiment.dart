import 'dart:json';

abstract class A {
  int _a;
  List _l;
  set a(int x) => _a = getx(x);
  get a => _a;
  set list(List ll) => _l = ll;
  get list => _l;
  
  int getx(int x) {
    print('getx called.');
    return x+1;
  }
}

class B extends A {
  
}

main() {
  print("Hello world.");
  String ss = '[{"a": "1", "b": 2}]';
  List list = parse(ss);
  
  B b = new B();
  b.a = 1;
  print(b.a);
}