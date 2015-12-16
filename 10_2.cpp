#include <string>
#include <sstream>
#include <iostream>

std::string look_and_say(const std::string& input) {
  std::stringstream res;
  unsigned count = 1;
  char last = input[0];
  const unsigned len = input.size();
  for (unsigned i = 1; i < len; ++i) {
    if (last == input[i]) {
      count ++;
    }
    else {
      res << count << last;
      last = input[i];
      count = 1;
    }
  }
  res << count << last;
  return res.str();
}

int main() {
  std::string str = "3113322113";

  for (unsigned i = 0; i < 50; ++i) {
    str = look_and_say(str);
    std::cout << i << ": " << str.size() << std::endl;
  }
  return 0;
}
