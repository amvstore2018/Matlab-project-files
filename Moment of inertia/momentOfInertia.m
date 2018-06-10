clc
clear all
close all
%wire
L=131/100;
b=13/100/2;%length between wires
% rod 
m=0.23;%kg
a=0.04;%width
c=23.5/100;%length
I_exact=m*(a^2+c^2)/12;%exact
period1=[4.8 4.82 4.8 4.7 4.84 4.79 4.7 4.8 4.82 4.84 4.84 4.81 4.83 4.77 4.81 4.79 4.83 4.81 4.83 4.77 4.7 4.78 4.72 4.75 4.66 4.6 4.98 4.54 4.57 4.65];%period
period2=[4.77 4.67 4.81 4.77 4.79 4.59 4.76 4.71 4.65 4.74 4.72 4.58 4.71 4.68 4.85 4.89 4.84 4.46 4.85 4.72 4.66 4.5 4.81 4.68 4.78 4.8];
T1 =mean(period1)/2;
T2 =mean(period2)/2;
T_rod=mean([T1,T2]);
g=4*pi^2*L/T_rod^2;%assume it as a simple penduluim
I_exp=m*9.79562*b^2*T_rod^2/4/pi^2/L;
Error = (1-I_exp/I_exact )*100;
I_exp1=m*9.79562*b^2*T1^2/4/pi^2/L;
I_exp2=m*9.79562*b^2*T2^2/4/pi^2/L;
%Quad
m=1.66;%kg
L=132.4/100;
period1=[5.16 5.3 5.11 5.32 5.38 5.13 5.34 4.97 5.28 5.22 5.26 5.33 5.22 5.22 5.35];%period
period2=[5.12 5.31 5.21 5.16 5.18 5.21 5.22 5.19 5.18 5.18 5.19 5.15 5.24 5.29 5.25 5.37 5.17];
T1 =mean(period1);
T2 =mean(period2);
T_quad_zz=mean([T1,T2]);
g=4*pi^2*L/T_quad_zz^2;%assume it as a simple penduluim
I_zz_exp=m*9.79562*b^2*T_quad_zz^2/4/pi^2/L;
L=130.9/100;
period1=[3.86 3.6 3.55 3.72 3.77 3.87 3.77 3.73 3.63 3.78 3.8 3.71 3.86 3.79 3.76];%period
period2=[3.6 3.69 3.65 3.77 3.77 3.67 3.59 3.59 3.55 3.5 3.55 3.62 3.71 3.61 3.64 3.66 3.59];
T1 =mean(period1);
T2 =mean(period2);
T_quad_yy=mean([T1,T2]);
I_yy_exp=m*9.79562*b^2*T_quad_yy^2/4/pi^2/L;% as theta is 45 deg
%period [3.75 3.67 3.73 3.52 3.61 3.54 3.75 3.44 3.59 3.77 3.64 3.62 3.58 3.69 3.71 ]
I_xx_exp=I_yy_exp;