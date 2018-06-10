clc
clear all
close all
%%  chitwan QW350-2 
% https://dronesusermanuals.jimdo.com/chitwan/
i=1;
MultiDrone(i).Name ='QW350-2';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='chitwan'; 
MultiDrone(i).EmptyWeight  =807; 
MultiDrone(i).PayLoad =393; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='- Width: 87cm (34.25in)- Length: 87cm (34.25in)- Top Diameter: 107cm (42in)- Height: 30cm (12in)';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='15-18 minutes';
%1 - 3DR Solo
% REF = https://3dr.com/blog/solo-specs-just-the-facts-14480cb55722/#
i=i+1;
MultiDrone(i).Name ='Solo';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='3DR';
MultiDrone(i).EmptyWeight =1800;
MultiDrone(i).PayLoad =420;% added a Canon SX260 12.1 megapixe payload
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =0; % same motor % https://www.rcgroups.com/forums/showthread.php?2032374-Sunnysky-V2216-800KV-Thrust-Test
MultiDrone(i).MaxEnduranceTime ='~20 minute* flight time';
%%  Draganflyer Guardian
% http://www.draganfly.com/products/guardian/overview
i=i+1;
MultiDrone(i).Name ='Draganflyer Guardian';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='Draganfly'; 
MultiDrone(i).EmptyWeight  =1050; 
MultiDrone(i).PayLoad =420; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='- Width: 59.5cm (23.5in),Length: 59.5cm (23.5in),Top Diameter: 72.5cm (28.5in), Height: 25.5cm (10in)';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='20 minutes';



%%  Inspire 2
% http://www.dji.com/matrice-200-series/info#specs
i=i+1;
MultiDrone(i).Name ='Inspire 2';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='DJI'; 
MultiDrone(i).EmptyWeight  =3440 ; 
MultiDrone(i).PayLoad =560; 
MultiDrone(i).MaxThrust =0;
% dim 	42.7cm x H:31.7cm x W:42.5cm
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='27 minutes fULl payload';
%%  Draganflyer X4-P
i=i+1;
MultiDrone(i).Name ='Draganflyer X4-P';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='Draganfly'; 
MultiDrone(i).EmptyWeight  =1670; 
MultiDrone(i).PayLoad =800; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='- Width: 87cm (34.25in)- Length: 87cm (34.25in)- Top Diameter: 107cm (42in)- Height: 30cm (12in)';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='Not Known';
%%  Draganflyer Commander
% http://www.draganfly.com/
i=i+1;
MultiDrone(i).Name ='Draganflyer Commander';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='Draganfly'; 
MultiDrone(i).EmptyWeight  =2750; 
MultiDrone(i).PayLoad =1000; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='- Width: 87cm (34.25in)- Length: 87cm (34.25in)- Top Diameter: 107cm (42in)- Height: 30cm (12in)';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='40 min';

%%  Xaircraft XMission
i=i+1;
MultiDrone(i).Name ='XMission';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='Xaircraft'; 
MultiDrone(i).EmptyWeight  =1950; 
MultiDrone(i).PayLoad =1050; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='550 mm × 550 mm';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='16 minutes';
%%  Matrice 200
% http://www.dji.com/matrice-200-series/info#specs
i=i+1;
MultiDrone(i).Name ='Matrice 200';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='DJI'; 
MultiDrone(i).EmptyWeight  =4530 ; 
MultiDrone(i).PayLoad =1610; 
MultiDrone(i).MaxThrust =0;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='13 minutes fULl payload';
%% Xaircraft X650
i=i+1;
MultiDrone(i).Name ='X650';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='Xaircraft'; 
MultiDrone(i).EmptyWeight  =600; % Frame weight
MultiDrone(i).PayLoad =2400; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='570 mm × 570 mm';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='20 minutes';
%7 - Align Drones M480L
% ref : https://www.rcgroups.com/forums/showthread.php?2151903-Align-New-470-480-690-Multicopter/page78
i=i+1;
MultiDrone(i).Name ='M480L';
MultiDrone(i).Type ='Quad';
MultiDrone(i).Manufacture ='Align';
MultiDrone(i).EmptyWeight =2700;
MultiDrone(i).PayLoad =4500;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =-1; % no data avaiable about motor
MultiDrone(i).MaxEnduranceTime ='Not known';
%% Aeryon SkyRanger
% Ref : https://dronesusermanuals.jimdo.com/aeryon/aeryon-skyranger-more-powerful-and-mobile-aeryon-scout/
i=i+1;
MultiDrone(i).Name ='Aeryon SkyRanger';
MultiDrone(i).Type ='X8 quad';
MultiDrone(i).Manufacture ='Aeryon';
MultiDrone(i).EmptyWeight =2400;
MultiDrone(i).PayLoad =1000;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =-1; % no data avaiable about motor
MultiDrone(i).MaxEnduranceTime ='~50 minute* flight time';

%% Aeryon Scout
% Ref :https://dronesusermanuals.jimdo.com/aeryon/aeryon-scout-easy-and-reliable-professional-quadrocopter/
i=i+1;
MultiDrone(i).Name ='Aeryon Scout';
MultiDrone(i).Type ='X8 quad';
MultiDrone(i).Manufacture ='Aeryon';
MultiDrone(i).EmptyWeight =1400;
MultiDrone(i).PayLoad =300;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =-1; % no data avaiable about motor
MultiDrone(i).MaxEnduranceTime ='~50 minute* flight time';
%% 3DR X8-M
%Ref : https://3dr.com/wp-content/uploads/2017/03/X8-M-Spec-Sheet-v3.pdf
i=i+1;
MultiDrone(i).Name =' X8-M';
MultiDrone(i).Type ='X8 quad';
MultiDrone(i).Manufacture ='3DR';
MultiDrone(i).EmptyWeight =3500;
MultiDrone(i).PayLoad =200;% added a Canon SX260 12.1 megapixe payload
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =1470; % same motor % https://www.rcgroups.com/forums/showthread.php?2032374-Sunnysky-V2216-800KV-Thrust-Test
MultiDrone(i).MaxEnduranceTime ='~14 minute* flight time';

%8 - Atlas Dynamics
% ref : https://www.wetalkuav.com/yi-erida-drone-ces-2017/
i=i+1;
MultiDrone(i).Name ='YI ERIDA';
MultiDrone(i).Type ='Tri';
MultiDrone(i).Manufacture ='Atlas Dynamics';
MultiDrone(i).EmptyWeight =1300;
MultiDrone(i).PayLoad =1000;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =-1; % no data avaiable about motor
MultiDrone(i).MaxEnduranceTime ='40 min';


%9 - ARF-OktoXL
% ref : %http://www.mikrokopter.de/en/products/nmk8stden/nmk8techdaten
i=i+1;
MultiDrone(i).Name ='OktoXL';
MultiDrone(i).Type ='Octa';
MultiDrone(i).Manufacture ='ARF-OktoXL Dynamics';
MultiDrone(i).EmptyWeight =4130;
MultiDrone(i).PayLoad =870;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =2200; % no data avaiable about motor
MultiDrone(i).MaxEnduranceTime ='max. 40.5 min at 20.000mAh (e.g. 4 * 5.000mAh parallel) Without payload';
%10 - Mikrokopter MK8
% ref : %http://www.mikrokopter.de/en/products/nmk8stden/nmk8techdaten
i=i+1;
MultiDrone(i).Name ='MK8';
MultiDrone(i).Type ='Octa';
MultiDrone(i).Manufacture ='Atlas Dynamics';
MultiDrone(i).EmptyWeight =5652;
MultiDrone(i).PayLoad =3000;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =3000; % no data avaiable about motor
MultiDrone(i).MaxEnduranceTime ='23 min for 4x';
%% MATRICE 600 PRO
i=i+1;
% http://www.dji.com/matrice600-pro/info#specs
MultiDrone(i).Name ='MATRICE 600 PRO';
MultiDrone(i).Type ='Octa';
MultiDrone(i).Manufacture ='DJI';
MultiDrone(i).EmptyWeight  =9500;%base weight with six TB47S batteries
MultiDrone(i).PayLoad =6000;
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='1668 x 1518 x 727 mm';%(W x L x H)
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='6 kg payload: 16 min';
%% Turbo Ace INFINITY 9PRO
i=i+1;
MultiDrone(i).Name ='INFINITY 9PRO';
MultiDrone(i).Type ='Octa';
MultiDrone(i).Manufacture ='Turbo Ace'; 
MultiDrone(i).EmptyWeight  =9525.43977; % Weight With Battery
MultiDrone(i).PayLoad =9071.8474; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='1690mm × 1690mm × 610mm';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='8 minutes';

%%  AGRAS MG-1S
i=i+1;
% http://www.dji.com/mg-1s/info#specs
MultiDrone(i).Name =' AGRAS MG-1S ';
MultiDrone(i).Type ='Octa';
MultiDrone(i).Manufacture ='DJI';
MultiDrone(i).EmptyWeight  =23800;
MultiDrone(i).PayLoad =10000;%Spray system weight
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =5.1; 
MultiDrone(i).MaxEnduranceTime ='10 min?@12000 mAh & 23.8 kg takeoff weight?';
%MultiDrone(i).Dimension ='1471mm x 1471mm x 482mm';%(W x L x H)


%%  Typhoon H
i=i+1;
MultiDrone(i).Name ='Typhoon H';
MultiDrone(i).Type ='Hexa';
MultiDrone(i).Manufacture ='Yuneec'; 
MultiDrone(i).EmptyWeight  =1950-255; 
MultiDrone(i).PayLoad =255; 
MultiDrone(i).MaxThrust =0;% there is no data available
%MultiDrone(i).Dimension ='(520x457x310mm)';
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxEnduranceTime ='25 minutes';
%6 - Align Drones M690L
% ref : https://www.rcgroups.com/forums/showthread.php?2151903-Align-New-470-480-690-Multicopter/page78

i=i+1;
MultiDrone(i).Name ='M690L';
MultiDrone(i).Type ='Hexa';
MultiDrone(i).Manufacture ='Align';
MultiDrone(i).EmptyWeight =3400;
MultiDrone(i).PayLoad =5500;
MultiDrone(i).Max_allow_Weight =MultiDrone(i).PayLoad+MultiDrone(i).EmptyWeight;
MultiDrone(i).MaxThrust =-1; % no data avaiable about motor
MultiDrone(i).MaxEnduranceTime ='Not known';
%% Outputs
figure
for k =1:10
    EmptyWeight(k)=MultiDrone(k).EmptyWeight;
    payload(k)=MultiDrone(k).PayLoad;
end
plot(payload,EmptyWeight)
for k =1:10
   text(payload(k),EmptyWeight(k),['\leftarrow',MultiDrone(k).Name],'FontSize',8,'FontWeight','bold') 
end
grid on
title('Empty Weight vs payload(Quad)')
ylabel('Empty Weight(grams)');
xlabel('payload(grams)');
%% Outputs
figure
for k =10:13
    EmptyWeight1(k-9)=MultiDrone(k).EmptyWeight;
    payload1(k-9)=MultiDrone(k).PayLoad;
end
plot(payload1,EmptyWeight1)
for k =10:13
   text(payload1(k-9),EmptyWeight1(k-9),['\leftarrow',MultiDrone(k).Name],'FontSize',8,'FontWeight','bold') 
end
grid on
title('Empty Weight vs payload(Coax)')
ylabel('Empty Weight(grams)');
xlabel('payload(grams)');
%% Outputs
figure
for k =14
    EmptyWeight2(1)=MultiDrone(k).EmptyWeight;
    payload2(1)=MultiDrone(k).PayLoad;
end
plot(payload2,EmptyWeight2)
for k =14
   text(payload2(1),EmptyWeight2(1),['\leftarrow',MultiDrone(k).Name],'FontSize',8,'FontWeight','bold') 
end
grid on
title('Empty Weight vs payload(Tri)')
ylabel('Empty Weight(grams)');
xlabel('payload(grams)');
%% Outputs
figure
for k =15:19
    EmptyWeight3(k-14)=MultiDrone(k).EmptyWeight;
    payload3(k-14)=MultiDrone(k).PayLoad;
end
plot(payload3,EmptyWeight3)
for k =15:19
   text(payload3(k-14),EmptyWeight3(k-14),['\leftarrow',MultiDrone(k).Name],'FontSize',8,'FontWeight','bold') 
end
grid on
title('Empty Weight vs payload(Octa)')
ylabel('Empty Weight(grams)');
xlabel('payload(grams)');
%% Outputs
figure
for k =20:21
    EmptyWeight4(k-19)=MultiDrone(k).EmptyWeight;
    payload4(k-19)=MultiDrone(k).PayLoad;
end
plot(payload4,EmptyWeight4)
for k =20:21
   text(payload4(k-19),EmptyWeight4(k-19),['\leftarrow',MultiDrone(k).Name],'FontSize',8,'FontWeight','bold') 
end
grid on
title('Empty Weight vs payload(Hexa)')
ylabel('Empty Weight(grams)');
xlabel('payload(grams)');

