function [sol] = hsvHistogram(path_to_image, count_bins)
  
  IMG = imread(path_to_image);
  RED = IMG(: ,: ,1);
  GREEN = IMG(: ,: ,2);
  BLUE = IMG(: ,: ,3);
  [HUE, SATURATION, VALUE] = rgbTOhsv(RED, GREEN, BLUE);
  V1 = histc(HUE, [0 : 1.01/count_bins : 1.01]);
  V2 = histc(SATURATION, [0 : 1.01/count_bins : 1.01]);
  V3 = histc(VALUE, [0 : 1.01/count_bins : 1.01]);
  sol = [V1([1 : (length(V1) - 1)], :); V2([1 : (length(V2) - 1)], :); 
  V3([1 : (length(V3) - 1)], :)]';
  
end