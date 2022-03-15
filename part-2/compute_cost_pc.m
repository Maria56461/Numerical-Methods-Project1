function [cost] = compute_cost_pc(points, centroids)
  
  N = rows(points);
  NC = rows(centroids);
  distances = zeros(NC, N);
  
  for i = 1 : NC
    distances(i, :) = sqrt(sum(((points .- centroids(i, :)).^2)'));
  endfor
  
  cost = sum(min(distances));
   
endfunction

