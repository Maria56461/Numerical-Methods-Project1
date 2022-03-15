function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  
  Cats = length(dir(fullfile(strcat(path_to_dataset, '/cats/'), '*.jpg'))); 
  %numarul de imagini cu pisici din director 
  No_c = length(dir(fullfile(strcat(path_to_dataset, '/not_cats/'), '*.jpg')));
  %numarul de imagini fara pisici din director
  N = Cats + No_c;
  %numarul de imagini din director
  M = 3 * count_bins;
  X = ones(N, M);
  y = ones(N, 1);
  Names_c = {dir(fullfile(strcat(path_to_dataset, '/cats/'), '*.jpg')).name}';
  %cell cu 'Cats' linii si 1 coloana care contine numele imaginilor cu pisici 
  N_nc = {dir(fullfile(strcat(path_to_dataset, '/not_cats/'), '*.jpg')).name}';
  %cell cu 'No_c' linii si 1 coloana care contine numele imaginilor fara pisici
  PATH1 = char(strcat(path_to_dataset, '/cats/', Names_c));
  % array de cai (stringuri) catre imaginile cu pisici din director
  PATH2 = char(strcat(path_to_dataset, '/not_cats/', N_nc));
  % array de cai (stringuri) catre imaginile fara pisici din director
  
  for i = 1 : Cats
    if histogram == "RGB"
      X(i, :) = rgbHistogram(PATH1(i, :), count_bins);
      %pe linia i a lui X, vectorul de caracteristci al imaginii i
     endif
    if histogram == "HSV"
      X(i, :) = hsvHistogram(PATH1(i, :), count_bins);
    endif   
  endfor
  
  for i = (Cats + 1) : N
    y(i) = -1; 
    if histogram == "RGB"
      X(i, :) = rgbHistogram(PATH2((i - Cats), :), count_bins);
      %pe linia i a lui X, vectorul de caracteristci al imaginii i
     endif
    if histogram == "HSV"
      X(i, :) = hsvHistogram(PATH2((i - Cats), :), count_bins);
    endif   
  endfor
   
endfunction
