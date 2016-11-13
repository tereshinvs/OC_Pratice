#include <string>
#include <iostream>

int main() {
	std::string s;
	std::cin >> s;
	for (int i = 0; i < s.size(); i++) {
		if (s[i] >= 'A' && s[i] <= 'F')
			s[i] = s[i] - 'A' + 'a';
		if (i < s.size() - 1 && s[i] == 'x' && s[i + 1] == '0') {
			s.erase(i, 2);
			s.insert(i, "x(1)");
		}
		if (i < s.size() - 1 && s[i] == 'y' && s[i + 1] == '0') {
			s.erase(i, 2);
			s.insert(i, "x(2)");
		}
	}
	std::cout << s << std::endl;
}