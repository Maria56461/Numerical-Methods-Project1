function [y] = csr_multiplication(values, colind, rowptr, x)
 %matrice sparse descrisa prin 3 vectori 
 
  n = length(x);
  % n = length(rowptr) - 1 = numar de linii ale matricei
  
  y = zeros(n, 1);
  
  for i = 1 : n
  %parcurg vectorul rowptr pana la penultimul element 
  
    for j = rowptr(i) : rowptr(i + 1) - 1
    %parcurg vectorul values de la rowptr(i) pana la rowptr(i+1)-1 
    %astfel gasesc toate elementele nenule ale matricei de pe randul i 
    %parcurg la fel & simultan vectorul colind 
    %astfel gasesc toti indicii coloanelor elementelor nenule de pe randul i 
    %pentru fiecare j gasesc un element nenul de pe randul i - values(j) 
    %si indicele coloanei sale - colind(j) 
    
      y(i) = y(i) + values(j) * x(colind(j));
      %inmultesc randul i al matricei cu vectorul x 
    end
  end
endfunction