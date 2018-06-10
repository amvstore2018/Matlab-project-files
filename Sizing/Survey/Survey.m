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