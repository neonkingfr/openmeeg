if [[ "$USE_PROJECT" == "0" ]]; then
    cd OpenMEEG
fi

mkdir build
cd build

# XXX : BUILD_SHARED should be used to set global defaults

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    if [[ "$USE_PROJECT" == "0" ]]; then
        # Build OpenMEEG and use openblas from homebrew
        # or use Atlas which maps to vecLib or Accelerate frameworks
        cmake \
            -DBUILD_SHARED:BOOL=ON \
            -DBUILD_DOCUMENTATION:BOOL=${BUILD_DOCUMENTATION} \
            -DBUILD_TESTING:BOOL=ON \
            -DENABLE_PYTHON:BOOL=${USE_PYTHON} \
            -DENABLE_PACKAGING:BOOL=ON \
            -DUSE_VTK:BOOL=${USE_VTK} \
            -DUSE_CGAL:BOOL=${USE_CGAL} \
            -DBLASLAPACK_IMPLEMENTATION:BOOL=${BLASLAPACK_IMPLEMENTATION} \
            -DCMAKE_SKIP_RPATH:BOOL=OFF \
            ..
    else
        cmake \
            -DBUILD_DOCUMENTATION:BOOL=${BUILD_DOCUMENTATION} \
            -DBUILD_TESTING:BOOL=ON \
            -DENABLE_PYTHON:BOOL=${USE_PYTHON} \
            -DENABLE_PACKAGING:BOOL=ON \
            -DUSE_VTK:BOOL=${USE_VTK} \
            -DUSE_CGAL:BOOL=${USE_CGAL} \
            -DBLASLAPACK_IMPLEMENTATION:BOOL=${BLASLAPACK_IMPLEMENTATION} \
            -DUSE_SYSTEM_matio:BOOL=${USE_SYSTEM} \
            -DUSE_SYSTEM_hdf5:BOOL=${USE_SYSTEM} \
            -DCMAKE_SKIP_RPATH:BOOL=OFF \
            ..
    fi
else
    if [[ "$USE_PROJECT" == "0" ]]; then
        # Build OpenMEEG with ATLAS or openblas
        cmake \
            -DBUILD_SHARED:BOOL=ON \
            -DBUILD_DOCUMENTATION:BOOL=${BUILD_DOCUMENTATION} \
            -DBUILD_TESTING:BOOL=ON \
            -DENABLE_PYTHON:BOOL=${USE_PYTHON} \
            -DENABLE_PACKAGING:BOOL=ON \
            -DUSE_VTK:BOOL=${USE_VTK} \
            -DUSE_CGAL:BOOL=${USE_CGAL} \
            -DBLASLAPACK_IMPLEMENTATION:BOOL=${BLASLAPACK_IMPLEMENTATION} \
            -DCMAKE_SKIP_RPATH:BOOL=OFF \
            ..
    else
        cmake \
            -DBUILD_DOCUMENTATION:BOOL=${BUILD_DOCUMENTATION} \
            -DBUILD_TESTING:BOOL=ON \
            -DENABLE_PYTHON:BOOL=${USE_PYTHON} \
            -DENABLE_PACKAGING:BOOL=ON \
            -DUSE_VTK:BOOL=${USE_VTK} \
            -DUSE_CGAL:BOOL=${USE_CGAL} \
            -DBLASLAPACK_IMPLEMENTATION:BOOL=${BLASLAPACK_IMPLEMENTATION} \
            -DUSE_SYSTEM_matio:BOOL=${USE_SYSTEM} \
            -DUSE_SYSTEM_hdf5:BOOL=${USE_SYSTEM} \
            -DUSE_SYSTEM_zlib:BOOL=${USE_SYSTEM} \
            -DCMAKE_SKIP_RPATH:BOOL=OFF \
            ..
    fi
fi

make

ctest -V
