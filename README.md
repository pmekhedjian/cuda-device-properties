# cuda-device-properties

**Background**: CUDA's Unified Memory makes it easier to program (and manage memory for) complex CUDA applications with CPU <-> GPU CUDA API calls, but not all CUDA Managed Memory is Unified Memory. You should know what your Nvidia GPU supports before you start coding in CUDA, as there are implications to what you can and cannot use during memory allocation. This repository houses CUDA applications (your choice of either CUDA C++ or CUDA Fortran) that test for device properties related to CUDA Unified and/or Managed Memory. 

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
$ ./get-properties

 Device 0 :NVIDIA GeForce RTX 4070
   pageableMemoryAccess                    :            0
   hostNativeAtomicSupported               :            0
   pageableMemoryAccessUsesHostPageTables  :            0
   directManagedMemAccessFromHost          :            0
   concurrentManagedAccess                 :            1
   managedMemory                           :            1
```
See reference table below, from Nvidia's CUDA documentation (linked below):

<img src="https://github.com/pmekhedjian/cuda-device-properties/blob/production/Unified%20Memory%20Support%20Levels.png">

Bonus:

As noted in the CUDA C Programming Guide, `pageableMemoryAccess` is "_set to 1 on systems with CUDA Unified Memory support where all threads may access System-Allocated Memory and CUDA Managed Memory. These systems include NVIDIA Grace Hopper, IBM Power9 + Volta, and modern Linux systems with HMM enabled._"

Say what, if I have `managedMemory` and `concurrentManagedAccess` set to 1, but `pageableMemoryAccess` is 0 by default, I can unlock a different CUDA device property as seen by my CUDA + Linux stack if I just toggle some Linux-side software? That can't be right, can it? I'm interested! Tell me more!

_"Linux HMM requires Linux kernel version 6.1.24+, 6.2.11+ or 6.3+, devices with compute capability 7.5 or higher and a CUDA driver version 535+ installed with Open Kernel Modules."_

**After having switched to Open Kernel Modules on CUDA v12.2, driver version 535+ on kernel ~6.8**:

```
$ ./get-properties

 Device 0 :NVIDIA GeForce RTX 4070
   pageableMemoryAccess                    :            1
   hostNativeAtomicSupported               :            0
   pageableMemoryAccessUsesHostPageTables  :            0
   directManagedMemAccessFromHost          :            0
   concurrentManagedAccess                 :            1
   managedMemory                           :            1
```
So cool! Learn more about HMM for GPU development with CUDA [here](https://developer.nvidia.com/blog/simplifying-gpu-application-development-with-heterogeneous-memory-management/). 

p.s. Did you know that you can still use HMM on Linux kernel 4.x and 5.x? Google to find out more.

References: 

- [Paul Mekhedjian - Personal Website - CUDA: Unified vs. Managed Memory](https://paulmekhedjian.com/2025/02/cuda-unified-vs-managed-memory/)
- [Nvidia documentation: CUDA C Programming Guide - System Requirements for Unified Memory](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#system-requirements-for-unified-memory)
- [Nvidia blog: Simplifying GPU Application Development with Heterogeneous Memory Management](https://developer.nvidia.com/blog/simplifying-gpu-application-development-with-heterogeneous-memory-management/)
