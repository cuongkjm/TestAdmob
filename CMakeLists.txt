cmake_minimum_required(VERSION 3.16)

project(TestAdmob VERSION 1.0 LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.2)
qt_policy(SET QTP0002 NEW)

add_subdirectory(Admob)

qt_add_executable(TestAdmob
    MANUAL_FINALIZATION
    main.cpp
    qml.qrc
)

set_property(TARGET TestAdmob PROPERTY AUTORCC ON)

target_link_libraries(TestAdmob
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::QuickControls2
        QtAdMob::qtadmob
)

if(ANDROID)
    set_property(TARGET TestAdmob PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
endif()

if(IOS)
    set(QT_NO_SET_DEFAULT_IOS_LAUNCH_SCREEN ON)
endif()

qtadmob_configure_android_target(TestAdmob)
qtadmob_configure_ios_target(TestAdmob)

qt_finalize_executable(TestAdmob)
