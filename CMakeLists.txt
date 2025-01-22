cmake_minimum_required(VERSION 3.21)

project(PassKeeper VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

if(ANDROID)
    # set(nlohmann_json_DIR "C:\\Users\\dexag\\OneDrive\\Desktop\\android-libs\\vcpkg_installed_x64_android\\x64-android\\share\\nlohmann_json")
    # set(cryptopp_DIR "C:\\Users\\dexag\\OneDrive\\Desktop\\android-libs\\vcpkg_installed_x64_android\\x64-android\\share\\cryptopp")

    set(nlohmann_json_DIR "C:\\Users\\dexag\\OneDrive\\Desktop\\android-libs\\arm64-android\\share\\nlohmann_json")
    set(cryptopp_DIR "C:\\Users\\dexag\\OneDrive\\Desktop\\android-libs\\arm64-android\\share\\cryptopp")

endif()

find_package(nlohmann_json CONFIG REQUIRED)
find_package(cryptopp CONFIG REQUIRED)

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
target_link_libraries(appPassKeeper PRIVATE cryptopp::cryptopp)

include(GNUInstallDirs)
install(TARGETS appPassKeeper
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
