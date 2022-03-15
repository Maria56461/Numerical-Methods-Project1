function [A, b] = generate_probabilities_system(rows)
 
  n = rows * (rows + 1) / 2; 
  %A patratica, n linii si n coloane 
  
  A = zeros(n, n);
  k = ones(rows - 2, 1);
  p = ones(rows - 2, 1);
  b = zeros(n, 1);
  k(1) = 2;
  p(1) = 3;
  r = 1;
  c = 0;
  
  for j = 2 : rows - 2
    k(j) = k(j - 1) + j;
    p(j) = p(j - 1) + j + 1;
  endfor
  
  for q = 1 : rows - 2
    A(k(q), k(q)) = 5;
    A(p(q), p(q)) = 5;
    A(k(q), k(q) + 1) = -1;
    if q != rows - 2
      A(k(q), k(q + 1)) = -1;
      A(k(q), k(q + 1) + 1) = -1;
      A(p(q), p(q + 1)) = -1;
      A(p(q), (p(q + 1) - 1)) = -1;
    endif
    if q == rows - 2
      A(k(q), n - rows + 1) = -1;
      A(k(q), n - rows + 2) = -1;
      A(p(q), n) = -1;
      A(p(q), n - 1) = -1; 
    endif
  endfor
  
  for i = 1 : n
  % pun elementele de pe diagonala principala
    if (i > n + 1 - rows) && (i < n)
      A(i, i) = 5;
      A(i, i + 1) = -1;
      b(i) = 1;
    else if (i == 1) || (i == n) || (i == n - rows + 1)
      A(i, i) = 4;
      if (i == 1) || (i == n - rows + 1)
        A(i, i + 1) = -1;
      endif
      if i == 1
        A(i, i + 2) = -1;
      endif
      if (i == n) || (i == n - rows + 1)
        b(i) = 1;
      endif
    else if A(i, i) == 0
      A(i, i) = 6;
      A(i, i + 1) = -1;
    endif
    endif
    endif
    if A(i, i) == 6
      A(i, i + r + 2) = -1;
      A(i, i + r + 3) = -1;
      c = c + 1;
      if c == r
        r = r + 1;
        c = 0;
      endif
    endif
  endfor 
  
  B = diag(diag(A));
  A = A + A' - B;
  
endfunction