#ifndef _KERNELS_H_
#define _KERNELS_H_


__global__ void per_row_kernel(int m,int n,int *A,int *B,int *C){
    unsigned long long int id = blockIdx.x * blockDim.x + threadIdx.x ;
    for(int ii=0;ii<n;ii++){
        if(id<m){
            C[id*n+ii] = A[id*n+ii] + B[id*n+ii];
        }
    }
}


__global__ void per_column_kernel(int m,int n,int *A,int *B,int *C){
    unsigned long long int id = blockIdx.x * blockDim.x * blockDim.y + threadIdx.x * blockDim.y + threadIdx.y ;
    for(int jj=0;jj<m;jj++){
        if(id<n){
            C[jj*n+id] = A[jj*n+id] + B[jj*n+id];
        }
    }
}

__global__ void per_element_kernel(int m,int n,int *A,int *B,int *C){
	unsigned long long int id = ( blockIdx.x * gridDim.y + blockIdx.y ) * blockDim.x * blockDim.y + threadIdx.x * blockDim.y + threadIdx.y ;
	if(id < m*n){
		int i = id/n;
		int j = id%n;
		C[i*n+j] = A[i*n+j] + B[i*n+j];
	}
}

#endif