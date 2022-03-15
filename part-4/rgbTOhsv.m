function [HUE, SATURATION, VALUE] = rgbTOhsv(RED, GREEN, BLUE)
  
  RED1 = im2double(RED(:));
  GREEN1 = im2double(GREEN(:));
  BLUE1 = im2double(BLUE(:));
  Cmax = max(max(RED1, GREEN1), BLUE1);
  Cmin = min(min(RED1, GREEN1), BLUE1);
  DELTA = Cmax .- Cmin;
  VALUE = Cmax;
  SATURATION(find(Cmax == 0)) = 0;
  %pe pozitiile pe care Cmax e 0, SATURATION e zero
  SATURATION(find(Cmax != 0)) = DELTA(find(Cmax != 0)) ./ Cmax(find(Cmax != 0));
  SATURATION = SATURATION';
  HUE(find(DELTA == 0)) = 0;
  COND1 = intersect(find(DELTA != 0), find(Cmax == RED1));
  COND2 = intersect(find(DELTA != 0), find(Cmax == GREEN1));
  COND3 = intersect(find(DELTA != 0), find(Cmax == BLUE1));
  HUE(COND1) = 60 .* mod((((GREEN1(COND1)) .- (BLUE1(COND1))) ./ DELTA(COND1)), 6);
  HUE(COND2) = 60 .* ((((BLUE1(COND2)) .- (RED1(COND2))) ./ DELTA(COND2)) .+ 2);      
  HUE(COND3) = 60 .* ((((RED1(COND3)) .- (GREEN1(COND3))) ./ DELTA(COND3)) .+ 4); 
  HUE = HUE ./ 360; 
  HUE = HUE';   
  
  endfunction