clc
clear all
close all
Ts_roll=3;
Ts_pitch=3.5;
Tp_roll=0.55;
Tp_pitch=0.55;
taw=1.4;
dcgain_roll= [150 300 450 130 400 500];
dcgain_pitch= [200 350 550 150 400 700];
dcgain_psi= [2 20 50 30 55 85];
dcgain_rollRate= [170 400 600 180 500 600];
dcgain_pitchRate= [100 300 450 190 450 700];
dcgain_psiRate= [10 40 90 40 100 180];
filePath = 'Openloop Quad Figures\roll\phi.txt';
splitDataFunction_kimo(filePath ,2,17,1,Ts_roll,Tp_roll,dcgain_roll,dcgain_rollRate);
filePath = 'Openloop Quad Figures\pitch\theta.txt';
splitDataFunction_kimo(filePath ,3,17,2,Ts_pitch,Tp_pitch,dcgain_pitch,dcgain_pitchRate);
filePath = 'Openloop Quad Figures\yaw\psi.txt';
splitDataFunction_kimo(filePath ,4,17,3,taw,taw,dcgain_psi,dcgain_psiRate);
% Age=[45;41];
% age2=[45;32];
% LastName = {'1650';'1750'};
% T1 = table(Age,age2,...
%     'RowNames',LastName);
%     
%     'VariableNames',{'10(deltaPWM)' '20(deltaPWM)' '30(deltaPWM)'});