# cuda-device-properties

**Background**: CUDA's Unified Memory makes it incredibly easy to program for GPU application, but not all CUDA Managed Memory is Unified Memory. You should know what your Nvidia GPU supports before you start coding in CUDA. This repository houses CUDA applications (your choice of either CUDA C++ or CUDA Fortran) that test for device properties related to CUDA Unified and/or Managed Memory. 

The following parameters are queried from the [**cudaDeviceProp**](https://docs.nvidia.com/cuda/cuda-runtime-api/structcudaDeviceProp.html#structcudaDeviceProp) struct:
- pageableMemoryAccess
- hostNativeAtomicSupported
- pageableMemoryAccessUsesHostPageTables
- directManagedMemAccessFromHost
- concurrentManagedAccess
- managedMemory

**For CUDA C++**:
```
nvcc -o get-properties get-properties.cu
```
**For CUDA Fortran**:
```
nvfortran -o get-properties get-properties.cuf
```
The nvcc and nvfortran commands are available (for free) from the [Nvidia HPC SDK](https://developer.nvidia.com/hpc-sdk) website. 

Reference: [Nvidia documentation - System Requirements for Unified Memory](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#system-requirements-for-unified-memory)
