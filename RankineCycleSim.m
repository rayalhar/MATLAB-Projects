%program to simulate the ideal rankine cycle of a steam turbine with lake
%water exchange in condensor


clear all
close all
clc

fprintf(' \n\n  RANKINE CYCLE SIMULATOR')
fprintf(' \n \n Process 1-2 is isentropic compression in the pump\n')
fprintf(' Process 2-3 is isobaric heat addition in the boiler\n')
fprintf(' Process 3-4 is isentropic expansion in the steam turbine\n')
fprintf(' Process 4-1 is isobaric pressure heat rejection in condenser\n\n')




%Inputs from the user
fprintf(' Inputs required\n')
p3 = input('\n 1. Enter the pressure at turbine inlet (in KPa) = ')
T3 = input(' \n 2. Enter the temperature at turbine inlet (in C°) = ')
p4 = input('\n 3. Enter the pressure at condenser inlet (lake water) (in KPa) = ')
nP = input('\n Enter in the pump efficiency (as a percentage) = ')
pSpeed = input('\n Enter in the pump speed (min^-1) = ')
nT = input('\n Enter in the turbine efficiency (as a percentage) = ')
maxCap = input('\n Enter in the max capacity from the pump (in m^3/hr) = ')
mflow_lake = input('\n Enter in the mass flow rate of the lake (in kg/s) = ')
T5 = 10;
cp_water = 4.204;


%computing all the state properties
%state1 properties
p1 = p4;
p2 = p3;

v1 = WaterProps('v', 'p', p1, 'x', 0 ); 
h1 = WaterProps('h', 'p', p1, 'x', 0 );
Wpump = (v1*(p2-p1))/nP;

%state 2 
h2 = h1 + Wpump;
v2 = WaterProps('v', 'p', p2, 'x', 0 );
T2 = WaterProps('T', 'p', p2, 'h', h2);

%state 3

h3 = WaterProps('h', 'T', T3, 'p', p3);
s3 = WaterProps('s', 'T', T3, 'p', p3);

%state 4

s4 = s3;
h_4_s = WaterProps('h', 'p', p4, 's', s4);
h4 = h3 - (nT*(h3 - h_4_s));
h_g_4 = WaterProps('h', 'p', p4, 'x', 1);
h_f_4 = WaterProps('h', 'p', p4, 'x', 0); 
x4 = (h4-h_f_4)/(h_g_4-h_f_4);
mflow_cycle = (maxCap/pSpeed) * (1/v2);
T4 = WaterProps('T','P',p4,'h',h4);

%heat/work eqs

Qout = mflow_cycle *(h4-h1);
Qin = mflow_cycle * (h3-h2);
Win = v1*(p2-p1)*mflow_cycle;
Wout = mflow_cycle *(h3-h4);
Wnet = Wout-Win;
Power = Qin -Wout;
T6 = ((mflow_cycle*(h4-h1)))/((mflow_lake*cp_water)) + T5;

thermalEff = (Wnet/Qin);

disp1 = ['Condensor Pressure: ', num2str(p4) ,' KPa'];
disp(disp1)

disp2 = ['Boiler Pressure: ', num2str(p2/1000) ,' MPa'];
disp(disp2)

disp3 = ['Pump Outlet Temperature: ', num2str(T2) ,' °C'];
disp(disp3)

disp35 = ['Turbine Inlet Temperature: ', num2str(T3) ,' °C'];
disp(disp35)


disp4 = ['Steam Quality: ', num2str(x4*100) ,' %'];
disp(disp4)

disp5 = ['Turbine Outlet Temperature: ', num2str(T4) ,' °C'];
disp(disp5)

disp6 = ['Cycle Mass Flow Rate: ', num2str(mflow_cycle) ,' kg/s'];
disp(disp6)

disp7 = ['Heat Into Cycle: ', num2str(Qin/1000) ,' MW'];
disp(disp7)

disp8 = ['Net Power: ', num2str(Power/1000) ,' MW'];
disp(disp8)

disp9 = ['Overall Thermal Efficiency: ', num2str(thermalEff*100) ,' %'];
disp(disp9)

disp10 = ['Mass Flow Rate of Lake Water: ', num2str(mflow_lake) ,' kg/s'];
disp(disp10)

disp11 = ['Lake Water Outlet Temp: ', num2str(T6) ,' °C'];
disp(disp11)































