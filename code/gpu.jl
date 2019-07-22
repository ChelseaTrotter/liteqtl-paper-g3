# Calling GPU BLAS library
CuArrays.CUBLAS.gemm('T', 'N', a,b);

# Writing custom kernel for calculating LOD score 
# from correlation matrix
function lod_kernel(input, MAX,n)
  i = (blockIdx().x-1) * blockDim().x + threadIdx().x
  if(i < MAX+1)
    r_square = (input[i]/n)^2
    input[i] = (-n/Float64(2.0)) *  
               CUDAnative.log(Float64(1.0)-r_square)
  end
  return
end

# Launching GPU
@cuda blocks=1000 threads=64 
lod_kernel(input, MAX, n)
