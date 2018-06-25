clc
clear all
close all
Vehicle = 'Quad';
%figure
lineWidth=3;
legendFontSize=11;
titleFontSize=18;
labelFontSize=16;
gcaFontSize=14;
%options for bode plot
opts = bodeoptions('cstprefs');
opts.XLabel.FontSize = 11;
opts.YLabel.FontSize = 11;
opts.TickLabel.FontSize=12;
opts.Title.FontSize = 13;
Data = readtable([Vehicle,'.xlsx']);
ylabels = {'u (m/s)' 'v (m/s) ' 'w (m/s)'...
    'p (deg/s)' 'q (deg/s) ' 'r (deg/s)'...
    '\phi (deg)' '\theta (deg)' '\psi (deg)'...
    'x (m)' 'y (m)' ' z (m)'} ;
titles = {'u vs Time' 'v vs Time' 'w vs Time'...
    'p vs Time' 'q vs Time' 'r vs Time'...
    '\phi vs Time' '\theta vs Time' '\psi vs Time'...
    'x vs Time' 'y vs Time' ' z vs Time'} ;
%% Run specific sections
showNonLinear=1;
showComparionWithNonlinearMode=1;
showControl=1;
showComparionWithActual=1;
%Create folders
mkdir('Vehicles Figures')
mkdir ('Vehicles Figures',Vehicle)
mkdir (fullfile(['Vehicles Figures\',Vehicle]),'NonLinearResponse')
mkdir (fullfile(['Vehicles Figures\',Vehicle]),'Control PID')
mkdir (fullfile(['Vehicles Figures\',Vehicle]),'Non. Control')
mkdir (fullfile(['Vehicles Figures\',Vehicle]),'Compare linear with the NonLinear')
mkdir (fullfile(['Vehicles Figures\',Vehicle]),'Compare with the Actual')

%Read excel
global u0 v0 w0 p0 q0 r0 phi0 theta0 psi0 x0 y0 z0 trimAngle
u0 = table2array(Data(1,2));
v0 = table2array(Data(2,2));
w0 = table2array(Data(3,2));
p0 = table2array(Data(4,2));
q0 = table2array(Data(5,2));
r0 = table2array(Data(6,2));
phi0 = table2array(Data(7,2));
theta0 = table2array(Data(8,2));
psi0 = table2array(Data(9,2));
x0 = table2array(Data(10,2));
y0 = table2array(Data(11,2));
z0 = table2array(Data(12,2));
initCondions = [u0 v0 w0 ...
    p0 q0 r0 ...
    phi0 theta0 psi0 ...
    x0 y0 z0];
trimAngle = table2array(Data(13,2));
%quad paramters
global m g Ix Iy Iz Ixz
m=table2array(Data(14,2)); % aircraft weight [Kg]
distance =table2array(Data(15,2)); % length between the C.G and motors
g=table2array(Data(16,2)); % gravity accerlation
Ix=table2array(Data(17,2)); % moment of inertia about x body axis [kg W^2]
Iy=table2array(Data(18,2)); % moment of inertia y body axis [kg W^2]
Iz=table2array(Data(19,2)); % moment of inertia z body axis [kg W^2]
Ixz=table2array(Data(20,2)); % Product of inertia [kg W^2]

%% Non Linear Simulation
global l k b;
global Lphi Lp Mphi Mp Nphi Np Ltheta Lq Mtheta Mq Ntheta Nq Lpsi Lr Mpsi Mr Npsi Nr ;
global CR_CG_distance dampingConstant springConstant;

global time_array PWM1  PWM2 PWM3 PWM4
tend = 10;
dt=0.004;
time_array=0:dt:tend;
phi = {[10 -10 20 -20 30 -30 0   0   0   0  0   0   0  0   0   0  0  0   ]...
    [10 -10 20 -20 30 -30 0   0   0   0  0   0   0  0   0   0  0  0  0 ] };
theta={[0   0  0   0  0   0  10  -10 20 -20 30 -30  0  0   0   0  0  0   ]...
    [0   0  0   0  0   0  10  -10 20 -20 30 -30  0  0   0   0  0  0   0]};
psi = {[0   0  0   0  0   0  0   0   0   0  0   0   10 -10 20 -20 30 -30 ]...
    [0   0  0   0  0   0  0   0   0   0  0   0   10 -10 20 -20 30 30 -30]};
thrust = [1650 1700];
num = {[1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6]...
    [7 8 9 10 11 12 7 8 9 10 11 12 7 8 9 10 11 12 13]};
% PWM    = 1650    |   1700
%  k     = 0.011   |   0.014
%  b     = 0.00018 |   0.00032
%  CR-CG = 0.04    |   0.04
%  nue   = 0.04    |   0.038
%motor paramters
l = distance *  ones(4,1);
k = [0.0360 0.0308 0.0343 0.0316]';%1650
% k = [0.0417 0.0369 0.0394 0.0378]';%1700
b = [5.6250e-04 5.2500e-04 5.6250e-04 5.6250e-04]';%1650
% b = [7.0000e-04 6.2500e-04 6.3750e-04  6.7500e-04]';%1700
%jig paramters
CR_CG_distance = 0.04;

%stability derivative paramters
Lphi =   -0; Mphi =  0; Nphi =   0;
Lp =     -0; Mp = -0; Np =     0;
Ltheta = 0; Mtheta = -0; Ntheta = 0;
Lq =     -0; Mq =     -0; Nq =     0;
Lpsi =   0; Mpsi =   0; Npsi =   -0;
Lr =     0; Mr =     0; Nr =     -0;
if showNonLinear ==1
    for index = 1 : length(thrust)
        for i = 1:length(phi{index})
            C_phi=phi{index}(i);
            C_theta=theta{index}(i);
            C_psi = psi{index}(i);
            if(C_phi ~=0)
                file = ['..\Split Data\Openloop Quad Figures\roll\phi ',num2str(thrust(index)),' delta ',num2str(C_phi),' T',num2str(num{index}(i)),'.xlsx'];
                
            elseif(C_theta ~=0)
                file = ['..\Split Data\Openloop Quad Figures\pitch\theta ',num2str(thrust(index)),' delta ',num2str(C_theta),' T',num2str(num{index}(i)),'.xlsx'];
                
            else
                file = ['..\Split Data\Openloop Quad Figures\yaw\psi ',num2str(thrust(index)),' delta ',num2str(C_psi),' T',num2str(num{index}(i)),'.xlsx'];
                
            end
            
            
            esc1 =                    + C_theta +C_psi;
            esc2 =     - C_phi                  -C_psi;
            esc3 =                    - C_theta +C_psi;
            esc4 =     +C_phi                   -C_psi;
            % PWM1 = 0*ones(1,length(time_array));
            % PWM2=PWM1;
            % PWM3=PWM1;
            % PWM4=PWM1;
            % [a,' &  \omega_{n} = ']=min(abs(time_array-10));
            % [a,index2]=min(abs(time_array-20));
            
            % PWM1(index1:index2) = esc1*ones(1,length(index1:index2));
            % PWM2(index1:index2) = esc2*ones(1,length(index1:index2));
            % PWM3(index1:index2) = esc3*ones(1,length(index1:index2));
            % PWM4(index1:index2) = esc4*ones(1,length(index1:index2));
            PWM1 = esc1*ones(1,length(time_array));
            PWM2 = esc2*ones(1,length(time_array));
            PWM3 = esc3*ones(1,length(time_array));
            PWM4 = esc4*ones(1,length(time_array));
            % Actual response
            [folder, baseFileName, extension] = fileparts(file);
            AcutalData = xlsread(file);%%so know we created avector named aircraft_derivatives_dimensions
            timeTotal_actual = AcutalData(3:end,15)-AcutalData(2,15);
            [a,index1]=min(abs(timeTotal_actual-10));
            [a,index2]=min(abs(timeTotal_actual-20));
            time_actual=timeTotal_actual(index1+1:index2)-timeTotal_actual(index1);
            roll_actual = AcutalData(index1+1:index2,9)-AcutalData(index1,9);
            pitch_actual = AcutalData(index1+1:index2,10)-AcutalData(index1,10);
            yaw_actual = AcutalData(index1+1:index2,11)-AcutalData(index1,11);
            p_actual = AcutalData(index1+1:index2,12)-AcutalData(index1,12);
            q_actual = AcutalData(index1+1:index2,13)-AcutalData(index1,13);
            r_actual = AcutalData(index1+1:index2,14)-AcutalData(index1,14);
            if thrust(index)==1650
                dampingConstant = 0.09;
                springConstant = 1.2;
            elseif thrust(index)==1700
                dampingConstant = 0.04;
                springConstant = 0.8;
            end
            
            mkdir (fullfile(['Vehicles Figures\',Vehicle,'\NonLinearResponse']),baseFileName)
            
            %     =====Simulation======%
            [time,Y] =  RK4(@quad_eqom,dt,[0 tend],initCondions);
            %     for index = 1:12
            %         h2 = figure(index);
            %         set(h2,'units','normalized','outerposition',[0 0 1 1]);
            %         hold all
            %         if(index == 4||index == 5||index == 6||index == 7||index == 8||index == 9 )
            %             h1(index+12*(i-1))= plot(time,rad2deg(Y(:,index)),'lineWidth',lineWidth);
            %         else
            %             h1(index+12*(i-1))= plot(time,Y(:,index),'lineWidth',lineWidth);
            %         end
            %         legend_strings{i} = ['PWMs = ',num2str(esc1),',',num2str(esc2),',',num2str(esc3),',',num2str(esc4)];   %construct the string that is the legend
            %         title([titles{index} ' VS time for ',Vehicle], 'FontSize',titleFontSize,'FontWeight','bold');
            %         xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %         ylabel(ylabels{index},'FontSize',labelFontSize,'FontWeight','bold');
            %         grid on
            %         box on
            %         hleg1=legend(h1(index:12:length(h1)),legend_strings{1:i});
            %         set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            %
            %         saveas(h1(index+12*(i-1)),  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , [num2str(index),'.eps']]));
            %     end
            %         figure
            %         set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            %         subplot(2,3,1);grid on;
            %         plot(time,Y(:,1),'lineWidth',lineWidth);grid on;box on;
            %         xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %         ylabel(ylabels{1},'FontSize',labelFontSize,'FontWeight','bold');
            %         title('u versus time','FontSize',titleFontSize,'FontWeight','bold');
            %         subplot(2,3,2);grid on;
            %         plot(time,Y(:,2),'lineWidth',lineWidth);grid on;box on;
            %         xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %         ylabel(ylabels{2},'FontSize',labelFontSize,'FontWeight','bold');
            %         title('v versus time','FontSize',titleFontSize,'FontWeight','bold');
            %         subplot(2,3,3);grid on;
            %         plot(time,Y(:,3),'lineWidth',lineWidth);grid on;box on;
            %         xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %         ylabel(ylabels{3},'FontSize',labelFontSize,'FontWeight','bold');
            %         title('w versus time','FontSize',titleFontSize,'FontWeight','bold');
            %
            %         subplot(2,3,4);grid on;
            %         plot(time,Y(:,10),'lineWidth',lineWidth);grid on;box on;
            %         xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %         ylabel(ylabels{10},'FontSize',labelFontSize,'FontWeight','bold');
            %         title('x versus time','FontSize',titleFontSize,'FontWeight','bold');
            %         subplot(2,3,5);grid on;
            %         plot(time,Y(:,11),'lineWidth',lineWidth);grid on;box on;
            %         xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %         ylabel(ylabels{11},'FontSize',labelFontSize,'FontWeight','bold');
            %         title('y versus time','FontSize',titleFontSize,'FontWeight','bold');
            %         subplot(2,3,6);
            %         plot(time,Y(:,12),'lineWidth',lineWidth);grid on;box on;
            %         xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %         ylabel(ylabels{12},'FontSize',labelFontSize,'FontWeight','bold');
            %         title('z versus time','FontSize',titleFontSize,'FontWeight','bold');
            %         saveas(gcf,  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , ['13','.eps']]));
            
            figure
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            subplot(2,3,1);grid on;
            plot(time_actual,roll_actual,time,rad2deg(Y(:,7)),'lineWidth',lineWidth);grid on;box on;
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
            legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
            title(titles{7},'FontSize',titleFontSize,'FontWeight','bold');
            subplot(2,3,2);grid on;
            plot(time_actual,p_actual,time,rad2deg(Y(:,4)),'lineWidth',lineWidth);grid on;box on;
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
            ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
            title(titles{4},'FontSize',titleFontSize,'FontWeight','bold');
            subplot(2,3,3);grid on;
            plot(time_actual,pitch_actual,time,rad2deg(Y(:,8)),'lineWidth',lineWidth);grid on;box on;
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
            legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
            title(titles{8},'FontSize',titleFontSize,'FontWeight','bold');
            subplot(2,3,4);grid on;
            plot(time_actual,q_actual,time,rad2deg(Y(:,5)),'lineWidth',lineWidth);grid on;box on;
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
            legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
            title(titles{5},'FontSize',titleFontSize,'FontWeight','bold');
            subplot(2,3,5);grid on;
            plot(time_actual,yaw_actual,time,rad2deg(Y(:,9)),'lineWidth',lineWidth);grid on;box on;
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
            legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
            title(titles{9},'FontSize',titleFontSize,'FontWeight','bold');
            subplot(2,3,6);
            plot(time_actual,r_actual,time,rad2deg(Y(:,6)),'lineWidth',lineWidth);grid on;box on;
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
            title(titles{6},'FontSize',titleFontSize,'FontWeight','bold');
            legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
            saveas(gcf,  fullfile(['Vehicles Figures\',Vehicle,'\NonLinearResponse\',[baseFileName,'\'] , ['1','.eps']]));
            %     xlim([0,4]);
            %========Plot flight path============%
            %     figure
            %             set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            %
            %     hold on
            %     fig2=plot3(Y(:,10),Y(:,11),Y(:,12),'lineWidth',2);
            %     scatter3(Y(1,10),Y(1,11),Y(1,12),'fill','MarkerFaceColor',[0 .5 .5])
            %     title(['Flight path with PWM1 = ',num2str(esc1) ,', PWM2 = ',num2str(esc2) ,', PWM3 = ',num2str(esc3) , ', PWM4 = ',num2str(esc4)], 'FontSize',titleFontSize,'FontWeight','bold');
            %     xlabel('x (m)','FontSize',labelFontSize,'FontWeight','bold');
            %     ylabel('y (m)','FontSize',labelFontSize,'FontWeight','bold');
            %     zlabel('z (m)','FontSize',labelFontSize,'FontWeight','bold');
            %     grid on
            %     hold off
            %     view(-30,30)
            %         saveas(gcf,  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , ['15','.eps']]));
            %     figure
            %     set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            %     hold all
            %     h1 = plot(time_array,PWM1,'lineWidth',2);
            %     h2 = plot(time_array,PWM2,'lineWidth',2);
            %     h3 = plot(time_array,PWM3,'lineWidth',2);
            %     h4 = plot(time_array,PWM4,'lineWidth',2);
            %     grid on;box on;
            %     hold off
            %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            %     ylabel('PWMs','FontSize',labelFontSize,'FontWeight','bold');
            %     title('PWMs versus time','FontSize',titleFontSize,'FontWeight','bold');
            %     legend([h1,h2,h3,h4],'PWM1','PWM2','PWM3','PWM4');
            %          saveas(gcf,  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , ['input','.eps']]));
        end
    end
end
% Linear Response

kavg = mean(k);
bavg = mean(b);
lavg = mean(l);
s=tf('s');
%% Comparion
if showComparionWithNonlinearMode==1
    NomThrust= [1650 1700];
    
    esc1 = [  10  0  9  10];
    esc2 = [  0  10  10  9 ];
    esc3 = [  10  0  10 10 ];
    esc4 = [  0  10  10 10 ];
    % Comparing with the non linear Respose
    for index = 1:length(NomThrust)
        for i =1:length(esc1)
            if NomThrust(index)==1650
                dampingConstant = 0.09;
                springConstant = 1.2;
            elseif NomThrust(index)==1700
                dampingConstant = 0.04;
                springConstant = 0.8;
            end
            phi_deltaLat = 180/pi*lavg*kavg/(Ix*s^2+dampingConstant * s +(m*g*CR_CG_distance+springConstant));
            p_deltaLat =  phi_deltaLat*s;
            theta_deltaLong = 180/pi*lavg*kavg/(Iy*s^2+dampingConstant * s +(m*g*CR_CG_distance+springConstant));
            q_deltaLong = theta_deltaLong *s ;
            psi_deltaPend = 180/pi*bavg/(Iz*s^2+dampingConstant * s );
            r_deltaPend = psi_deltaPend *s ;
            z_deltaCol = kavg/m/s^2;
            PWM1 = esc1(i)*ones(1,length(time_array));
            PWM2 = esc2(i)*ones(1,length(time_array));
            PWM3 = esc3(i)*ones(1,length(time_array));
            PWM4 = esc4(i)*ones(1,length(time_array));
            acuators  = [esc1(i) esc2(i) esc3(i) esc4(i)];%1,2,3,4
            mkdir (fullfile(['Vehicles Figures\',Vehicle,'\Compare linear with the NonLinear']),['NomThrust',num2str(NomThrust(index)),'PWMs_',num2str(esc1(i)),'_',num2str(esc2(i)),'_',num2str(esc3(i)),'_',num2str(esc4(i))] )
            
            deltaCol= sum(acuators);
            vec=ones(length(acuators)/2,1);
            vec(2:2:end)=-1;
            deltaLat = -1*acuators(2:2:end)*vec;
            vec=ones(length(acuators)/2,1);
            vec(1:2:end)=-1;
            deltaLong =-1* acuators(1:2:end)*vec;
            vec=ones(1,length(acuators));
            vec(1:2:end)=-1;
            deltaPend =-1* acuators*vec';
            [y1,t1] = step(p_deltaLat  * deltaLat +p0,  tend);
            [y2,t2] = step(phi_deltaLat  * deltaLat + phi0 ,  tend);
            [y3,t3] = step(q_deltaLong  * deltaLong + q0 ,  tend);
            [y4,t4] = step(theta_deltaLong  * deltaLong + theta0 ,  tend);
            [y5,t5] = step(r_deltaPend  * deltaPend + r0 ,  tend);
            [y6,t6] = step(psi_deltaPend  * deltaPend + psi0 ,  tend);
            [y7,t7] = step(z_deltaCol  * deltaCol + z0 ,  tend);
            [T,Y] =   RK4(@quad_eqom,dt,[0 tend],initCondions);
            figure;
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            subplot(4,2,1)
            [a,h1,h2]=plotyy(t2,y2,T,rad2deg(Y(:,7)));
            set(h1,'lineWidth',lineWidth+0.5)
            set(h2,'lineWidth',lineWidth-0.5)
            %             set(a,'FontSize',gcaFontSize)
            grid on
            hleg1=legend([h1,h2],'Linear','Nonlinear');
            set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
            title(['\delta_{lat} = ',num2str(deltaLat)],'FontSize',titleFontSize,'FontWeight','bold');
                L=get(a(1), 'YTick');
    set(a(1), 'YTick',[ min(L),mean(L) ,max(L)])
        L=get(a(2), 'YTick');
    set(a(2), 'YTick',[ min(L),mean(L) ,max(L)])
            subplot(4,2,2)
            [a,h1,h2]=plotyy(t1,y1,T,rad2deg(Y(:,4)));
            set(h1,'lineWidth',lineWidth+0.5)
            set(h2,'lineWidth',lineWidth-0.5)
            %             set(a,'FontSize',gcaFontSize)
            grid on
            hleg1=legend([h1,h2],'Linearized','Nonlinear');
            set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
            title(['\delta_{lat} = ',num2str(deltaLat)],'FontSize',titleFontSize,'FontWeight','bold');
          
    L=get(a(1), 'YTick');
    set(a(1), 'YTick',[ min(L),mean(L) ,max(L)])
        L=get(a(2), 'YTick');
    set(a(2), 'YTick',[ min(L),mean(L) ,max(L)])
            subplot(4,2,3)
            [a,h1,h2]=plotyy(t4,y4,T,rad2deg(Y(:,8)));
            set(h1,'lineWidth',lineWidth+0.5)
            set(h2,'lineWidth',lineWidth-0.5)
            %             set(a,'FontSize',gcaFontSize)
            grid on
            hleg1=legend([h1,h2],'Linear','Nonlinear');
            set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
            title(['\delta_{long} = ',num2str(deltaLong)],'FontSize',titleFontSize,'FontWeight','bold');
                L=get(a(1), 'YTick');
    set(a(1), 'YTick',[ min(L),mean(L) ,max(L)])
        L=get(a(2), 'YTick');
    set(a(2), 'YTick',[ min(L),mean(L) ,max(L)])
            subplot(4,2,4)
            [a,h1,h2]=plotyy(t3,y3,T,rad2deg(Y(:,5)));
            set(h1,'lineWidth',lineWidth+0.5)
            set(h2,'lineWidth',lineWidth-0.5)
            %             set(a,'FontSize',gcaFontSize)
            grid on
            hleg1=legend([h1,h2],'Linearized','Nonlinear');
            set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
            title(['\delta_{long} = ',num2str(deltaLong)],'FontSize',titleFontSize,'FontWeight','bold');
                L=get(a(1), 'YTick');
    set(a(1), 'YTick',[ min(L),mean(L) ,max(L)])
        L=get(a(2), 'YTick');
    set(a(2), 'YTick',[ min(L),mean(L) ,max(L)])
            subplot(4,2,5)
            [a,h1,h2]=plotyy(t6,y6,T,rad2deg(Y(:,9)));
            set(h1,'lineWidth',lineWidth+0.5)
            set(h2,'lineWidth',lineWidth-0.5)
            %             set(a,'FontSize',gcaFontSize)
            grid on
            hleg1=legend([h1,h2],'Linear','Nonlinear');
            set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
            title(['\delta_{pend} = ',num2str(deltaPend)],'FontSize',titleFontSize,'FontWeight','bold');
                L=get(a(1), 'YTick');
    set(a(1), 'YTick',[ min(L),mean(L) ,max(L)])
        L=get(a(2), 'YTick');
    set(a(2), 'YTick',[ min(L),mean(L) ,max(L)])
            subplot(4,2,6)
            [a,h1,h2]=plotyy(t5,y5,T,rad2deg(Y(:,6)));
            set(h1,'lineWidth',lineWidth+0.5)
            set(h2,'lineWidth',lineWidth-0.5)
            %             set(a,'FontSize',gcaFontSize)
            grid on
            hleg1=legend([h1,h2],'Linearized','Nonlinear');
            set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
            title(['\delta_{pend} = ',num2str(deltaPend)],'FontSize',titleFontSize,'FontWeight','bold');
               L=get(a(1), 'YTick');
    set(a(1), 'YTick',[ min(L),mean(L) ,max(L)])
        L=get(a(2), 'YTick');
    set(a(2), 'YTick',[ min(L),mean(L) ,max(L)])
            subplot(4,2,[7,8])
            [a,h1,h2]=plotyy(t7,y7,T,Y(:,12));
            set(h1,'lineWidth',lineWidth+0.5)
            set(h2,'lineWidth',lineWidth-0.5)
            %             set(a,'FontSize',gcaFontSize)
            grid on
            hleg1=legend([h1,h2],'Linear','Nonlinear');
            set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
            xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
            ylabel(ylabels{12},'FontSize',labelFontSize,'FontWeight','bold');
            title(['\delta_{col} = ',num2str(deltaCol)],'FontSize',titleFontSize,'FontWeight','bold');
                L=get(a(1), 'YTick');
    set(a(1), 'YTick',[ min(L),mean(L) ,max(L)])
        L=get(a(2), 'YTick');
    set(a(2), 'YTick',[ min(L),mean(L) ,max(L)])
            saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Compare linear with the NonLinear\',['NomThrust',num2str(NomThrust(index)),'PWMs_',num2str(esc1(i)),'_',num2str(esc2(i)),'_',num2str(esc3(i)),'_',num2str(esc4(i))]], '1.eps'),'epsc');
            
        end
    end
end
%% Control
global K0 K1 K2 K3 K4 K5 K6 z_d theta_d phi_d psi_d;
global simulationTime  gamma_state ay_state controlAction;
tend = 15;
dt=0.004;
time_array=0:dt:tend;
if showControl==1
    NomThrust = [1650  1700 ];
    z_deltaCol = kavg/m/s^2;
    % z -> deltaCol
    Ts0 = 4;
    OS0 = 0.01;
    zeta0=-log(OS0)/sqrt(pi^2+log(OS0)^2);
    wn0=4/Ts0/zeta0;% 4/settlingTime/zeta
    [Gc_z,k0]=myController(z_deltaCol,1,'-veFB','-veRL',zeta0,wn0,'PID',2);
    k0
    figure
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    step(Gc_z,tend);grid on;
    title(titles{12},'FontSize',titleFontSize,'FontWeight','bold');
    xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
    ylabel(ylabels{12},'FontSize',labelFontSize,'FontWeight','bold');
    saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], 'z_deltaCol.eps'),'epsc');
    for index = 1:length(NomThrust)
        disp(['NomThrust',num2str(NomThrust(index)),':'])
        if NomThrust(index)==1650
            dampingConstant = 0.09;
            springConstant = 1.2;
        elseif NomThrust(index)==1700
            dampingConstant = 0.04;
            springConstant = 0.8;
        end
        phi_deltaLat = 180/pi*lavg*kavg/(Ix*s^2+dampingConstant * s +(m*g*CR_CG_distance+springConstant));
        p_deltaLat =  phi_deltaLat*s;
        theta_deltaLong = 180/pi*lavg*kavg/(Iy*s^2+dampingConstant * s +(m*g*CR_CG_distance+springConstant));
        q_deltaLong = theta_deltaLong *s ;
        psi_deltaPend = 180/pi*bavg/(Iz*s^2+dampingConstant * s );
        r_deltaPend = psi_deltaPend *s ;
        % p -> deltaLat
        Ts1 = 2;
        OS1 = 0.01;
        zeta1=-log(OS1)/sqrt(pi^2+log(OS1)^2);
        wn1=4/Ts1/zeta1;% 4/settlingTime/zeta
        [Gc_p,k1]=myController(p_deltaLat,1,'-veFB','-veRL',zeta1,wn1,'P',2);
        k1
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        step(Gc_p,tend);grid on;
        title(titles{4},'FontSize',titleFontSize,'FontWeight','bold');
        xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'p_deltaLat.eps']),'epsc');
        % phi -> p -> deltaLat
        Ts2 = 3;
        OS2 = 0.05;
        zeta2=-log(OS2)/sqrt(pi^2+log(OS2)^2);
        wn2=4/Ts2/zeta2;% 4/settlingTime/zeta
        [Gc_phi_p,k2]=myController(Gc_p/s,1,'-veFB','-veRL',zeta2,wn2,'PI*',2);
        k2
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        step(Gc_phi_p,tend);grid on;
        title(titles{7},'FontSize',titleFontSize,'FontWeight','bold');
        xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'phi_p_deltaLat.eps']),'epsc');
        % q -> deltaLong
        Ts3 = 2;
        OS3 = 0.01;
        zeta3=-log(OS3)/sqrt(pi^2+log(OS3)^2);
        wn3=4/Ts3/zeta3;% 4/settlingTime/zeta
        [Gc_q,k3]=myController(q_deltaLong,1,'-veFB','-veRL',zeta3,wn3,'P',2);
        k3
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        step(Gc_q,tend);grid on;
        title(titles{5},'FontSize',titleFontSize,'FontWeight','bold');
        xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'q_deltaLong.eps']),'epsc');
        % theta -> q -> deltaLong
        Ts4 = 3;
        OS4 = 0.05;
        zeta4=-log(OS4)/sqrt(pi^2+log(OS4)^2);
        wn4=4/Ts4/zeta4;% 4/settlingTime/zeta
        [Gc_theta_q,k4]=myController(Gc_q/s,1,'-veFB','-veRL',zeta4,wn4,'PI*',2);
        k4
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        step(Gc_theta_q,tend);grid on;
        title(titles{8},'FontSize',titleFontSize,'FontWeight','bold');
        xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'theta_q_deltaLong.eps']),'epsc');
        % r -> deltaPend
        Ts5 = 1;
        OS5 = 0.02;
        zeta5=-log(OS5)/sqrt(pi^2+log(OS5)^2);
        wn5=4/Ts5/zeta5;% 4/settlingTime/zeta
        [Gc_r,k5]=myController(r_deltaPend,1,'-veFB','-veRL',zeta5,wn5,'P',2);
        k5
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        step(Gc_r,tend);grid on;
        title(titles{6},'FontSize',titleFontSize,'FontWeight','bold');
        xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'r_deltaPend.eps']),'epsc');
        % psi -> r -> deltaLat
        Ts6 = 3;
        OS6 = 0.01;
        zeta6=-log(OS6)/sqrt(pi^2+log(OS6)^2);
        wn6=4/Ts6/zeta6;% 4/settlingTime/zeta
        [Gc_psi_r,k6]=myController(Gc_r/s,1,'-veFB','-veRL',zeta6,wn6,'PI*',2);
        k6
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        step(Gc_psi_r,tend);grid on;
        title(titles{9},'FontSize',titleFontSize,'FontWeight','bold');
        xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'psi_r_deltaPend.eps']),'epsc');
        % Nonlinear
        z_d=(1)*ones(1,length(time_array));
        phi_d=deg2rad(0)*ones(1,length(time_array));
        theta_d=deg2rad(0)*ones(1,length(time_array));
        psi_d=deg2rad(0)*ones(1,length(time_array));
        K0 = k0;
        K1=k1; K2=k2;
        K3=k3; K4=k4;
        K5=k5; K6=k6;
        [time,Y] =  RK4(@quad_eqom_control,dt,[0 tend],initCondions);
        figure
        subplot(4,2,1)
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(time,rad2deg(Y(:,7)),'lineWidth',lineWidth);grid on;box on;
        hold all
        [y,t] = step(rad2deg(phi_d(1))*Gc_phi_p,tend);
        plot(t,y,'lineWidth',lineWidth);grid on;box on;
        hold off
        legend('Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
        title(titles{7},'FontSize',titleFontSize,'FontWeight','bold');
        subplot(4,2,2)
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(time,rad2deg(Y(:,4)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
        title(titles{4},'FontSize',titleFontSize,'FontWeight','bold');
        subplot(4,2,3)
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(time,rad2deg(Y(:,8)),'lineWidth',lineWidth);grid on;box on;
        hold all
        [y,t] = step(rad2deg(theta_d(1))*Gc_theta_q,tend);
        plot(t,y,'lineWidth',lineWidth);grid on;box on;
        hold off
        legend('Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
        title(titles{8},'FontSize',titleFontSize,'FontWeight','bold');
        subplot(4,2,4)
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(time,rad2deg(Y(:,5)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
        title(titles{5},'FontSize',titleFontSize,'FontWeight','bold');
        subplot(4,2,5)
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(time,rad2deg(Y(:,9)),'lineWidth',lineWidth);grid on;box on;
        hold all
        [y,t] = step(rad2deg(psi_d(1))*Gc_psi_r,tend);
        plot(t,y,'lineWidth',lineWidth);grid on;box on;
        hold off
        legend('Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
        title(titles{9},'FontSize',titleFontSize,'FontWeight','bold');
        subplot(4,2,6)
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(time,rad2deg(Y(:,6)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
        title(titles{6},'FontSize',titleFontSize,'FontWeight','bold');
        subplot(4,2,[7,8])
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(time,Y(:,12),'lineWidth',lineWidth);grid on;box on;
        hold all
        [y,t] = step(z_d(1)*Gc_z,tend);
        plot(t,y,'lineWidth',lineWidth);grid on;box on;
        hold off
        legend('Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{12},'FontSize',labelFontSize,'FontWeight','bold');
        title(titles{12},'FontSize',titleFontSize,'FontWeight','bold');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Non. Control'], ['NomThrust',num2str(NomThrust(index)),'_',num2str(rad2deg(phi_d(1))),'_',num2str(rad2deg(theta_d(1))),'_',num2str(rad2deg(psi_d(1))),'_',num2str(z_d(1)),'_1.eps']),'epsc');
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        hold all
        h1 = plot(simulationTime,controlAction(:,1),'lineWidth',lineWidth);
        h2 = plot(simulationTime,controlAction(:,2),'lineWidth',lineWidth);
        h3 = plot(simulationTime,controlAction(:,3),'lineWidth',lineWidth);
        h4 = plot(simulationTime,controlAction(:,4),'lineWidth',lineWidth);
        grid on;box on;
        hold off
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel('PWMs','FontSize',labelFontSize,'FontWeight','bold');
        title('PWMs versus time','FontSize',titleFontSize,'FontWeight','bold');
        legend([h1,h2,h3,h4],'PWM1','PWM2','PWM3','PWM4');
        saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Non. Control'], ['NomThrust',num2str(NomThrust(index)),'_',num2str(rad2deg(phi_d(1))),'_',num2str(rad2deg(theta_d(1))),'_',num2str(rad2deg(psi_d(1))),'_',num2str(z_d(1)),'_2.eps']),'epsc');
        
    end
end

if showComparionWithActual==1
    NomThrust = [1650  1700 ];
    z_deltaCol = kavg/m/s^2;
    % z -> deltaCol
    Ts0 = 4;
    OS0 = 0.01;
    zeta0=-log(OS0)/sqrt(pi^2+log(OS0)^2);
    wn0=4/Ts0/zeta0;% 4/settlingTime/zeta
    [Gc_z,k0]=myController(z_deltaCol,1,'-veFB','-veRL',zeta0,wn0,'PID',2);
    k0
    %     figure
    %     set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    %     step(Gc_z,tend);grid on;
    %     title(titles{12},'FontSize',titleFontSize,'FontWeight','bold');
    %     xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{12},'FontSize',labelFontSize,'FontWeight','bold');
    %     saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], 'z_deltaCol.eps'),'epsc');
    inputs = [10 -10 10 -10 90 -90];
    folders={'Test 1' 'Test 2'};
    for j = 1: length(folders)
        mkdir (fullfile(['Vehicles Figures\',Vehicle,'\Compare with the Actual']),folders{j})
        
        for i = 1 : length(inputs)
            for index = 1:length(NomThrust)
                
                disp(['NomThrust',num2str(NomThrust(index)),':'])
                if j==1
                    dampingConstant = 0.09;
                    springConstant = 1.2;
                elseif j==2
                    dampingConstant = 0.04;
                    springConstant = 0.8;
                end
                phi_deltaLat = 180/pi*lavg*kavg/(Ix*s^2+dampingConstant * s +(m*g*CR_CG_distance+springConstant));
                p_deltaLat =  phi_deltaLat*s;
                theta_deltaLong = 180/pi*lavg*kavg/(Iy*s^2+dampingConstant * s +(m*g*CR_CG_distance+springConstant));
                q_deltaLong = theta_deltaLong *s ;
                psi_deltaPend = 180/pi*bavg/(Iz*s^2+dampingConstant * s );
                r_deltaPend = psi_deltaPend *s ;
                % p -> deltaLat
                Ts1 = 2;
                OS1 = 0.01;
                zeta1=-log(OS1)/sqrt(pi^2+log(OS1)^2);
                wn1=4/Ts1/zeta1;% 4/settlingTime/zeta
                [Gc_p,k1]=myController(p_deltaLat,1,'-veFB','-veRL',zeta1,wn1,'P',2);
                k1
                %                 figure
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                %                 step(Gc_p,tend);grid on;
                %                 title(titles{4},'FontSize',titleFontSize,'FontWeight','bold');
                %                 xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
                %                 ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
                %                 saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'p_deltaLat.eps']),'epsc');
                % phi -> p -> deltaLat
                Ts2 = 3;
                OS2 = 0.05;
                zeta2=-log(OS2)/sqrt(pi^2+log(OS2)^2);
                wn2=4/Ts2/zeta2;% 4/settlingTime/zeta
                [Gc_phi_p,k2]=myController(Gc_p/s,1,'-veFB','-veRL',zeta2,wn2,'PI*',2);
                k2
                %                 figure
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                %                 step(Gc_phi_p,tend);grid on;
                %                 title(titles{7},'FontSize',titleFontSize,'FontWeight','bold');
                %                 xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
                %                 ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
                %                 saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'phi_p_deltaLat.eps']),'epsc');
                % q -> deltaLong
                Ts3 = 2;
                OS3 = 0.01;
                zeta3=-log(OS3)/sqrt(pi^2+log(OS3)^2);
                wn3=4/Ts3/zeta3;% 4/settlingTime/zeta
                [Gc_q,k3]=myController(q_deltaLong,1,'-veFB','-veRL',zeta3,wn3,'P',2);
                k3
                %                 figure
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                %                 step(Gc_q,tend);grid on;
                %                 title(titles{5},'FontSize',titleFontSize,'FontWeight','bold');
                %                 xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
                %                 ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
                %                 saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'q_deltaLong.eps']),'epsc');
                % theta -> q -> deltaLong
                Ts4 = 3;
                OS4 = 0.05;
                zeta4=-log(OS4)/sqrt(pi^2+log(OS4)^2);
                wn4=4/Ts4/zeta4;% 4/settlingTime/zeta
                [Gc_theta_q,k4]=myController(Gc_q/s,1,'-veFB','-veRL',zeta4,wn4,'PI*',2);
                k4
                %                 figure
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                %                 step(Gc_theta_q,tend);grid on;
                %                 title(titles{8},'FontSize',titleFontSize,'FontWeight','bold');
                %                 xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
                %                 ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
                %                 saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'theta_q_deltaLong.eps']),'epsc');
                % r -> deltaPend
                Ts5 = 1;
                OS5 = 0.02;
                zeta5=-log(OS5)/sqrt(pi^2+log(OS5)^2);
                wn5=4/Ts5/zeta5;% 4/settlingTime/zeta
                [Gc_r,k5]=myController(r_deltaPend,1,'-veFB','-veRL',zeta5,wn5,'P',2);
                k5
                %                 figure
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                %                 step(Gc_r,tend);grid on;
                %                 title(titles{6},'FontSize',titleFontSize,'FontWeight','bold');
                %                 xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
                %                 ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
                %                 saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'r_deltaPend.eps']),'epsc');
                % psi -> r -> deltaLat
                Ts6 = 3;
                OS6 = 0.01;
                zeta6=-log(OS6)/sqrt(pi^2+log(OS6)^2);
                wn6=4/Ts6/zeta6;% 4/settlingTime/zeta
                [Gc_psi_r,k6]=myController(Gc_r/s,1,'-veFB','-veRL',zeta6,wn6,'PI*',2);
                k6
                %                 figure
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                %                 step(Gc_psi_r,tend);grid on;
                %                 title(titles{9},'FontSize',titleFontSize,'FontWeight','bold');
                %                 xlabel('time','FontSize',labelFontSize,'FontWeight','bold');
                %                 ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
                %                 saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Control PID'], ['NomThrust',num2str(NomThrust(index)),'psi_r_deltaPend.eps']),'epsc');
                % Actual
                if thrust(index)==1650
                    file = ['..\Split Data\Closedloop Quad Figures\',folders{j},'\',folders{j},' ',num2str(thrust(index)),' T',num2str(num{index}(i)),'.xlsx'];
                elseif thrust(index)==1700
                    file = ['..\Split Data\Closedloop Quad Figures\',folders{j},'\',folders{j},' ',num2str(thrust(index)),' T',num2str(num{index}(i++length(inputs))),'.xlsx'];
                end
                % Actual response
                [folder, baseFileName, extension] = fileparts(file);
                AcutalData = xlsread(file);%%so know we created avector named aircraft_derivatives_dimensions
                timeTotal_actual = AcutalData(3:end,41)-AcutalData(2,41);
                roll_actual = AcutalData(3:end,9);
                pitch_actual = AcutalData(3:end,10);
                yaw_actual = AcutalData(3:end,11);
                p_actual = AcutalData(3:end,12);
                q_actual = AcutalData(3:end,13);
                r_actual = AcutalData(3:end,14);
                esc1_actual = AcutalData(3:end,5)-NomThrust(index);
                esc2_actual = AcutalData(3:end,6)-NomThrust(index);
                esc3_actual = AcutalData(3:end,7)-NomThrust(index);
                esc4_actual = AcutalData(3:end,8)-NomThrust(index);
                setPointPhi = AcutalData(3,2);
                setPointTheta = AcutalData(3,3);
                setPointPsi = AcutalData(3,4);
                tend = max(timeTotal_actual);
                dt=0.004;
                time_array=0:dt:tend;
                % Nonlinear
                z_d=(0)*ones(1,length(time_array));
                phi_d=deg2rad(setPointPhi)*ones(1,length(time_array));
                theta_d=deg2rad(setPointTheta)*ones(1,length(time_array));
                psi_d=deg2rad(setPointPsi)*ones(1,length(time_array));
                K0 = k0;
                K1=k1; K2=k2;
                K3=k3; K4=k4;
                K5=k5; K6=k6;
                [time,Y] =  RK4(@quad_eqom_control,dt,[0 tend],initCondions);
                figure
                subplot(3,2,1)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                               plot(timeTotal_actual,roll_actual,'lineWidth',lineWidth)

                hold all
                plot(time,rad2deg(Y(:,7)),'lineWidth',lineWidth);grid on;box on;
                [y,t] = step(rad2deg(phi_d(1))*Gc_phi_p,tend);
                plot(t,y,'lineWidth',lineWidth);grid on;box on;
                hold off
                legend('Actual','Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
                title(titles{7},'FontSize',titleFontSize,'FontWeight','bold');
                subplot(3,2,2)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                plot(timeTotal_actual,p_actual,'lineWidth',lineWidth)
                
                hold all
                plot(time,rad2deg(Y(:,4)),'lineWidth',lineWidth);grid on;box on;
                
                hold off
                legend('Actual','Nonlinear','Location','SouthEast','FontSize',legendFontSize);
                
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
                title(titles{4},'FontSize',titleFontSize,'FontWeight','bold');
                subplot(3,2,3)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                            plot(timeTotal_actual,pitch_actual,'lineWidth',lineWidth)
                hold all
                                plot(time,rad2deg(Y(:,8)),'lineWidth',lineWidth);grid on;box on;

                [y,t] = step(rad2deg(theta_d(1))*Gc_theta_q,tend);
                plot(t,y,'lineWidth',lineWidth);grid on;box on;
                hold off
                legend('Actual','Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
                title(titles{8},'FontSize',titleFontSize,'FontWeight','bold');
                subplot(3,2,4)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                plot(timeTotal_actual,q_actual,'lineWidth',lineWidth)
                hold all
                plot(time,rad2deg(Y(:,5)),'lineWidth',lineWidth);grid on;box on;
                
                hold off
                legend('Actual','Nonlinear','Location','SouthEast','FontSize',legendFontSize);
                
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
                title(titles{5},'FontSize',titleFontSize,'FontWeight','bold');
                subplot(3,2,5)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                               plot(timeTotal_actual,yaw_actual,'lineWidth',lineWidth)

                hold all
                                plot(time,rad2deg(Y(:,9)),'lineWidth',lineWidth);grid on;box on;
                [y,t] = step(rad2deg(psi_d(1))*Gc_psi_r,tend);
                plot(t,y,'lineWidth',lineWidth);grid on;box on;
                hold off
                legend('Actual','Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
                title(titles{9},'FontSize',titleFontSize,'FontWeight','bold');
                subplot(3,2,6)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                plot(timeTotal_actual,r_actual,'lineWidth',lineWidth)
                hold all
                plot(time,rad2deg(Y(:,6)),'lineWidth',lineWidth);grid on;box on;
                
                hold off
                legend('Actual','Nonlinear','Location','SouthEast','FontSize',legendFontSize);
                
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
                title(titles{6},'FontSize',titleFontSize,'FontWeight','bold');
                %                 subplot(4,2,[7,8])
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                %                 plot(time,Y(:,12),'lineWidth',lineWidth);grid on;box on;
                %                 hold all
                %                 [y,t] = step(z_d(1)*Gc_z,tend);
                %                 plot(t,y,'lineWidth',lineWidth);grid on;box on;
                %                 hold off
                %                 legend('Nonlinear','Linear','Location','SouthEast','FontSize',legendFontSize);
                %                 xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                %                 ylabel(ylabels{12},'FontSize',labelFontSize,'FontWeight','bold');
                %                 title(titles{12},'FontSize',titleFontSize,'FontWeight','bold');
                if thrust(index)==1650
                    saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Compare with the Actual\',folders{j}], ['NomThrust',num2str(NomThrust(index)),'_',num2str(rad2deg(phi_d(1))),'_',num2str(rad2deg(theta_d(1))),'_',num2str(rad2deg(psi_d(1))),'_States.eps']),'epsc');
                elseif thrust(index)==1700
                    saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Compare with the Actual\',folders{j}], ['NomThrust',num2str(NomThrust(index)),'_',num2str(rad2deg(phi_d(1))),'_',num2str(rad2deg(theta_d(1))),'_',num2str(rad2deg(psi_d(1))),'_States.eps']),'epsc');
                end
                figure
                subplot(1,2,1)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                hold all
                h1 = plot(simulationTime,controlAction(:,1),'lineWidth',lineWidth);
                h2 = plot(simulationTime,controlAction(:,2),'lineWidth',lineWidth);
                h3 = plot(simulationTime,controlAction(:,3),'lineWidth',lineWidth);
                h4 = plot(simulationTime,controlAction(:,4),'lineWidth',lineWidth);
                grid on;box on;
                hold off
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel('PWMs','FontSize',labelFontSize,'FontWeight','bold');
                legend([h1,h2,h3,h4],'PWM1','PWM2','PWM3','PWM4');
                title('Nonlinear Control Actions','FontSize',titleFontSize,'FontWeight','bold')
                subplot(1,2,2)
                set(gcf,'units','normalized','outerposition',[0 0 1 1]);
                hold all
                h1 = plot(timeTotal_actual,esc1_actual,'lineWidth',lineWidth);
                h2 = plot(timeTotal_actual,esc2_actual,'lineWidth',lineWidth);
                h3 = plot(timeTotal_actual,esc3_actual,'lineWidth',lineWidth);
                h4 = plot(timeTotal_actual,esc4_actual,'lineWidth',lineWidth);
                grid on;box on;
                hold off
                xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
                ylabel('PWMs','FontSize',labelFontSize,'FontWeight','bold');
                legend([h1,h2,h3,h4],'PWM1','PWM2','PWM3','PWM4');
                title('Actual Control Actions','FontSize',titleFontSize,'FontWeight','bold')
%                 suptitle('PWMs versus time');
                if thrust(index)==1650
                    saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Compare with the Actual\',folders{j}], ['NomThrust',num2str(NomThrust(index)),'_',num2str(rad2deg(phi_d(1))),'_',num2str(rad2deg(theta_d(1))),'_',num2str(rad2deg(psi_d(1))),'_PWMs.eps']),'epsc');
                elseif thrust(index)==1700
                    saveas(gcf,fullfile(['Vehicles Figures\',Vehicle,'\Compare with the Actual\',folders{j}], ['NomThrust',num2str(NomThrust(index)),'_',num2str(rad2deg(phi_d(1))),'_',num2str(rad2deg(theta_d(1))),'_',num2str(rad2deg(psi_d(1))),'__PWMs.eps']),'epsc');
                end
                close all
            end
        end
    end
end