function [ a, b ] = coeff_diff_b ( s ) 
  P = pascal( s+1, -1 );
  a = zeros( s+1, 1 );
  
  y = ones( s, 1 );
  for i =1:s
    y(i) = y(i)/i;
  end
  P(1,1) = 0; % jer preskaèemo nabla^0
  y = [0; y];
  
  a(1) = (-1)*sum(diag(P,0)'*y(1:s+1));
  b = -1/a(1);  
  
  for i=2:s+1
    a(i) = (-1)^i*sum(diag(P,-(i-1))'*y(i:s+1));
  end
  a = a/a(1); %normaliziramo izraz da alfa_(n+s) bude 1
  a = flip(a); % poslije popravit da ovo ne radimo
  
end
