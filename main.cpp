#include <iostream>
#include <string>
#include <windows.h>
#include <commdlg.h>
#include <fstream>
#include <glad/gl.h>
#include <GLFW/glfw3.h>
#include <regex>
#include <sstream>
#include <locale>
#include <codecvt>

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

// function updates the viewport size if user resizes window
void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
    glViewport(0, 0, width, height);
}
int main() {
    //parsing for only G0/G1/G2/G3
        std::wstring filepath = OpenFileDialog();
        if (filepath.empty()) {
            std::cout<<"no file selected\n";
            return 0;
        }
        std::string path(filepath.begin(), filepath.end());

        std::ifstream file(path);
        if (!file.is_open()) {
            std::cerr << "failed to open input file";
            return 1;
        }
        
        std::ofstream parsedFile("parsed.gcode");
        if (!parsedFile.is_open()) {
            std::cerr << "failed to open output file";
            return 1;
        }


        std::regex gotG("^G[0-3] ");
        std::regex semicolon(";.*$");
        std::string line;
        while (std::getline(file, line)) {
            if (std::regex_search(line, gotG)) {
                line = std::regex_replace(line, semicolon, "");
                parsedFile << line << "\n";
            }
            

            
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