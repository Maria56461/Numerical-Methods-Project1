function [w] = learn(X, y)
  
  Xp = [X ones(rows(X), 1)];
  w = ones(columns(Xp), 1);
  [Q, R] = Householder(Xp);
  w = SST(R, transpose(Q) * y);
  
end
