%30..07.2024
%Übung Sim mit Auto

clear all;
tic;


delta_t = 0.1;   % [s] Schrittweite

sim_t = 60;      % [s] Sim Zeit

m = 1500;         % [kg] Masse

roh_L = 1.2;        % [kg/m^3] Luftdichte

A = 4;          % [m^2] Fläche

k_cw = 0.01;         %Gleitzahl

k_reib = 0.01;    %Reibungszahl

g = 9.81;         %[m/s^2] Erdbeschleungigung

t = [0:delta_t:sim_t];  % [s]

F = zeros(size(t)) + 2000;     % [N]

a = zeros(size(t)); % [m/s^2]

v = zeros(size(t)); % [m/s]

s = zeros(size(t)); % [m]

%--------Startbedingungen-------

s(1) = 3; % [m] Startposition
v(1) = 0; % [m/s] Startgeschwindigkeit

%--------Transiente Berechnung-------

for i_step = 2:length(t);

    if (v(i_step - 1) > 50/3.6 )
     F(i_step) = 0;
  end

  v(i_step) = (m/(roh_L*k_cw*A*delta_t)) * (1 - sqrt(1 + (2*k_reib*g*k_cw*A*delta_t^2)/m - ((2*F(i_step)*roh_L*k_cw*A*delta_t^2)/(m^2))- ((v(i_step-1)*roh_L*k_cw*A*delta_t)/(2*m))));

  a(i_step) = (v(i_step) - v(i_step - 1))/delta_t;

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

plot(t,s,'b');
xlabel('Zeit [s]')
ylabel('Weg [m] ')
grid on;

toc


