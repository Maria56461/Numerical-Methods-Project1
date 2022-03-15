function [G_J, c_J] = Jacobi_factorization(A, b)
  
  G_J = diag(diag(A).^(-1)) * (A - diag(diag(A))) * (-1);
  c_J = diag(diag(A).^(-1)) * b;
  
endfunction
