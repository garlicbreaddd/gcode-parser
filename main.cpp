#include <iostream>
#include <string>
#include <windows.h>
#include <commdlg.h>
#include <fstream>

std::wstring OpenFileDialog() {
    wchar_t filename[MAX_PATH] = L"";

    OPENFILENAMEW ofn = {0};
    ofn.lStructSize = sizeof(ofn);
    ofn.lpstrFile = filename;
    ofn.nMaxFile = MAX_PATH;
    ofn.lpstrFilter = L"GCode Files\0*.gcode\0\0";
    ofn.Flags = OFN_FILEMUSTEXIST | OFN_PATHMUSTEXIST;

    if (GetOpenFileNameW(&ofn)) {
        return std::wstring(filename);
    } else return L"";
}

int main() {
    std::wstring filepath = OpenFileDialog();
    if (filepath.empty()) {
        std::cout<<"no file selected\n";
        return 0;
    }

    std::string path(filepath.begin(), filepath.end());
    std::ifstream file(path);

    if (!file) {
        std::cerr << "couldn't open file\n";
        return 1;
    }

    std::string line;

    while (std::getline(file,line)) {
        std::cout << line << "\n";
    }
    file.close();

}