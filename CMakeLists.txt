cmake_minimum_required(VERSION 3.16)

project(PassKeeper VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

set(nlohmann_json_DIR "C:\\Programs\\vcpkg\\packages\\nlohmann-json_x64-windows\\share\\nlohmann_json")
set(OpenSSL_DIR "C:\\Programs\\vcpkg\\packages\\openssl_x64-windows\\share\\openssl")



find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(nlohmann_json CONFIG REQUIRED)
find_package(OpenSSL REQUIRED)


qt_standard_project_setup(REQUIRES 6.5)



qt_add_executable(appPassKeeper
    main.cpp
    icons.qrc
)

qt_add_qml_module(appPassKeeper
    URI PassKeeper
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Default_Button.ui.qml InputElement.ui.qml
        QML_FILES DescElement.ui.qml
        RESOURCES icons.qrc
        SOURCES PassSafer.cpp PassSafer.h
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appPassKeeper PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPassKeeper
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appPassKeeper
    PRIVATE Qt6::Quick
)
target_link_libraries(appPassKeeper PRIVATE nlohmann_json::nlohmann_json)
target_link_libraries(appPassKeeper PRIVATE OpenSSL::SSL)
target_link_libraries(appPassKeeper PRIVATE OpenSSL::Crypto)

include(GNUInstallDirs)
install(TARGETS appPassKeeper
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
