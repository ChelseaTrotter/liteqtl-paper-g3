## Example 1:

A = rand(1000,1000)
B = rand(1000,1000)
# Data transfer from CPU to GPU
d_a = CuArray(A)
d_b = CuArray(B)
# Do matrix multiplication on GPU by calling CuBLAS library.
d_c = CuArrays.CUBLAS.gemm('T', 'N', d_a,d_b);
# Data Transfer from GPU to CPU
C = collect(d_c)

## Example 2:

# Custom kernel to do a matrix element-wise calculation
function log_kernel(data, MAX)
  # calculating GPU thread ID
  i = (blockIdx().x-1) * blockDim().x + threadIdx().x
  # Check thread ID is in bound.
  if(i < MAX+1)
    # Call log function on GPU
    data[i] = CUDAnative.log(data[i])
  end
  return
end

# initialize and transfer data to GPU.
MAX = 64000
d_data = CuArray(rand(MAX))
# Launching GPU
d_res = @cuda blocks=1000 threads=64 log_kernel(data, MAX)
# Transfer result back to CPU
res = collect(d_res)
