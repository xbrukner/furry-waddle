#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef unsigned char uchar;

uchar hasStraight(char* str, uchar len) {
  char last = str[0];
  uchar count = 1;
  for (uchar i = 1; i < len; ++i) {
    if (last + 1 == str[i]) {
      count ++;
      if (count == 3) return 1;
    }
    else {
      count = 1;
    }
    last = str[i];
  }
  return 0;
}

uchar invalidChars(char* str, uchar len) {
  for (uchar i = 0; i < len; ++i) {
    if (str[i] == 'i' || str[i] == 'o' || str[i] == 'l') return 1;
  }
  return 0;
}

uchar findPair(char** str) {
  for (char last = '\0'; **str != '\0'; ++(*str)) {
    if (last == **str) {
      ++(*str);
      return 1;
    }
    last = **str;
  }
  return 0;
}

void increment(char* str, uchar len) {
  uchar i = len - 1;
  for(str[i]++; str[i] == 'z' + 1 && i; str[i]++) {
    str[i] = 'a';
    --i;
  }
  if (i == 0) {
    printf("Invalid: %s", str);
    exit(-1);
  }
}

int main() {
  char input[] = "vzbxkghb";
  uchar len = strlen(input);
  for(uchar count = 2; count; --count) {
    increment(input, len);
    for (char* s = input; invalidChars(input, len) ||
        !hasStraight(input, len) ||
        !(findPair(&s) && findPair(&s));
        s = input) {
      increment(input, len);
    }
  }
  printf("%s\n", input);
  return 0;
}
