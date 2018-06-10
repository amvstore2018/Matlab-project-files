clc
clear all
close all
% All weight in grams
%%  MK8 with 2 batteries
%http://www.mikrokopter.de/en/products/nmk8stden/nmk8techdaten
MultiDrone(1).Name =' MK8 with 2 batteries';
MultiDrone(1).Type ='Octacopter';
MultiDrone(1).Manufacture ='Mikrokopter';
MultiDrone(1).FrameWeight =2850;% (approx +- 200g)(without battery/payload) %strong carbon fiber
MultiDrone(1).BaseWeight  =4350;%base weight incl. 2 batteries
MultiDrone(1).BatteryWeight =750;
MultiDrone(1).Max_allow_Weight ='8350 g';
MultiDrone(1).PayLoad =4000;%max. payload with 2 Lipos
MultiDrone(1).MaxThrust =3000; % there is no data available for  (Type: MK4008/350) (with 16" CFK propellers). but on there shop there are motore that ranges from 2200 to 3000 
MultiDrone(1).MaxEnduranceTime ='12 min for 4kg payload';
MultiDrone(1).Dimension ='1085mm x 1160mm x 450mm';%(W x L x H)
MultiDrone(1).Battery ='Capacity: 4500mAh / 35C Voltage: 22.2 V (6s),Size: approx 150 * 90 * 28mm';
MultiDrone(1).Notes ='Endurance time can vary ( 10 - 40 minutes. Depending on the payload and battery choice.)';
%% MK8 with 4 batteries 
%http://www.mikrokopter.de/en/products/nmk8stden/nmk8techdaten
MultiDrone(2).Name ='MK8 with 4 batteries ';
MultiDrone(2).Type ='Octacopter';
MultiDrone(2).Manufacture ='Mikrokopter';
MultiDrone(2).FrameWeight =2850;% (approx +- 200g)(without battery/payload) %strong carbon fiber
MultiDrone(2).BatteryWeight =570;
MultiDrone(2).BaseWeight  =5652;%base weight incl. 4 batteries
MultiDrone(2).Max_allow_Weight ='8650 g';
MultiDrone(2).PayLoad =3000;
MultiDrone(2).MaxThrust =3000; % there is no data available for  (Type: MK4008/350) (with 16" CFK propellers). but on there shop there are motore that ranges from 2200 to 3000 
MultiDrone(2).MaxEnduranceTime ='23 min for 4x';
MultiDrone(2).Dimension ='1085mm x 1160mm x 450mm';%(W x L x H)
MultiDrone(2).Battery ='Capacity: 4500mAh / 35C Voltage: 22.2 V (6s),Size: approx 150 * 90 * 28mm';
MultiDrone(2).Notes ='Endurance time can vary ( 10 - 40 minutes. Depending on the payload and battery choice.)';
% %% ArfOktoXL-6S12 with 2 batteries 
% % http://www.mikrokopter.de/en/products/mk6s12e/flightsystems
% % http://wiki.mikrokopter.de/en/ArfOktoXL-6S12
% MultiDrone(2).Name ='OktoXL-6S12 with 2 batteries ';
% MultiDrone(2).Type ='Octacopter';
% MultiDrone(2).Manufacture ='Mikrokopter';
% MultiDrone(2).FrameWeight =2600;%(without battery/payload)  %strong carbon fiber
% MultiDrone(2).BaseWeight  =5652;%base weight incl. 4 batteries
% MultiDrone(2).BatteryWeight =750;
% MultiDrone(2).Max_allow_Weight ='5000 g';
% MultiDrone(2).PayLoad =4000;
% MultiDrone(2).MaxThrust =3000;% Motor MK3644 & check % http://wiki.mikrokopter.de/en/MotorCurves#MK3644.2F24                            
% MultiDrone(2).Dimension ='735mm x 735mm x 450mm';%(W x L x H)
% MultiDrone(2).Battery ='Capacity: 4500mAh / 35C Voltage: 22.2 V (6s),Size: approx 150 * 90 * 28mm';
% MultiDrone(2).MaxEnduranceTime ='8 - 41 minutes. Depending on the payload and battery choice.';
% MultiDrone(2).Notes ='Can support up to 4x Battery';
% %% ArfOktoXL-6S12
% % http://www.mikrokopter.de/en/products/mk6s12e/flightsystems
% % http://wiki.mikrokopter.de/en/ArfOktoXL-6S12
% MultiDrone(2).Name ='OktoXL-6S12';
% MultiDrone(2).Type ='Octacopter';
% MultiDrone(2).Manufacture ='Mikrokopter';
% MultiDrone(2).FrameWeight =2600;%(without battery/payload)  %strong carbon fiber
% MultiDrone(2).BaseWeight  =5652;%base weight incl. 4 batteries
% MultiDrone(2).BatteryWeight =750;
% MultiDrone(2).Max_allow_Weight ='5000 g';
% MultiDrone(2).PayLoad =4000;
% MultiDrone(2).MaxThrust =3000;% Motor MK3644 & check % http://wiki.mikrokopter.de/en/MotorCurves#MK3644.2F24                            
% MultiDrone(2).Dimension ='735mm x 735mm x 450mm';%(W x L x H)
% MultiDrone(2).Battery ='Capacity: 4500mAh / 35C Voltage: 22.2 V (6s),Size: approx 150 * 90 * 28mm';
% MultiDrone(2).MaxEnduranceTime ='8 - 41 minutes. Depending on the payload and battery choice.';
% MultiDrone(2).Notes ='Can support up to 4x Battery';
%% ARF-OktoXL with 2 batteries
% http://wiki.mikrokopter.de/en/ArfOktoXL
MultiDrone(3).Name ='ARF-OktoXL with 2 batteries';
MultiDrone(3).Type ='Octacopter';
MultiDrone(3).Manufacture ='Mikrokopter';
MultiDrone(3).FrameWeight = 2050;%(without battery/payload)  %strong carbon fiber
MultiDrone(3).BaseWeight  =3090;%base weight incl. 2 batteries
MultiDrone(3).BatteryWeight =520;
MultiDrone(3).PayLoad =1910;% according to max allow.payload(5000-3090) as the document just recommended max allowable weight
MultiDrone(3).MaxThrust =2200;% motor : MK3638             
MultiDrone(3).Dimension ='735mm x 735mm x 360mm';%(W x L x H)
MultiDrone(3).Battery =' 4S/5000';
MultiDrone(3).Max_allow_Weight ='5000 g';
MultiDrone(3).MaxEnduranceTime ='for  2 * 5.000mAh parallel Without payload: max. 28,6 min . With 1000g payload: max 20min';
MultiDrone(3).Notes ='No notes';
%% ARF-OktoXL with 4 batteries
% http://wiki.mikrokopter.de/en/ArfOktoXL
MultiDrone(4).Name ='ARF-OktoXL with 4 batteries';
MultiDrone(4).Type ='Octacopter';
MultiDrone(4).Manufacture ='Mikrokopter';
MultiDrone(4).FrameWeight = 2050;%(without battery/payload)  %strong carbon fiber
MultiDrone(4).BaseWeight  =4130;%base weight incl. 4 batteries
MultiDrone(4).BatteryWeight =520;
MultiDrone(4).PayLoad =870;% according to max allow.payload(5000-3090) as the document just recommended max allowable weight
MultiDrone(4).MaxThrust =2200;% motor : MK3638             
MultiDrone(4).Dimension ='735mm x 735mm x 360mm';%(W x L x H)
MultiDrone(4).Battery ='4S/5000';
MultiDrone(4).Max_allow_Weight ='5000 g';
MultiDrone(4).MaxEnduranceTime ='max. 40.5 min at 20.000mAh (e.g. 4 * 5.000mAh parallel) Without payload';
MultiDrone(4).Notes ='No notes';
%% Draganflyer X8
% https://dronesusermanuals.jimdo.com/draganfly/
MultiDrone(5).Name ='Draganflyer X8';
MultiDrone(5).Type ='X8 quad';
MultiDrone(5).Manufacture ='Draganfly';
MultiDrone(5).FrameWeight = 1700;%(without battery/payload) 
MultiDrone(5).BaseWeight  =2200;%base weight incl. 1 batteries
MultiDrone(5).BatteryWeight =500;
MultiDrone(5).PayLoad =700;
MultiDrone(5).MaxThrust =2900;% https://hobbyking.com/de_de/turnigy-multistar-4830-480kv-22pole-multi-rotor-outrunner.html
MultiDrone(5).Dimension ='870 x 870 x 320 mm';%(W x L x H)
MultiDrone(5).Battery ='Capacity: 5400mAh Voltage: 14.8V';
MultiDrone(5).Max_allow_Weight ='2500 g';
MultiDrone(5).MaxEnduranceTime ='about 20 minutes without any payload';
MultiDrone(5).Notes ='Out of service';
% %% infinity-9pro_octocopter
% % http://www.turboace.com/infinity-9pro_octocopter.aspx
% MultiDrone(5).Name ='infinity-9pro_octocopter';
% MultiDrone(5).Type ='Octacopter';
% MultiDrone(5).Manufacture ='turboace';
% MultiDrone(5).FrameWeight = 7030.6;%(without battery/payload) 
% MultiDrone(5).BatteryWeight =2494.7;
% MultiDrone(5).PayLoad =9071.8;
% MultiDrone(5).MaxThrust =5000;% Tiger Motor U7 Brushless Motors: 420KV       %https://www.mcmracing.com/en/home/63719-t-motor-tmou7-420-brushless-motor-u7-kv420 
% MultiDrone(5).Dimension ='Motor to Motor Dimensions: 49.5" (1,260mm) octocopter frame Wingspan Dimension: 66.5" (1,690mm) propeller tip to tip Height: 8" to 24" (205mm to 610mm) depending on gimbal and skid landing configuration';
% MultiDrone(5).Battery ='5.5 lbs (22,000mah 6S LiPo) or 11 lbs (Qty2 x 22,000mah 6S LiPo)';
% MultiDrone(5).Max_allow_Weight ='18143.6 g';%All in Weight: 31-46.5 lbs depending on payload & batteries
% MultiDrone(5).MaxEnduranceTime ='8 to 15 minutes depending on payload & batteries';
% MultiDrone(5).Notes ='Can support two batteries';

%% yara %%
%%  AGRAS MG-1S
% http://www.dji.com/mg-1s/info#specs
MultiDrone(6).Name =' AGRAS MG-1S ';
MultiDrone(6).Type ='Octacopter';
MultiDrone(6).Manufacture ='DJI';
MultiDrone(6).FrameWeight =10000;%(without battery/payload) 
MultiDrone(6).BaseWeight  =0;%base weight incl. 2 batteries
MultiDrone(6).BatteryWeight =0;
MultiDrone(6).Max_allow_Weight ='24800 g';
MultiDrone(6).PayLoad =10000;%Spray system weight
MultiDrone(6).MaxThrust =5.1*8; 
MultiDrone(6).MaxEnduranceTime ='22 min(@12000 mAh & 13.8 kg takeoff weight),10 min?@12000 mAh & 23.8 kg takeoff weight?';
MultiDrone(6).Dimension ='1471mm x 1471mm x 482mm';%(W x L x H)
MultiDrone(6).Battery ='Capacity: 12000mAh';
MultiDrone(6).Notes ='';

%% MATRICE 600 PRO
% http://www.dji.com/matrice600-pro/info#specs
MultiDrone(7).Name ='MATRICE 600 PRO';
MultiDrone(7).Type ='Octacopter';
MultiDrone(7).Manufacture ='DJI';
MultiDrone(7).FrameWeight = 5930;%(without battery/payload) 
MultiDrone(7).BaseWeight  =9500;%base weight with six TB47S batteries
MultiDrone(7).BatteryWeight =3570;%all six of them
MultiDrone(7).PayLoad =6000;
MultiDrone(7).MaxThrust =0;% there is no data available
MultiDrone(7).Dimension ='1668 x 1518 x 727 mm';%(W x L x H)
MultiDrone(7).Battery ='Capacity: 4500mAh Voltage: 22.2V';
MultiDrone(7).Max_allow_Weight ='15500 g';
MultiDrone(7).MaxEnduranceTime ='No payload: 32 min, 6 kg payload: 16 min';
MultiDrone(7).Notes ='';

%% X8 +
% 
MultiDrone(8).Name ='X8 +';
MultiDrone(8).Type ='quad X8';
MultiDrone(8).Manufacture ='3D Robotics';
MultiDrone(8).FrameWeight = 1757;%(without battery/payload) 
MultiDrone(8).BaseWeight  =1757+803;
MultiDrone(8).BatteryWeight =803;
MultiDrone(8).PayLoad =800;
MultiDrone(8).MaxThrust =0;% there is no data available
MultiDrone(8).Dimension ='350 x 510 x 200 mm';%(W x L x H)
MultiDrone(8).Battery ='Capacity: 10000mAh Voltage: 22.2V';
MultiDrone(8).Max_allow_Weight ='';
MultiDrone(8).MaxEnduranceTime ='';
MultiDrone(8).Notes ='';

%% ALTA8
% WWW.FREEFLYSYSTEMS.COM
MultiDrone(9).Name ='ALTA8';
MultiDrone(9).Type ='Octocopter';
MultiDrone(9).Manufacture ='Free Fly Systems';
MultiDrone(9).FrameWeight = 6200;%(without battery/payload) 
MultiDrone(9).BaseWeight  =6200+2800;
MultiDrone(9).BatteryWeight =18100-(9100+6200);% there is no data available
MultiDrone(9).PayLoad =9100;
MultiDrone(9).MaxThrust =0;% there is no data available
MultiDrone(9).Dimension ='1325 x 1325 x 263 mm';%(W x L x H)
MultiDrone(9).Battery ='6S';
MultiDrone(9).Max_allow_Weight ='18100';
MultiDrone(9).MaxEnduranceTime ='20 min';
MultiDrone(9).Notes ='';

%% NEW DATA 25/10/2017
%% traxxas aton
MultiDrone(9).Name ='aton';
MultiDrone(9).Type ='Quadcopter';
MultiDrone(9).Manufacture ='traxxas'; 
MultiDrone(9).EmptyWeight  =860; %with batteries 
MultiDrone(9).PayLoad =0; % camera only
MultiDrone(9).MaxThrust =0;% there is no data available
MultiDrone(9).Dimension ='472 x 472 x 94 mm';%(W x L x H)
MultiDrone(9).Max_allow_Weight ='860';
MultiDrone(9).MaxEnduranceTime ='13-15 minutes';
MultiDrone(9).Notes ='';

%% traxxas aton plus
MultiDrone(10).Name ='aton plus';
MultiDrone(10).Type ='Quadcopter';
MultiDrone(10).Manufacture ='traxxas'; 
MultiDrone(10).EmptyWeight  =860; %with batteries 
MultiDrone(10).PayLoad =0; % camera only
MultiDrone(10).MaxThrust =0;% there is no data available
MultiDrone(10).Dimension ='472 x 472 x 94 mm';%(W x L x H)
MultiDrone(10).Max_allow_Weight ='860';
MultiDrone(10).MaxEnduranceTime ='20-25 minutes';% changed the batteries
MultiDrone(10).Notes ='';

%% Turbo Ace X830-S
MultiDrone(11).Name ='X830-S';
MultiDrone(11).Type ='Quadcopter';
MultiDrone(11).Manufacture ='Turbo Ace'; 
MultiDrone(11).EmptyWeight  =1088; %Weight Without Battery & Camera mount 
MultiDrone(11).PayLoad =2358; % camera only
MultiDrone(11).MaxThrust =0;% there is no data available
MultiDrone(11).Dimension ='892 mm × 892 mm × 262 mm';%(W x L x H)
MultiDrone(11).Max_allow_Weight ='3446';
MultiDrone(11).MaxEnduranceTime ='20-25 min';
MultiDrone(11).Notes ='';

%% Turbo Ace MATRIX
MultiDrone(12).Name ='MATRIX';
MultiDrone(12).Type ='Quadcopter';
MultiDrone(12).Manufacture ='Turbo Ace'; 
MultiDrone(12).EmptyWeight  =1587.573295; %Weight Without Battery & Camera mount 
MultiDrone(12).PayLoad =1587.573295; % camera only
MultiDrone(12).MaxThrust =0;% there is no data available
MultiDrone(12).Dimension ='1000 mm × 392 mm × 135 mm';%with propellers
MultiDrone(12).Max_allow_Weight ='3175.14659';
MultiDrone(12).MaxEnduranceTime ='25 min';
MultiDrone(12).Notes ='';

%% Turbo Ace INFINITY-6
MultiDrone(13).Name ='INFINITY-6';
MultiDrone(13).Type ='Hexacopter';
MultiDrone(13).Manufacture ='Turbo Ace'; 
MultiDrone(13).EmptyWeight  =7;%Weight Without Battery & Camera mount LB unit????
MultiDrone(13).PayLoad =7.6; % LB unit????
MultiDrone(13).MaxThrust =0;% there is no data available
MultiDrone(13).Dimension ='1314mm × 1314mm × 488mm';
MultiDrone(13).Max_allow_Weight ='3175.14659';
MultiDrone(13).MaxEnduranceTime ='18 min';
MultiDrone(13).Notes ='';

%% Turbo Ace INFINITY 9PRO
MultiDrone(14).Name ='INFINITY 9PRO';
MultiDrone(14).Type ='OCTOCOPTER';
MultiDrone(14).Manufacture ='Turbo Ace'; 
MultiDrone(14).EmptyWeight  =9525.43977; % Weight With Battery
MultiDrone(14).PayLoad =9071.8474; 
MultiDrone(14).MaxThrust =0;% there is no data available
MultiDrone(14).Dimension ='1690mm × 1690mm × 610mm';
MultiDrone(14).Max_allow_Weight ='18597.28717';
MultiDrone(14).MaxEnduranceTime ='8 to 15 minutes';
MultiDrone(14).Notes ='';

%% Xaircraft X650
MultiDrone(15).Name ='X650';
MultiDrone(15).Type ='Quadcopter';
MultiDrone(15).Manufacture ='Xaircraft'; 
MultiDrone(15).EmptyWeight  =600; % Frame weight
MultiDrone(15).PayLoad =2400; 
MultiDrone(15).MaxThrust =0;% there is no data available
MultiDrone(15).Dimension ='570 mm × 570 mm';
MultiDrone(15).Max_allow_Weight ='3000';
MultiDrone(15).MaxEnduranceTime ='20 minutes';
MultiDrone(15).Notes ='';

%%  Xaircraft XMission
MultiDrone(16).Name ='XMission';
MultiDrone(16).Type ='Quadcopter';
MultiDrone(16).Manufacture ='Xaircraft'; 
MultiDrone(16).EmptyWeight  =1950; 
MultiDrone(16).PayLoad =1050; 
MultiDrone(16).MaxThrust =0;% there is no data available
MultiDrone(16).Dimension ='550 mm × 550 mm';
MultiDrone(16).Max_allow_Weight ='3000';
MultiDrone(16).MaxEnduranceTime ='16 minutes';
MultiDrone(16).Notes ='';

%%  Mi Drone 1080p Edition
MultiDrone(17).Name ='Mi Drone 1080p Edition';
MultiDrone(17).Type ='Quadcopter';
MultiDrone(17).Manufacture ='Xiaomi'; 
MultiDrone(17).EmptyWeight  =0; % unavailable
MultiDrone(17).PayLoad =0; % unavailable
MultiDrone(17).MaxThrust =0;% there is no data available
MultiDrone(17).Dimension ='550 mm × 550 mm';
MultiDrone(17).Max_allow_Weight ='1376';
MultiDrone(17).MaxEnduranceTime ='27 minutes';
MultiDrone(17).Notes ='';

%%  Typhoon H
MultiDrone(18).Name ='Typhoon H';
MultiDrone(18).Type ='Hexacopter';
MultiDrone(18).Manufacture ='Yuneec'; 
MultiDrone(18).EmptyWeight  =1950-255; % unavailable
MultiDrone(18).PayLoad =255; % unavailable
MultiDrone(18).MaxThrust =0;% there is no data available
MultiDrone(18).Dimension ='(520x457x310mm)';
MultiDrone(18).Max_allow_Weight ='1950g';
MultiDrone(18).MaxEnduranceTime ='25 minutes';
MultiDrone(18).Notes ='';

%%  Typhoon H920
MultiDrone(19).Name ='Typhoon H920';
MultiDrone(19).Type ='Hexacopter';
MultiDrone(19).Manufacture ='Yuneec'; 
MultiDrone(19).EmptyWeight  =0; % unavailable
MultiDrone(19).PayLoad =0; % unavailable
MultiDrone(19).MaxThrust =0;% there is no data available
MultiDrone(19).Dimension ='(969x849x461mm))';
MultiDrone(19).Max_allow_Weight ='(4990g)';
MultiDrone(19).MaxEnduranceTime ='24 minutes';
MultiDrone(19).Notes ='';

%% Outputs
figure
for k =1:length(MultiDrone)
    BaseWeight(k)=MultiDrone(k).BaseWeight;
    payload(k)=MultiDrone(k).PayLoad;
end
plot(payload,BaseWeight,'*')
for k =1:length(MultiDrone)
   text(payload(k),BaseWeight(k),['\leftarrow',MultiDrone(k).Name],'FontSize',8,'FontWeight','bold') 
end
grid on
title('BaseWeight vs payload')
ylabel('BaseWeight(grams)');
xlabel('payload(grams)');
xlim([0 6000])
ylim([0 6000])