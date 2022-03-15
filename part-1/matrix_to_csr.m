function [values, colind, rowptr] = matrix_to_csr(A)
  
  n = rows(A);
  m = columns(A);
  rowptr = zeros(1, n + 1);
  a = 1;
  b = 0;
  c = 1;
  
  for i = 1 : n
    for j = 1 : m
      if A(i, j) != 0
        values(a) = A(i, j);
        colind(a) = j;
        b = b + 1;
        if b == 1
          rowptr(c) = a;
          c = c + 1;
        endif
        a = a + 1;
      endif
    endfor
    b = 0;
  endfor 
  
  rowptr(n + 1) = a;
  
endfunction