L = 2e-3;       
R = 10;         
C = 10e-6;      
Uin = 32;       
f = 100e3;      
T = 1/f;        
D = 0.4;        

% 2. Condiciones iniciales y tiempo
x0 = [0; 0];     
tspan = [0 0.01]; 
opciones = odeset('MaxStep', T/10);

% 3. Integración con ode45
[t, x] = ode45(@(t,x) ecuaciones_estado(t, x, L, R, C, Uin, T, D), tspan, x0, opciones);

% 4. Gráficas
figure;
subplot(2,1,1);
plot(t, x(:,1), 'b', 'LineWidth', 1.5);
title('Corriente en el inductor i_L(t)');
xlabel('Tiempo (s)'); ylabel('Corriente (A)');
grid on;

subplot(2,1,2);
plot(t, x(:,2), 'r', 'LineWidth', 1.5);
title('Voltaje en el capacitor V_c(t)');
xlabel('Tiempo (s)'); ylabel('Voltaje (V)');
grid on;

function dx = ecuaciones_estado(t, x, L, R, C, Uin, T, D)

d_t = double(mod(t, T) < (D * T));

dx = zeros(2,1);

dx(1) = -(1/L)*x(2) + (Uin/L)*d_t;

dx(2) = (1/C)*x(1) - (1/(R*C))*x(2);
end