function [sol] = rgbHistogram(path_to_image, count_bins)
  
  IMG = imread(path_to_image);
  RED = IMG(: ,: ,1);
  GREEN = IMG(: ,: ,2);
  BLUE = IMG(: ,: ,3);
  A = histc(RED(:), [0 : 256/count_bins : 256]);
  B = histc(GREEN(:), [0 : 256/count_bins : 256]);
  C = histc(BLUE(:), [0 : 256/count_bins : 256]);
  sol = [A([1 : (length(A) - 1)], :); B([1 : (length(B) - 1)], :); 
  C([1 : (length(C) - 1)], :)]';
   
end