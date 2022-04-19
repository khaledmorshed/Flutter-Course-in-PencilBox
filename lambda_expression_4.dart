import 'dart:web_audio';

void main() {
  add(5, 6, (a, b) {
    print(a + b);
  });
}

add(int a, int b, Function(int, int) action) {
  action(a, b);
}
