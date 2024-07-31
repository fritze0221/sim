%30.07.2024
%Übung Sim mit Auto

clear all;
tic;


delta_t = 0.1;   % [s] Schrittweite

sim_t = 60;      % [s] Sim Zeit

m = 1500;         % [kg] Masse

k_reib = 0.01;    %Reibungszahl

g = 9.81;         %[m/s^2] Erdbeschleungigung

t = [0:delta_t:sim_t];  % [s]

F = zeros(size(t)) + 2000;
F_gesamt = zeros(size(t));    % [N]

a = zeros(size(t)); % [m/s^2]

v = zeros(size(t)); % [m/s]

s = zeros(size(t)); % [m]

%--------Startbedingungen-------

s(1) = 3; % [m] Startposition
v(1) = 0; % [m/s] Startgeschwindigkeit

%--------Transiente Berechnung-------

for i_step = 2:length(t);

  F_gesamt = (F(i_step) - k_reib * m * g);

  a(i_step) = F_gesamt/m;

  v(i_step) = a(i_step) * delta_t + v(i_step - 1);

  s(i_step) = v(i_step) * delta_t + s(i_step - 1);

end % i_step


%-------Postprocessing-------

figure(1);
clf;

plot(t(2:end),a(2:end),'r');
hold on;
xlabel('Zeit [s]')
ylabel('Beschleunigung [m/s^2] ')
grid on;

figure(2);
clf;

plot(t,v*3.6,'g');
xlabel('Zeit [s]')
ylabel('Geschwindigkeit [km/h] ')
grid on;

figure(3);
clf;

plot(t,s/1000,'b');
xlabel('Zeit [s]')
ylabel('Weg [km] ')
grid on;

toc


