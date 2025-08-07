#include <iostream>
#include <string>
#include <windows.h>
#include <commdlg.h>
#include <fstream>
#include <glad/gl.h>
#include <GLFW/glfw3.h>
#include <regex>
#include <variant>

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

struct Point {
    float x,y,z;
};

struct Linearmove {
    Point endpos;
};
struct Arcmove {
    Point endpos;
    float i, j;
    bool isclockwise;
};

void PrintMove(const Linearmove& move) {
    std::cout << "LINEAR MOVE: ";
    std::cout << "End=(" << move.endpos.x << ", " << move.endpos.y << ", " << move.endpos.z << ") ";
    std::cout << "\n";
}

void PrintMove(const Arcmove& move) {
    std::cout << "ARC MOVE: ";
    std::cout << "End=(" << move.endpos.x << ", " << move.endpos.y << ", " << move.endpos.z << ") ";
    std::cout << "X-offset for arc: " << move.i << " Y-offset for arc: " << move.j << ((move.isclockwise) ? "clockwise" : "counterclock");
    std::cout << "\n";

}

// function updates the viewport size if user resizes window
void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
    glViewport(0, 0, width, height);
}
int main() {
    std::wstring filepath = OpenFileDialog();
    if (filepath.empty()) {
        std::cout<<"no file selected\n";
        return 0;
    }
    std::string path(filepath.begin(), filepath.end());

    std::ifstream file(path);
    if (!file.is_open()) {
        std::cerr << "failed to open input file\n";
        return 1;
    }
    
    std::ofstream parsedFile("parsed.gcode");
    if (!parsedFile.is_open()) {
        std::cerr << "failed to open output file\n";
        return 1;
    }

    //parse for G commands and take out comments
    std::regex gotG("^G[0-3] ");
    std::regex semicolon(";.*$");
    std::string line;
    while (std::getline(file, line)) {
        if (std::regex_search(line, gotG)) {
            line = std::regex_replace(line, semicolon, "");
            parsedFile << line << "\n";
        }
    }
    parsedFile.close();

    std::ifstream endParsedFile("parsed.gcode");

    using gcodemoves = std::variant<Linearmove, Arcmove>;

    std::vector<gcodemoves> allmoves;

    float xtopush = 0;
    float ytopush = 0;
    float ztopush = 0;
    float itopush = 0;
    float jtopush = 0;
    while (std::getline(endParsedFile, line)) {

        int posX = line.find('X');
        int posY = line.find('Y');
        int posZ = line.find('Z');
        int posI = line.find('I');
        int posJ = line.find('J');

        if (posX != std::string::npos) {
            std::string substr = line.substr(posX+1);
            xtopush = stof(substr.substr(0, substr.find_first_not_of("-.0123456789")));
        }
        if (posY != std::string::npos) {
            std::string substr = line.substr(posY+1);
            ytopush = stof(substr.substr(0, substr.find_first_not_of("-.0123456789")));
        }
        if (posZ != std::string::npos) {
            std::string substr = line.substr(posZ+1);
            ztopush = stof(substr.substr(0, substr.find_first_not_of("-.0123456789")));
        }
        if (posI != std::string::npos) {
            std::string substr = line.substr(posI+1);
            itopush = stof(substr.substr(0, substr.find_first_not_of("-.0123456789")));
        }
        if (posJ != std::string::npos) {
            std::string substr = line.substr(posJ+1);
            jtopush = stof(substr.substr(0, substr.find_first_not_of("-.0123456789")));
        }
        if (line.substr(0,2) == "G0" || line.substr(0,2) == "G1") {
            allmoves.push_back(Linearmove{{xtopush, ytopush, ztopush}});
        }
        if (line.substr(0,2) == "G2") {
            allmoves.push_back(Arcmove{{xtopush, ytopush, ztopush}, itopush, jtopush, true});
        } else if (line.substr(0,2) == "G3") {
            allmoves.push_back(Arcmove{{xtopush, ytopush, ztopush}, itopush, jtopush, false});
        }
    }
    endParsedFile.close();


    for (const auto& move : allmoves) {
        std::visit([](const auto& m) {PrintMove(m);}, move);

    }
    //one-time GLFW and GLAD setup code
    /*
        if (!glfwInit()) {
            std::cerr << "glfw didn't init";
            return 1;
        }

        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
        glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

        GLFWwindow* window = glfwCreateWindow(800,600, "gcode visualization", nullptr, nullptr);

        if (!window) {
            std::cerr << "failed to load window";
            glfwTerminate();
        }

        glfwMakeContextCurrent(window);

        if (!gladLoadGL((GLADloadfunc)glfwGetProcAddress)) {
            std::cerr << "Failed to initialize GLAD\n";
            return -1;
        }
        glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
        glViewport(0,0,800,600); //change window dimensions here


        //loop until user closes window
        while (!glfwWindowShouldClose(window)) {
            glClearColor(0.1f, 0.1f, 0.2f, 1.0f);
            glClear(GL_COLOR_BUFFER_BIT);
            glfwSwapBuffers(window);
            glfwPollEvents();
        }*/
        


    
}