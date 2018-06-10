clc
clear all
close all
Ts=2;
Tp=0.55;
dcgain_angle= [150 300 450 130 400 500];
dcgain_angleRate= [170 400 500 180 500 600];
filePath = 'Open loop Quad\roll\phi.txt';
splitDataFunction( filePath ,2,17);

% splitDataFunctionv6(filePath ,2,17,1,Ts,Tp,dcgain_angle,dcgain_angleRate);
Ts=3;
Tp=0.55;
dcgain_angle= [150 300 450 130 400 500];
dcgain_angleRate= [170 400 500 180 500 600];
filePath = 'Open loop Quad\pitch\theta.txt';
% splitDataFunctionv6(filePath ,3,17,2,Ts,Tp,dcgain_angle,dcgain_angleRate);
splitDataFunction( filePath ,3,17);
filePath = 'Open loop Quad\yaw\psi.txt';
splitDataFunction( filePath ,4,17);
Age=[45;41];
age2=[45;32];
LastName = {'1650';'1750'};
T1 = table(Age,age2,...
    'RowNames',LastName);
    
%     'VariableNames',{'10(deltaPWM)' '20(deltaPWM)' '30(deltaPWM)'});