function [X] = SST(A, b)
  
  [r c] = size(A);
   
  if r >= c
  %daca nr. de linii este mai mic decat numarul de coloane, 
  %sistemul nu se poate rezolva 
    X(c) = b(c) / A(c,c);  
    for i = c : (-1) : 1
      %pornesc de la x_c in sus 
      s = 0;
      for j = (i + 1) : c
        s = s + A(i, j) * X(j);
      endfor
      X(i) = (b(i) - s) / A(i, i);
      %mereu impart la elementele de pe diagonala principala 
    endfor  
    X = X';
    %returnez vector coloana 
  endif
    
endfunction
    
   