%Motor and battery Selection code
%function [Endurance]=MotorSelection(TotalThrust)
tic
clc;clear all;close all;
TotalTakeoff=7500;
NormMotorThrust=TotalTakeoff/8;
TotalThrust =TotalTakeoff*2 ;
FlightTime=15; %min
ThrustPerMotor = TotalThrust/8;
Frac=1.2;
%%
%
%   for x = 1:10
%       disp(x)
%   end
%
CompWeight=400;
%% Data Read
Data = readtable('kde-higher-eff-data-base.xlsx');
MotorPower=table2array(Data(:,12));
MotorThrust=table2array((Data(:,13)));
MotorWeight=table2array((Data(:,3)));
ESCWeight=table2array(Data(:,6));
PropWeight=table2array(Data(:,9));
NoOfCells=table2array(Data(:,10));
PropDiameter=table2array(Data(:,23));
for i = 1:length(MotorPower)
    if i<=7
        MotorPower1(i) =MotorPower(i);
        MotorThrust1(i)=MotorThrust(i);
        MotorWeight1(i)=MotorWeight(i);
        ESCWeight1(i)  =ESCWeight(i);
        PropWeight1(i) =PropWeight(i);
        NoOfCells1(i) =  NoOfCells(i);
        PropDiameter1(i) =  PropDiameter(i);
    elseif i>7 && i<=14
        MotorPower2(i-7) =MotorPower(i);
        MotorThrust2(i-7)=MotorThrust(i);
        MotorWeight2(i-7)=MotorWeight(i);
        ESCWeight2(i-7)  =ESCWeight(i);
        PropWeight2(i-7) =PropWeight(i);
        NoOfCells2(i-7) =  NoOfCells(i);
        PropDiameter2(i-7) =  PropDiameter(i);
    elseif i>14 && i<=21
        MotorPower3(i-14) =MotorPower(i);
        MotorThrust3(i-14)=MotorThrust(i);
        MotorWeight3(i-14)=MotorWeight(i);
        ESCWeight3(i-14)  =ESCWeight(i);
        PropWeight3(i-14) =PropWeight(i);
        NoOfCells3(i-14) =  NoOfCells(i);
        PropDiameter3(i-14) =  PropDiameter(i);
    elseif i>21 && i<=28
        MotorPower4(i-21) =MotorPower(i);
        MotorThrust4(i-21)=MotorThrust(i);
        MotorWeight4(i-21)=MotorWeight(i);
        ESCWeight4(i-21)  =ESCWeight(i);
        PropWeight4(i-21) =PropWeight(i);
        NoOfCells4(i-21) =  NoOfCells(i);
        PropDiameter4(i-21) =  PropDiameter(i);
    elseif i>28 && i<=35
        MotorPower5(i-28) =MotorPower(i);
        MotorThrust5(i-28)=MotorThrust(i);
        MotorWeight5(i-28)=MotorWeight(i);
        ESCWeight5(i-28)  =ESCWeight(i);
        PropWeight5(i-28) =PropWeight(i);
        NoOfCells5(i-28) =  NoOfCells(i);
        PropDiameter5(i-28) =  PropDiameter(i);
    elseif i>35 && i<=42
        MotorPower6(i-35) =MotorPower(i);
        MotorThrust6(i-35)=MotorThrust(i);
        MotorWeight6(i-35)=MotorWeight(i);
        ESCWeight6(i-35)  =ESCWeight(i);
        PropWeight6(i-35) =PropWeight(i);
        NoOfCells6(i-35) =  NoOfCells(i);
        PropDiameter6(i-35) =  PropDiameter(i);
    elseif i>42 && i<=49
        MotorPower7(i-42) =MotorPower(i);
        MotorThrust7(i-42)=MotorThrust(i);
        MotorWeight7(i-42)=MotorWeight(i);
        ESCWeight7(i-42)  =ESCWeight(i);
        PropWeight7(i-42) =PropWeight(i);
        NoOfCells7(i-42) =  NoOfCells(i);
        PropDiameter7(i-42) =  PropDiameter(i);
    elseif i>49 && i<=56
        MotorPower8(i-49) =MotorPower(i);
        MotorThrust8(i-49)=MotorThrust(i);
        MotorWeight8(i-49)=MotorWeight(i);
        ESCWeight8(i-49)  =ESCWeight(i);
        PropWeight8(i-49) =PropWeight(i);
        NoOfCells8(i-49) =  NoOfCells(i);
        PropDiameter8(i-49) =  PropDiameter(i);
    elseif i>56 && i<=63
        MotorPower9(i-56) =MotorPower(i);
        MotorThrust9(i-56)=MotorThrust(i);
        MotorWeight9(i-56)=MotorWeight(i);
        ESCWeight9(i-56)  =ESCWeight(i);
        PropWeight9(i-56) =PropWeight(i);
        NoOfCells9(i-56) =  NoOfCells(i);
        PropDiameter9(i-56) =  PropDiameter(i);
    elseif i>63 && i<=70
        MotorPower10(i-63) =MotorPower(i);
        MotorThrust10(i-63)=MotorThrust(i);
        MotorWeight10(i-63)=MotorWeight(i);
        ESCWeight10(i-63)  =ESCWeight(i);
        PropWeight10(i-63) =PropWeight(i);
        NoOfCells10(i-63) =  NoOfCells(i);
        PropDiameter10(i-63) =  PropDiameter(i);
    elseif i>70 && i<=77
        MotorPower11(i-70) =MotorPower(i);
        MotorThrust11(i-70)=MotorThrust(i);
        MotorWeight11(i-70)=MotorWeight(i);
        ESCWeight11(i-70)  =ESCWeight(i);
        PropWeight11(i-70) =PropWeight(i);
        NoOfCells11(i-70) =  NoOfCells(i);
        PropDiameter11(i-70) =  PropDiameter(i);
    elseif i>77 && i<=84
        MotorPower12(i-77) =MotorPower(i);
        MotorThrust12(i-77)=MotorThrust(i);
        MotorWeight12(i-77)=MotorWeight(i);
        ESCWeight12(i-77)  =ESCWeight(i);
        PropWeight12(i-77) =PropWeight(i);
        NoOfCells12(i-77) =  NoOfCells(i);
        PropDiameter12(i-77) =  PropDiameter(i);
    elseif i>84 && i<=91
        MotorPower13(i-84) =MotorPower(i);
        MotorThrust13(i-84)=MotorThrust(i);
        MotorWeight13(i-84)=MotorWeight(i);
        ESCWeight13(i-84)  =ESCWeight(i);
        PropWeight13(i-84) =PropWeight(i);
        NoOfCells13(i-84) =  NoOfCells(i);
        PropDiameter13(i-84) =  PropDiameter(i);
    elseif i>91 && i<=98
        MotorPower14(i-91) =MotorPower(i);
        MotorThrust14(i-91)=MotorThrust(i);
        MotorWeight14(i-91)=MotorWeight(i);
        ESCWeight14(i-91)  =ESCWeight(i);
        PropWeight14(i-91) =PropWeight(i);
        NoOfCells14(i-91) =  NoOfCells(i);
        PropDiameter14(i-91) =  PropDiameter(i);
    elseif i>98 && i<=105
        MotorPower15(i-98) =MotorPower(i);
        MotorThrust15(i-98)=MotorThrust(i);
        MotorWeight15(i-98)=MotorWeight(i);
        ESCWeight15(i-98)  =ESCWeight(i);
        PropWeight15(i-98) =PropWeight(i);
        NoOfCells15(i-98) =  NoOfCells(i);
        PropDiameter15(i-98) =  PropDiameter(i);
    elseif i>105 && i<=112
        MotorPower16(i-105) =MotorPower(i);
        MotorThrust16(i-105)=MotorThrust(i);
        MotorWeight16(i-105)=MotorWeight(i);
        ESCWeight16(i-105)  =ESCWeight(i);
        PropWeight16(i-105) =PropWeight(i);
        NoOfCells16(i-105) =  NoOfCells(i);
        PropDiameter16(i-105) =  PropDiameter(i);
    elseif i>112 && i<=119
        MotorPower17(i-112) =MotorPower(i);
        MotorThrust17(i-112)=MotorThrust(i);
        MotorWeight17(i-112)=MotorWeight(i);
        ESCWeight17(i-112)  =ESCWeight(i);
        PropWeight17(i-112) =PropWeight(i);
        NoOfCells17(i-112) =  NoOfCells(i);
        PropDiameter17(i-112) =  PropDiameter(i);
    elseif i>119 && i<=126
        MotorPower18(i-119) =MotorPower(i);
        MotorThrust18(i-119)=MotorThrust(i);
        MotorWeight18(i-119)=MotorWeight(i);
        ESCWeight18(i-119)  =ESCWeight(i);
        PropWeight18(i-119) =PropWeight(i);
        NoOfCells18(i-119) =  NoOfCells(i);
        PropDiameter18(i-119) =  PropDiameter(i);
    elseif i>126 && i<=133
        MotorPower19(i-126) =MotorPower(i);
        MotorThrust19(i-126)=MotorThrust(i);
        MotorWeight19(i-126)=MotorWeight(i);
        ESCWeight19(i-126)  =ESCWeight(i);
        PropWeight19(i-126) =PropWeight(i);
        NoOfCells19(i-126) =  NoOfCells(i);
        PropDiameter19(i-126) =  PropDiameter(i);
    elseif i>133 && i<=140
        MotorPower20(i-133) =MotorPower(i);
        MotorThrust20(i-133)=MotorThrust(i);
        MotorWeight20(i-133)=MotorWeight(i);
        ESCWeight20(i-133)  =ESCWeight(i);
        PropWeight20(i-133) =PropWeight(i);
        NoOfCells20(i-133) =  NoOfCells(i);
        PropDiameter20(i-133) =  PropDiameter(i);
    elseif i>140 && i<=147
        MotorPower21(i-140) =MotorPower(i);
        MotorThrust21(i-140)=MotorThrust(i);
        MotorWeight21(i-140)=MotorWeight(i);
        ESCWeight21(i-140)  =ESCWeight(i);
        PropWeight21(i-140) =PropWeight(i);
        NoOfCells21(i-140) =  NoOfCells(i);
        PropDiameter21(i-140) =  PropDiameter(i);
        
    elseif i>147 && i<=154
        MotorPower22(i-147) =MotorPower(i);
        MotorThrust22(i-147)=MotorThrust(i);
        MotorWeight22(i-147)=MotorWeight(i);
        ESCWeight22(i-147)  =ESCWeight(i);
        PropWeight22(i-147) =PropWeight(i);
        NoOfCells22(i-147) =  NoOfCells(i);
        PropDiameter22(i-147) =  PropDiameter(i);
        
    elseif i>154 && i<=161
        MotorPower23(i-154) =MotorPower(i);
        MotorThrust23(i-154)=MotorThrust(i);
        MotorWeight23(i-154)=MotorWeight(i);
        ESCWeight23(i-154)  =ESCWeight(i);
        PropWeight23(i-154) =PropWeight(i);
        NoOfCells23(i-154) =  NoOfCells(i);
        PropDiameter23(i-154) =  PropDiameter(i);
        
    elseif i>161 && i<=168
        MotorPower24(i-161) =MotorPower(i);
        MotorThrust24(i-161)=MotorThrust(i);
        MotorWeight24(i-161)=MotorWeight(i);
        ESCWeight24(i-161)  =ESCWeight(i);
        PropWeight24(i-161) =PropWeight(i);
        NoOfCells24(i-161) =  NoOfCells(i);
        PropDiameter24(i-161) =  PropDiameter(i);
        
    elseif i>168 && i<=175
        MotorPower25(i-168) =MotorPower(i);
        MotorThrust25(i-168)=MotorThrust(i);
        MotorWeight25(i-168)=MotorWeight(i);
        ESCWeight25(i-168)  =ESCWeight(i);
        PropWeight25(i-168) =PropWeight(i);
        NoOfCells25(i-168) =  NoOfCells(i);
        PropDiameter25(i-168) =  PropDiameter(i);
        
    elseif i>175 && i<=182
        MotorPower26(i-175) =MotorPower(i);
        MotorThrust26(i-175)=MotorThrust(i);
        MotorWeight26(i-175)=MotorWeight(i);
        ESCWeight26(i-175)  =ESCWeight(i);
        PropWeight26(i-175) =PropWeight(i);
        NoOfCells26(i-175) =  NoOfCells(i);
        PropDiameter26(i-175) =  PropDiameter(i);
        
    elseif i>182 && i<=189
        MotorPower27(i-182) =MotorPower(i);
        MotorThrust27(i-182)=MotorThrust(i);
        MotorWeight27(i-182)=MotorWeight(i);
        ESCWeight27(i-182)  =ESCWeight(i);
        PropWeight27(i-182) =PropWeight(i);
        NoOfCells27(i-182) =  NoOfCells(i);
        PropDiameter27(i-182) =  PropDiameter(i);
        
    elseif i>189 && i<=196
        MotorPower28(i-189) =MotorPower(i);
        MotorThrust28(i-189)=MotorThrust(i);
        MotorWeight28(i-189)=MotorWeight(i);
        ESCWeight28(i-189)  =ESCWeight(i);
        PropWeight28(i-189) =PropWeight(i);
        NoOfCells28(i-189) =  NoOfCells(i);
        PropDiameter28(i-189) =  PropDiameter(i);
        
    elseif i>196 && i<=203
        MotorPower29(i-196) =MotorPower(i);
        MotorThrust29(i-196)=MotorThrust(i);
        MotorWeight29(i-196)=MotorWeight(i);
        ESCWeight29(i-196)  =ESCWeight(i);
        PropWeight29(i-196) =PropWeight(i);
        NoOfCells29(i-196) =  NoOfCells(i);
        PropDiameter29(i-196) =  PropDiameter(i);
        
    elseif i>203 && i<=210
        MotorPower30(i-203) =MotorPower(i);
        MotorThrust30(i-203)=MotorThrust(i);
        MotorWeight30(i-203)=MotorWeight(i);
        ESCWeight30(i-203)  =ESCWeight(i);
        PropWeight30(i-203) =PropWeight(i);
        NoOfCells30(i-203) =  NoOfCells(i);
        PropDiameter30(i-203) =  PropDiameter(i);
    end
end
% MotorPower1=xlsread('kde-higher-eff-data-base','L1:L8');
% MotorPower2=xlsread('kde-higher-eff-data-base','L9:L15');
% MotorPower3=xlsread('kde-higher-eff-data-base','L16:L22');
% MotorPower4=xlsread('kde-higher-eff-data-base','L23:L29');
% MotorPower5=xlsread('kde-higher-eff-data-base','L30:L36');
% MotorPower6=xlsread('kde-higher-eff-data-base','L37:L43');
% MotorPower7=xlsread('kde-higher-eff-data-base','L44:L50');
% MotorPower8=xlsread('kde-higher-eff-data-base','L51:L57');
% MotorPower9=xlsread('kde-higher-eff-data-base','L58:L64');
% MotorPower10=xlsread('kde-higher-eff-data-base','L65:L71');
% MotorPower11=xlsread('kde-higher-eff-data-base','L72:L78');
% MotorPower12=xlsread('kde-higher-eff-data-base','L79:L85');
% MotorPower13=xlsread('kde-higher-eff-data-base','L86:L92');
% MotorPower14=xlsread('kde-higher-eff-data-base','L93:L99');
% MotorPower15=xlsread('kde-higher-eff-data-base','L100:L106');
% MotorPower16=xlsread('kde-higher-eff-data-base','L107:L113');
% MotorPower17=xlsread('kde-higher-eff-data-base','L114:L120');
% MotorPower18=xlsread('kde-higher-eff-data-base','L121:L128');
%
% MotorThrust1=xlsread('kde-higher-eff-data-base','M1:M8');
% MotorThrust2=xlsread('kde-higher-eff-data-base','M9:M15');
% MotorThrust3=xlsread('kde-higher-eff-data-base','M16:M22');
% MotorThrust4=xlsread('kde-higher-eff-data-base','M23:M29');
% MotorThrust5=xlsread('kde-higher-eff-data-base','M30:M36');
% MotorThrust6=xlsread('kde-higher-eff-data-base','M37:M43');
% MotorThrust7=xlsread('kde-higher-eff-data-base','M44:M50');
% MotorThrust8=xlsread('kde-higher-eff-data-base','M51:M57');
% MotorThrust9=xlsread('kde-higher-eff-data-base','M58:M64');
% MotorThrust10=xlsread('kde-higher-eff-data-base','M65:M71');
% MotorThrust11=xlsread('kde-higher-eff-data-base','M72:M78');
% MotorThrust12=xlsread('kde-higher-eff-data-base','M79:M85');
% MotorThrust13=xlsread('kde-higher-eff-data-base','M86:M92');
% MotorThrust14=xlsread('kde-higher-eff-data-base','M93:M99');
% MotorThrust15=xlsread('kde-higher-eff-data-base','M100:M106');
% MotorThrust16=xlsread('kde-higher-eff-data-base','M107:M113');
% MotorThrust17=xlsread('kde-higher-eff-data-base','M114:M120');
% MotorThrust18=xlsread('kde-higher-eff-data-base','M121:M128');
BattName=table2array(Data(1:6,14));
BattCapacity=table2array(Data(1:6,18));
BattDischarge=table2array(Data(1:6,15));
BattWeight=table2array(Data(1:6,20));
BattCells = table2array(Data(1:6,21));
BattNo=table2array(Data(1:6,22));
%% Motor Selection & polynomial fitting function
for i = 1:length(MotorPower)
    if i<=7 && ThrustPerMotor <= max(MotorThrust1)
        p1=polyfit(MotorThrust1,MotorPower1,4);
    elseif i>7 && i<=14 && ThrustPerMotor <= max(MotorThrust2)
        p2=polyfit(MotorThrust2,MotorPower2,4);
    elseif i>14 && i<=21 && ThrustPerMotor <= max(MotorThrust3)
        p3=polyfit(MotorThrust3,MotorPower3,4);
    elseif i>21 && i<=28 && ThrustPerMotor <= max(MotorThrust4)
        p4=polyfit(MotorThrust4,MotorPower4,4);
    elseif i>28 && i<=35 && ThrustPerMotor <= max(MotorThrust5)
        p5=polyfit(MotorThrust5,MotorPower5,4);
    elseif i>35 && i<=42 && ThrustPerMotor <= max(MotorThrust6)
        p6=polyfit(MotorThrust6,MotorPower6,4);
    elseif i>42 && i<=49 && ThrustPerMotor <= max(MotorThrust7)
        p7=polyfit(MotorThrust7,MotorPower7,4);
    elseif i>49 && i<=56 && ThrustPerMotor <= max(MotorThrust8)
        p8=polyfit(MotorThrust8,MotorPower8,4);
    elseif i>56 && i<=63 && ThrustPerMotor <= max(MotorThrust9)
        p9=polyfit(MotorThrust9,MotorPower9,4);
    elseif i>63 && i<=70 && ThrustPerMotor <= max(MotorThrust10)
        p10=polyfit(MotorThrust10,MotorPower10,4);
    elseif i>70 && i<=77 && ThrustPerMotor <= max(MotorThrust11)
        p11=polyfit(MotorThrust11,MotorPower11,4);
    elseif i>77 && i<=84 && ThrustPerMotor <= max(MotorThrust12)
        p12=polyfit(MotorThrust12,MotorPower12,4);
    elseif i>84 && i<=91 && ThrustPerMotor <= max(MotorThrust13)
        p13=polyfit(MotorThrust13,MotorPower13,4);
    elseif i>91 && i<=98 && ThrustPerMotor <= max(MotorThrust14)
        p14=polyfit(MotorThrust14,MotorPower14,4);
    elseif i>98 && i<=105 && ThrustPerMotor <= max(MotorThrust15)
        p15=polyfit(MotorThrust15,MotorPower15,4);
    elseif i>105 && i<=112 && ThrustPerMotor <= max(MotorThrust16)
        p16=polyfit(MotorThrust16,MotorPower16,4);
    elseif i>112 && i<=119 && ThrustPerMotor <= max(MotorThrust17)
        p17=polyfit(MotorThrust17,MotorPower17,4);
    elseif i>119 && i<=126 && ThrustPerMotor <= max(MotorThrust18)
        p18=polyfit(MotorThrust18,MotorPower18,4);
    elseif i>126 && i<=133 && ThrustPerMotor <= max(MotorThrust19)
        p19=polyfit(MotorThrust19,MotorPower19,4);
    elseif i>133 && i<=140 && ThrustPerMotor <= max(MotorThrust20)
        p20=polyfit(MotorThrust20,MotorPower20,4);
    elseif i>140 && i<=147 && ThrustPerMotor <= max(MotorThrust21)
        p21=polyfit(MotorThrust21,MotorPower21,4);
    elseif i>147 && i<=154 && ThrustPerMotor <= max(MotorThrust22)
        p22=polyfit(MotorThrust22,MotorPower22,4);
    elseif i>154 && i<=161 && ThrustPerMotor <= max(MotorThrust23)
        p23=polyfit(MotorThrust23,MotorPower23,4);
    elseif i>161 && i<=168 && ThrustPerMotor <= max(MotorThrust24)
        p24=polyfit(MotorThrust24,MotorPower24,4);
    elseif i>168 && i<=175 && ThrustPerMotor <= max(MotorThrust25)
        p25=polyfit(MotorThrust25,MotorPower25,4);
    elseif i>175 && i<=182 && ThrustPerMotor <= max(MotorThrust26)
        p26=polyfit(MotorThrust26,MotorPower26,4);
    elseif i>182 && i<=189 && ThrustPerMotor <= max(MotorThrust27)
        p27=polyfit(MotorThrust27,MotorPower27,4);
    elseif i>189 && i<=196 && ThrustPerMotor <= max(MotorThrust28)
        p28=polyfit(MotorThrust28,MotorPower28,4);
    elseif i>196 && i<=203 && ThrustPerMotor <= max(MotorThrust29)
        p29=polyfit(MotorThrust29,MotorPower29,4);
    elseif i>203 && i<=210 && ThrustPerMotor <= max(MotorThrust30)
        p30=polyfit(MotorThrust30,MotorPower30,4);
        
    end
end

%% Check Existance of Polynomial function and extract the power according to the thrust
if  exist ('p1','var')==1
    power1=polyval(p1,NormMotorThrust*Frac);
    k(1)=1;
end
if exist ('p2','var')==1
    power2=polyval(p2,NormMotorThrust*Frac);
    k(2)=2;
end
if exist ('p3','var')==1
    power3=polyval(p3,NormMotorThrust*Frac);
    k(3)=3;
end
if exist ('p4','var')==1
    power4=polyval(p4,NormMotorThrust*Frac);
    k(4)=4;
end
if exist ('p5','var')==1
    power5=polyval(p5,NormMotorThrust*Frac);
    k(5)=5;
end
if exist ('p6','var')==1
    power6=polyval(p6,NormMotorThrust*Frac);
    k(6)=6;
end
if exist ('p7','var')==1
    power7=polyval(p7,NormMotorThrust*Frac);
    k(7)=7;
end
if exist ('p8','var')==1
    power8=polyval(p8,NormMotorThrust*Frac);
    k(8)=8;
end
if exist ('p9','var')==1
    power9=polyval(p9,NormMotorThrust*Frac);
    k(9)=9;
end
if exist ('p10','var')==1
    power10=polyval(p10,NormMotorThrust*Frac);
    k(10)=10;
end
if exist ('p11','var')==1
    power11=polyval(p11,NormMotorThrust*Frac);
    k(11)=11;
end
if exist ('p12','var')==1
    power12=polyval(p12,NormMotorThrust*Frac);
    k(12)=12;
end
if exist ('p13','var')==1
    power13=polyval(p13,NormMotorThrust*Frac);
    k(13)=13;
end
if exist ('p14','var')==1
    power14=polyval(p14,NormMotorThrust*Frac);
    k(14)=14;
end
if exist ('p15','var')==1
    power15=polyval(p15,NormMotorThrust*Frac);
    k(15)=15;
end
if exist ('p16','var')==1
    power16=polyval(p16,NormMotorThrust*Frac);
    k(16)=16;
end
if exist ('p17','var')==1
    power17=polyval(p17,NormMotorThrust*Frac);
    k(17)=17;
end
if exist ('p18','var')==1
    power18=polyval(p18,NormMotorThrust*Frac);
    k(18)=18;
end
if exist ('p19','var')==1
    power19=polyval(p19,NormMotorThrust*Frac);
    k(19)=19;
end
if exist ('p20','var')==1
    power20=polyval(p20,NormMotorThrust*Frac);
    k(20)=20;
end
if exist ('p21','var')==1
    power21=polyval(p21,NormMotorThrust*Frac);
    k(21)=21;
end
if exist ('p22','var')==1
    power22=polyval(p22,NormMotorThrust*Frac);
    k(22)=22;
end
if exist ('p23','var')==1
    power23=polyval(p23,NormMotorThrust*Frac);
    k(23)=23;
end
if exist ('p24','var')==1
    power24=polyval(p24,NormMotorThrust*Frac);
    k(24)=24;
end
if exist ('p25','var')==1
    power25=polyval(p25,NormMotorThrust*Frac);
    k(25)=25;
end
if exist ('p26','var')==1
    power26=polyval(p26,NormMotorThrust*Frac);
    k(26)=26;
end
if exist ('p27','var')==1
    power27=polyval(p27,NormMotorThrust*Frac);
    k(27)=27;
end
if exist ('p28','var')==1
    power28=polyval(p28,NormMotorThrust*Frac);
    k(28)=28;
end
if exist ('p29','var')==1
    power29=polyval(p29,NormMotorThrust*Frac);
    k(29)=29;
end
if exist ('p30','var')==1
    power30=polyval(p30,NormMotorThrust*Frac);
    k(30)=30;
end
%% Check whethere the power exceeds the maximum given data value or not
switch exist ('p1','var')
    case 1
        if power1> max(MotorPower1)
            power1 =0;
        end
    otherwise  power1 =0;
end
switch exist ('p2','var')
    case 1
        if power2> max(MotorPower2)
            power2 =0;
        end
    otherwise  power2 =0;
end
switch exist ('p3','var')
    case 1
        if power3> max(MotorPower3)
            power3 =0;
        end
    otherwise  power3 =0;
end
switch exist ('p4','var')
    case 1
        if power4> max(MotorPower4)
            power4 =0;
        end
    otherwise  power4 =0;
end
switch exist ('p5','var')
    case 1
        if power5> max(MotorPower5)
            power5 =0;
        end
    otherwise  power5 =0;
end
switch exist ('p6','var')
    case 1
        if power6> max(MotorPower6)
            power6 =0;
        end
    otherwise  power6 =0;
end
switch exist ('p7','var')
    case 1
        if power7> max(MotorPower7)
            power7 =0;
        end
    otherwise  power7 =0;
end
switch exist ('p8','var')
    case 1
        if power8> max(MotorPower8)
            power8 =0;
        end
    otherwise  power8 =0;
end
switch exist ('p9','var')
    case 1
        if power9> max(MotorPower9)
            power9 =0;
        end
    otherwise  power9 =0;
end
switch exist ('p10','var')
    case 1
        if power10> max(MotorPower10)
            power10 =0;
        end
    otherwise  power10 =0;
end
switch exist ('p11','var')
    case 1
        if power11> max(MotorPower11)
            power11 =0;
        end
    otherwise  power11 =0;
end
switch exist ('p12','var')
    case 1
        if power12> max(MotorPower12)
            power12 =0;
        end
    otherwise  power12 =0;
end
switch exist ('p13','var')
    case 1
        if power13> max(MotorPower13)
            power13 =0;
        end
    otherwise  power13 =0;
end
switch exist ('p14','var')
    case 1
        if power14> max(MotorPower14)
            power14 =0;
        end
    otherwise  power14 =0;
end
switch exist ('p15','var')
    case 1
        if power15> max(MotorPower15)
            power15 =0;
        end
    otherwise  power15 =0;
end
switch exist ('p16','var')
    case 1
        if power16> max(MotorPower16)
            power16 =0;
        end
    otherwise  power16 =0;
end
switch exist ('p17','var')
    case 1
        if power17> max(MotorPower17)
            power17 =0;
        end
    otherwise  power17 =0;
end
switch exist ('p18','var')
    case 1
        if power18> max(MotorPower18)
            power18 =0;
        end
    otherwise  power18 =0;
end
switch exist ('p19','var')
    case 1
        if power19> max(MotorPower19)
            power19 =0;
        end
    otherwise  power19 =0;
end
switch exist ('p20','var')
    case 1
        if power20> max(MotorPower20)
            power20 =0;
        end
    otherwise  power20 =0;
end
switch exist ('p21','var')
    case 1
        if power21> max(MotorPower21)
            power21 =0;
        end
    otherwise  power21 =0;
end
switch exist ('p22','var')
    case 1
        if power22> max(MotorPower22)
            power22 =0;
        end
    otherwise  power22 =0;
end
switch exist ('p23','var')
    case 1
        if power23> max(MotorPower23)
            power23 =0;
        end
    otherwise  power23 =0;
end
switch exist ('p24','var')
    case 1
        if power24> max(MotorPower24)
            power24 =0;
        end
    otherwise  power24 =0;
end
switch exist ('p25','var')
    case 1
        if power25> max(MotorPower25)
            power25 =0;
        end
    otherwise  power25 =0;
end
switch exist ('p26','var')
    case 1
        if power26> max(MotorPower26)
            power26 =0;
        end
    otherwise  power26 =0;
end
switch exist ('p27','var')
    case 1
        if power27> max(MotorPower27)
            power27 =0;
        end
    otherwise  power27 =0;
end
switch exist ('p28','var')
    case 1
        if power28> max(MotorPower28)
            power28 =0;
        end
    otherwise  power28 =0;
end
switch exist ('p29','var')
    case 1
        if power29> max(MotorPower29)
            power29 =0;
        end
    otherwise  power29 =0;
end
switch exist ('p30','var')
    case 1
        if power30> max(MotorPower30)
            power30 =0;
        end
    otherwise  power30 =0;
end


%%
power = [power1
    power2
    power3
    power4
    power5
    power6
    power7
    power8
    power9
    power10
    power11
    power12
    power13
    power14
    power15
    power16
    power17
    power18
    power19
    power20
    power21
    power22
    power23
    power24
    power25
    power26
    power27
    power28
    power29
    power30];
Endurance=zeros(length(power),length(BattCapacity));
E=zeros(length(power),length(BattCapacity));
for i=1:length(power)
    for j=1:length(BattCapacity)
        %%Check discharge
        if power(i)*8>BattDischarge(j)
            Endurance(i,j)=0;
            E(i,j)=0;
        end
        
        if NoOfCells(i*7)==6 && BattCells(j)==6
            Endurance(i,j)=BattCapacity(j)*60/(power(i)*8);
            E(i,j)=BattNo(j);
        elseif NoOfCells(i*7)==3 && BattCells(j)==3
            Endurance(i,j)=BattCapacity(j)*60/(power(i)*8);
            E(i,j)=BattNo(j);
        elseif NoOfCells(i*7)==4 && BattCells(j)==4
            Endurance(i,j)=BattCapacity(j)*60/(power(i)*8);
            E(i,j)=BattNo(j);
        else
            Endurance(i,j)=0;
            E(i,j)=0;
        end
        
        
        for n = 1:60%number of batteries
            if n*Endurance(i,j)>=FlightTime && isinf(Endurance(i,j))==0
                
                NoOfBatt(i,j)=n;
                NewEndurance(i,j)=n*Endurance(i,j);
                
                break;
            elseif isinf(Endurance(i,j))==1
                NoOfBatt(i,j)=0;
                NewEndurance(i,j)=0;
                break;
            end
            
        end
    end
end
%% Total weight check
BaseWeight=zeros(length(k),length(BattWeight));
%Frame Weight = (22738/425)*PropDiameter - 88.801765
for i =1:length(k)
    for j=1:length(BattWeight)
        if k(i)==1 && NewEndurance(i,j)~=0
            FrameWeight(1) = (22738/425)*PropDiameter1(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight1(1)+ESCWeight1(1)+PropWeight1(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(1);
        elseif k(i)==2 && NewEndurance(i,j)~=0
            FrameWeight(2) = (22738/425)*PropDiameter2(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight2(1)+ESCWeight2(1)+PropWeight2(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(2);
        elseif k(i)==3 && NewEndurance(i,j)~=0
            FrameWeight(3) = (22738/425)*PropDiameter3(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight3(1)+ESCWeight3(1)+PropWeight3(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(3);
        elseif k(i)==4 && NewEndurance(i,j)~=0
            FrameWeight(4) = (22738/425)*PropDiameter4(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight4(1)+ESCWeight4(1)+PropWeight4(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(4);
        elseif k(i)==5 && NewEndurance(i,j)~=0
            FrameWeight(5) = (22738/425)*PropDiameter5(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight5(1)+ESCWeight5(1)+PropWeight5(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(5);
        elseif k(i)==6 && NewEndurance(i,j)~=0
            FrameWeight(6) = (22738/425)*PropDiameter6(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight6(1)+ESCWeight6(1)+PropWeight6(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(6);
        elseif k(i)==7 && NewEndurance(i,j)~=0
            FrameWeight(7) = (22738/425)*PropDiameter7(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight7(1)+ESCWeight7(1)+PropWeight7(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(7);
        elseif k(i)==8 && NewEndurance(i,j)~=0
            FrameWeight(8) = (22738/425)*PropDiameter8(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight8(1)+ESCWeight8(1)+PropWeight8(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(8);
        elseif k(i)==9 && NewEndurance(i,j)~=0
            FrameWeight(9) = (22738/425)*PropDiameter9(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight9(1)+ESCWeight9(1)+PropWeight9(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(9);
        elseif k(i)==10 && NewEndurance(i,j)~=0
            FrameWeight(10) = (22738/425)*PropDiameter10(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight10(1)+ESCWeight10(1)+PropWeight10(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(10);
        elseif k(i)==11 && NewEndurance(i,j)~=0
            FrameWeight(11) = (22738/425)*PropDiameter11(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight11(1)+ESCWeight11(1)+PropWeight11(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(11);
        elseif k(i)==12 && NewEndurance(i,j)~=0
            FrameWeight(12) = (22738/425)*PropDiameter12(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight12(1)+ESCWeight12(1)+PropWeight12(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(12);
        elseif k(i)==13 && NewEndurance(i,j)~=0
            FrameWeight(13) = (22738/425)*PropDiameter13(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight13(1)+ESCWeight13(1)+PropWeight13(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(13);
        elseif k(i)==14 && NewEndurance(i,j)~=0
            FrameWeight(14) = (22738/425)*PropDiameter14(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight14(1)+ESCWeight14(1)+PropWeight14(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(14);
        elseif k(i)==15 && NewEndurance(i,j)~=0
            FrameWeight(15) = (22738/425)*PropDiameter15(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight15(1)+ESCWeight15(1)+PropWeight15(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(15);
        elseif k(i)==16 && NewEndurance(i,j)~=0
            FrameWeight(16) = (22738/425)*PropDiameter16(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight16(1)+ESCWeight16(1)+PropWeight16(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(16);
        elseif k(i)==17 && NewEndurance(i,j)~=0
            FrameWeight(17) = (22738/425)*PropDiameter17(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight17(1)+ESCWeight17(1)+PropWeight17(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(17);
        elseif k(i)==18 && NewEndurance(i,j)~=0
            FrameWeight(18) = (22738/425)*PropDiameter18(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight18(1)+ESCWeight18(1)+PropWeight18(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(18);
        elseif k(i)==19 && NewEndurance(i,j)~=0
            FrameWeight(19) = (22738/425)*PropDiameter19(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight19(1)+ESCWeight19(1)+PropWeight19(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(19);
        elseif k(i)==20 && NewEndurance(i,j)~=0
            FrameWeight(20) = (22738/425)*PropDiameter20(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight20(1)+ESCWeight20(1)+PropWeight20(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(20);
        elseif k(i)==21 && NewEndurance(i,j)~=0
            FrameWeight(21) = (22738/425)*PropDiameter21(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight21(1)+ESCWeight21(1)+PropWeight21(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(21);
        elseif k(i)==22 && NewEndurance(i,j)~=0
            FrameWeight(22) = (22738/425)*PropDiameter22(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight22(1)+ESCWeight22(1)+PropWeight22(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(22);
        elseif k(i)==23 && NewEndurance(i,j)~=0
            FrameWeight(23) = (22738/425)*PropDiameter23(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight23(1)+ESCWeight23(1)+PropWeight23(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(23);
        elseif k(i)==24 && NewEndurance(i,j)~=0
            FrameWeight(24) = (22738/425)*PropDiameter24(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight24(1)+ESCWeight24(1)+PropWeight24(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(24);
        elseif k(i)==25 && NewEndurance(i,j)~=0
            FrameWeight(25) = (22738/425)*PropDiameter25(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight25(1)+ESCWeight25(1)+PropWeight25(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(25);
        elseif k(i)==26 && NewEndurance(i,j)~=0
            FrameWeight(26) = (22738/425)*PropDiameter26(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight26(1)+ESCWeight26(1)+PropWeight26(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(26);
        elseif k(i)==27 && NewEndurance(i,j)~=0
            FrameWeight(27) = (22738/425)*PropDiameter27(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight27(1)+ESCWeight27(1)+PropWeight27(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(27);
        elseif k(i)==28 && NewEndurance(i,j)~=0
            FrameWeight(28) = (22738/425)*PropDiameter28(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight28(1)+ESCWeight28(1)+PropWeight28(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(28);
            
        elseif k(i)==29 && NewEndurance(i,j)~=0
            FrameWeight(29) = (22738/425)*PropDiameter29(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight29(1)+ESCWeight29(1)+PropWeight29(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(29);
        elseif k(i)==30 && NewEndurance(i,j)~=0
            FrameWeight(30) = (22738/425)*PropDiameter30(1) - 88.801765;
            BaseWeight(i,j)=(MotorWeight30(1)+ESCWeight30(1)+PropWeight30(1))*8+NoOfBatt(i,j)*BattWeight(j)+CompWeight+FrameWeight(30);
        else
            BaseWeight(i,j)=0;
        end
    end
end
minBaseWeight = min(BaseWeight(BaseWeight>0));
[a1,b1]=find(BaseWeight== minBaseWeight);
if(length(a1) > 1)
[a2,b2] =   find(NewEndurance==max(max(NewEndurance(a1,b1))));
a1 = a1(a1 == a2);
b1 = b1(b1 == b2);
end
if(NoOfBatt(a1,b1)~=0)
    disp('*************************************************************');
        disp(['for TotalTakeoff = ',num2str(TotalTakeoff),' grams & ReqEndurance ',num2str(FlightTime), 'Min']);
    disp(['Minimum base Weight = ',num2str(min(BaseWeight(BaseWeight>0))),' grams']);
    disp(['Payload  = ',num2str(TotalTakeoff-min(BaseWeight(BaseWeight>0))),' grams']);
    disp(['Selected motor = ',char(Data.motor(a1*7))]);
    disp(['Selected ESC = ',char(Data.ESC(a1*7))]);
    disp(['Selected prop = ',char(Data.prop(a1*7))]);
    disp(['Selected Battery is ',char(BattName(b1))]);
    disp(['Selected Battery No of cells = ',num2str(Data.battary(a1*7)),'S']);
    disp(['NO of batteries = ',num2str(NoOfBatt(a1,b1))]);
    disp(['NewEndurance = ',num2str(NewEndurance(a1,b1)),' min']);
    disp('*************************************************************');
else
    disp('We need more batteries numbers');
end
% plot(BaseWeight(BaseWeight>0))
% grid on
% title('BaseWeight')
% box on
toc