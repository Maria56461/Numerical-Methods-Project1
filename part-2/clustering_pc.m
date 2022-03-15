function [centroids] = clustering_pc(points, NC)
  
  [N D] = size(points);
  % N puncte cu cate D coordonate 
  cluster_list = zeros(N, D);
  %vector de clustere
  centroids = zeros(NC, D);
  copy = zeros(NC, D);
  distances = zeros(NC, N);
  %vector de centroizi  
  a = 1;
  b = 1;
  
  for i = 1 : NC
  %parcurg lista de resturi posibile
    indici_linii = find(mod([1 : 1 : N], NC) == i - 1);
    l = length(indici_linii);
    %vector cu indicii care au restul impartirii la NC = i - 1 
    cluster_list([a : 1 : (l + a - 1)], :) = points(indici_linii, :);
    if rows(cluster_list([a : 1 : (l + a -1)], :)) > 1
      centroids(i, :) = sum(cluster_list([a : 1 : (l + a - 1)], :))./l; 
    else
      centroids(i, :) = cluster_list([a : 1 : (l + a - 1)], :);
    endif  
    a = l + 1;   
  endfor
  % initializare, am ales primii centroizi
 
  do 
  for i = 1 : NC 
   distances(i, :) = sqrt(sum(((points .- centroids(i, :)).^2)'));
    %pe prima linie, distanta de la fiecare punct la centroidul 1 
  endfor
  copy = centroids;
  cluster_list = zeros(N, D);
  for i = 1 : NC
    aux = b;
    for j = 1 : N
    %parcurg matricea de distante formata
      if distances(i, j) == (min(distances))(j)
        cluster_list(b, :) = points(j, :);
        %adaug punctul in cluster
        b = b + 1;
      endif   
    %parcurg toata linia -> am umplut clusterul i 
    %calculez centroidul pt clusterul i 
    endfor
    if rows(cluster_list([aux : 1 : (b - 1)], :)) > 1
      centroids(i, :) = sum(cluster_list([aux : 1 : (b - 1)], :))./(b - aux);
    else 
      centroids(i, :) = cluster_list([aux : 1 : (b - 1)], :);
    endif
  endfor
  until (centroids == copy)

endfunction
