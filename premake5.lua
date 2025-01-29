
-- FastNoise2 project
project "FastNoise2"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "On"
    targetdir ("%{wks.location}/Binaries/" .. OutputDir .. "/%{prj.name}")
    objdir ("%{wks.location}/Binaries/Intermediates/" .. OutputDir .. "/%{prj.name}")

flags { "Verbose" }


    -- Include directories
    includedirs {
        "include",
        "include/FastSIMD",
        "include/FastNoise",
        "src/FastNoise",
    }

    -- Define source files for FastSIMD and FastNoise2
    files {
        "include/**.inl",
        "src/FastNoise/**/*.cpp",
    }

    files {
            "src/FastSIMD/FastSIMD_Level_AVX2.cpp",
            "src/FastSIMD/FastSIMD_Level_AVX512.cpp",
            "src/FastSIMD/FastSIMD_Level_Scalar.cpp",
            "src/FastSIMD/FastSIMD_Level_SSE2.cpp",
            "src/FastSIMD/FastSIMD_Level_SSE3.cpp",
            "src/FastSIMD/FastSIMD_Level_SSE41.cpp",
            "src/FastSIMD/FastSIMD_Level_SSE42.cpp",
            "src/FastSIMD/FastSIMD_Level_SSSE3.cpp",
            "src/FastSIMD/FastSIMD.cpp",
        }

    defines {
        "FASTNOISE_EXPORT",
        "FASTSIMD_EXPORTS",
    }

    -- Additional files for FastNoise and FastNoise Generators
    files {
        "src/FastNoise/Metadata.cpp",
        "src/FastNoise/SmartNode.cpp",
        "src/FastNoise/FastNoise_C.cpp",
    }

    filter "system:linux"
        buildoptions { " -msse4.1", "-msse4.2","-mavx", "-mavx2", "-mavx512f", "-mavx512dq", "-m64", "-march=native" }

    

    filter "configurations:Release"
        buildoptions { "-O3", "-msse4.1", "-mavx2", "-m64" }  -- Release-specific optimizations

    filter "toolset:gcc or toolset:clang"
        buildoptions { "-fPIC" }


    -- Debug and Release configurations
    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"



