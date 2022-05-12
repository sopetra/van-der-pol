a = 0; b = 100;
lambda = 1;
N = 1000;

g = @(t,y) [ (lambda*(1-y(2).^2)*y(1)-y(2)); y(1) ];

y0 = [0;1];

[x1,y1] = back_diff(g,a,b,y0,N,5);
[x2,y2] = odj_pred_kor(g,a,b,y0,N,4,5);
[s,v] = odj_rk23v (g,y0,a,b,1e-5);

% DIFERENCIJE UNAZAD
fig1=figure(1) % rk23 usporeddba s back_diff
plot(s,v(1,:),'-b',x1,y1(1,:),'-m');
legend('rk23','diferencije unazad');
xlabel('x'); ylabel("y_x");
xlim([0,100]);

fig2=figure(2) % rk23
plot(s,v(2,:),'-b',x1,y1(2,:),'-m');
legend('rk23','diferencije unazad');
xlabel('x'); ylabel('y');
xlim([0,100]);

%PREDIKTOR KOREKTOR
fig3=figure(3) % rk23 usporeddba s back_diff
plot(s,v(1,:),'-b',x2,y2(1,:),'-g');
legend('rk23','ABM');
xlabel('x'); ylabel("y_x");
xlim([0,100]);

fig4=figure(4) % rk23
plot(s,v(2,:),'-b',x2,y2(2,:),'-g');
xlabel('x'); ylabel('y');
legend('rk23','ABM');
xlim([0,100]);

% CIKLUS
fig5=figure(5)
plot(v(2,:),v(1,:),'-b');
xlabel('y'); ylabel("y_x");


% ZA USPOREDBU RK23 I OCTAVE RUTINE ZA KRUTE JEDNADŽBE
[t,u] = ode15s(g,[0 100],y0);
figure(6)
plot(t,u(:,1),'-m',s,v(1,:),'-k');
figure(7)
plot(t,u(:,2),'-m',s,v(2,:),'-k');

