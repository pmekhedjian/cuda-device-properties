#include <iostream>
#include <cuda_runtime.h>

int main()
{
    int deviceCount = 0;
    cudaError_t err = cudaGetDeviceCount(&deviceCount);

    if (err != cudaSuccess)
    {
        std::cerr << "Error getting device count: " << cudaGetErrorString(err) << std::endl;
        return 1;
    }

    std::cout << "Number of CUDA-capable devices: " << deviceCount << std::endl;

    for (int i = 0; i < deviceCount; ++i)
    {
        cudaDeviceProp prop;
        err = cudaGetDeviceProperties(&prop, i);
        if (err != cudaSuccess)
        {
            std::cerr << "Error getting device properties: " << cudaGetErrorString(err) << std::endl;
            continue;
        }

        std::cout << "\nDevice " << i << ": " << prop.name << std::endl;
        std::cout << "  pageableMemoryAccess: " << prop.pageableMemoryAccess << std::endl;
        std::cout << "  hostNativeAtomicSupported: " << prop.hostNativeAtomicSupported << std::endl;
        std::cout << "  pageableMemoryAccessUsesHostPageTables: " << prop.pageableMemoryAccessUsesHostPageTables << std::endl;
        std::cout << "  directManagedMemAccessFromHost: " << prop.directManagedMemAccessFromHost << std::endl;
        std::cout << "  concurrentManagedAccess: " << prop.concurrentManagedAccess << std::endl;
        std::cout << "  managedMemory: " << prop.managedMemory << std::endl;

        bool fullUnifiedMemorySupport =
            prop.managedMemory &&
            prop.concurrentManagedAccess &&
            prop.pageableMemoryAccess &&
            prop.pageableMemoryAccessUsesHostPageTables &&
            prop.directManagedMemAccessFromHost &&
            prop.hostNativeAtomicSupported;

        if (prop.managedMemory)
        {
            if (fullUnifiedMemorySupport)
            {
                std::cout << "  => This device supports FULL CUDA Unified Memory." << std::endl;
            }
            else
            {
                std::cout << "  => This device supports PARTIAL CUDA Managed Memory." << std::endl;
            }
        }
        else
        {
            std::cout << "  => Managed Memory is not supported on this device." << std::endl;
        }
    }

    return 0;
}
