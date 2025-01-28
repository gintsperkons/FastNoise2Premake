project "FastNoise2"
	kind "StaticLib"
	language "C"

    targetdir ("%{wks.location}/Binaries/" .. OutputDir .. "/%{prj.name}")
    objdir ("%{wks.location}/Binaries/Intermediates/" .. OutputDir .. "/%{prj.name}")


        -- Include directories
    includedirs { "include" }

    -- Source 
    files {
        "include/*.h",
        "include/*.cpp",
        "include/FastSIMD/**.h",
        "include/FastSIMD/**.inl",
        "include/FastNoise/**.h",
        "include/FastNoise/**.inl",
        "src/FastNoise/**.cpp",
        
    }


    -- Apply /arch:AVX flag to specific files
    filter { "files:src/FastSIMD/FastSIMD_Level_AVX2.cpp" }
        buildoptions { "/arch:AVX" }

    filter { "files:src/FastSIMD/FastSIMD_Level_AVX512.cpp" }
        buildoptions { "/arch:AVX512" }


    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"