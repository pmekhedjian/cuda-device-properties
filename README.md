# cuda-device-properties

**Background**: CUDA's Unified Memory makes it easy to program (and manage memory) for CUDA applications, but not all CUDA Managed Memory is Unified Memory. You should know what your Nvidia GPU supports before you start coding in CUDA. This repository houses CUDA applications (your choice of either CUDA C++ or CUDA Fortran) that test for device properties related to CUDA Unified and/or Managed Memory. 

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

**Example output**:

```
 Device             0 :NVIDIA RTX 4070
   pageableMemoryAccess                    :            1
   hostNativeAtomicSupported               :            0
   pageableMemoryAccessUsesHostPageTables  :            0
   directManagedMemAccessFromHost          :            0
   concurrentManagedAccess                 :            1
   managedMemory                           :            1
```

See reference table below, from Nvidia's CUDA documentation (linked below):

<img src="https://github.com/pmekhedjian/cuda-device-properties/blob/production/Unified%20Memory%20Support%20Levels.png">

Reference: [Nvidia documentation: CUDA C Programming Guide - System Requirements for Unified Memory](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#system-requirements-for-unified-memory)
