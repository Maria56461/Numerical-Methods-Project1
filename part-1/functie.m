function [X] = functie(t)
  X = zeros(9, 1);
  t = [0:1:8];
  for i = 1:9
  if t(1, i) < 5
    X(i, 1) = cos(t(1, i)) + 1;
  else if t(1, i) >= 5
    X(i, 1) = 5;
  endif
endif
endfor
endfunction
