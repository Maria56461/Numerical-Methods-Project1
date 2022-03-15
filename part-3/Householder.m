function [Q, R] = Householder(A)
  
	[m n] = size(A);
	Q = eye(m);
  %initializare cu matrice identica pt a se putea face produsul 
  %cu reflectorul la primul pas 
	
	for p = 1 : min(m - 1, n)
		sigma = sign(A(p, p)) * sqrt(sum(A((p : m), p) .^ 2));
    %norma vectorului format pe coloana p a lui A, de la diag princ in jos 
    vp = zeros(m, 1);
    vp((p + 1) : m) = A((p + 1) : m, p);
		vp(p, 1) = A(p, p) + sigma;
    %vp are de la linia p + 1 in jos elementele de sub diag princ a lui A    
		if vp(p) != 0
    %daca nu am doar zerouri sub diagonala principala
    %efectuez reflector * matrice A
      A(p, p) = -sigma;
		  A((p + 1) : m, p) = 0;
      %se formeaza zerouri sub diagonala principala 
      %cum asta spune algoritmul, nu mai efectuam acele inmultiri
      for j = (p + 1) : n
		    aux =  vp(p : m) / (sigma * vp(p));
		    A(p : m, j) = A(p : m, j) - vp(p : m)' * A(p : m, j) * aux;
		  endfor
      R = A;
      %in urma inmultirii reflectorului cu A, toate coloanele de la p + 1 
      %la n se modifica asa  
		  for j = 1 : m
		    aux = vp(p : m)' * Q(p : m, j) * vp(p : m) / (sigma * vp(p));
		    Q(p : m, j) = Q(p : m, j) - aux;
		  endfor
      %inmultire reflector cu produsul reflectorilor de la pasul precedent 
     endif
  endfor
  
	Q = Q';
  
endfunction