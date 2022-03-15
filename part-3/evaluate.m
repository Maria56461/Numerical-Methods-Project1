function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  
  [X, y] = preprocess(path_to_testset, histogram, count_bins);
  Xp = [X ones(rows(X), 1)]';
  yp = w' * Xp;
  y_prezicere = yp';
  correct_evaluated = 0;
  
  Cats = length(dir(fullfile(strcat(path_to_testset, '/cats/'), '*.jpg'))); 
  %numarul de imagini cu pisici din director 
  No_c = length(dir(fullfile(strcat(path_to_testset, '/not_cats/'), '*.jpg')));
  %numarul de imagini fara pisici din director
  
  for i = 1 : Cats
    if y_prezicere(i) >= 0 
      correct_evaluated++;
    endif
  endfor
  
  for i = (Cats + 1) : (Cats + No_c)
    if y_prezicere(i) < 0 
      correct_evaluated++;
    endif
  endfor
  
  percentage = correct_evaluated / (Cats + No_c);
   
endfunction