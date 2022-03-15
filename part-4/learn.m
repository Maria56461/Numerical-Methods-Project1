function [w_opt] = learn(X, y, lr, epochs)
  
  X_scalat = (X - mean(X)) ./ std(X);
  X_tilda = [X_scalat ones(rows(X), 1)];
  N = length(y);
  w = rand(columns(X_tilda),1) * 0.2 - 0.1;
  w_opt = ones(columns(X_tilda), 1);
  
  for epoch = 1 : epochs 
    X_b = X_tilda(randperm(rows(X_tilda), 64), :);
    positions = find(ismember(X_tilda, X_b, "rows"));
    %vector cu indicii randurilor din X_tilda care se gasesc in X_batch
    y_b([1 : length(positions)], 1) = y(positions);
    for i = 1 : columns(X_b)
      w_opt(i) = w_opt(i) - (lr / N) * (sum((X_b * w .- y_b) .* X_b(:, i)))';
    endfor   
 endfor
 
endfunction
