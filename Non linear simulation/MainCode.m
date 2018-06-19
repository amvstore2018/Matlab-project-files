clc
clear all
close all
Vehicle = 'Quad';
%figure
lineWidth=3;
legendFontSize=11;
titleFontSize=20;
labelFontSize=18;
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
    'phi (deg)' 'theta (deg)' 'psi (deg)'...
    'x (m)' 'y (m)' ' z (m)'} ;
titles = {'u' 'v' 'w'...
    'p' 'q' 'r'...
    'phi' 'theta' 'psi'...
    'x' 'y' ' z'} ;

%% Create folders
mkdir('Vehicles Figures')
mkdir ('Vehicles Figures',Vehicle)
mkdir (fullfile(['Vehicles Figures\',Vehicle]),'NonLinearResponse')
mkdir (fullfile(['Vehicles Figures\',Vehicle]),'Compare linear with the NonLinear')

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
        
        
        esc1 =                    - C_theta -C_psi;
        esc2 =     + C_phi                  +C_psi;
        esc3 =                    + C_theta -C_psi;
        esc4 =     -C_phi                   +C_psi;
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
        if thrust(index)==1650
            dampingConstant = 0.09;
            springConstant = 1.2;
        elseif thrust(index)==1700
            dampingConstant = 0.04;
            springConstant = 0.8;
        end
           
        %stability derivative paramters
        Lphi =   -0; Mphi =  0; Nphi =   0;
        Lp =     -0; Mp = -0; Np =     0;
        Ltheta = 0; Mtheta = -0; Ntheta = 0;
        Lq =     -0; Mq =     -0; Nq =     0;
        Lpsi =   0; Mpsi =   0; Npsi =   -0;
        Lr =     0; Mr =     0; Nr =     -0;
        
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
        %         saveas(h1(index+12*(i-1)),  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , [num2str(index),'.emf']]));
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
        %         saveas(gcf,  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , ['13','.emf']]));
        
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        subplot(2,3,1);grid on;
        plot(time_actual,roll_actual,time,rad2deg(Y(:,7)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
        legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
        title('phi versus time','FontSize',titleFontSize,'FontWeight','bold');
        subplot(2,3,2);grid on;
        plot(time_actual,pitch_actual,time,rad2deg(Y(:,8)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
        legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
        title('theta versus time','FontSize',titleFontSize,'FontWeight','bold');
        subplot(2,3,3);grid on;
        plot(time_actual,yaw_actual,time,rad2deg(Y(:,9)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
        legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
        title('psi versus time','FontSize',titleFontSize,'FontWeight','bold');
        subplot(2,3,4);grid on;
        plot(time_actual,p_actual,time,rad2deg(Y(:,4)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
        ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
        title('p versus time','FontSize',titleFontSize,'FontWeight','bold');
        subplot(2,3,5);grid on;
        plot(time_actual,q_actual,time,rad2deg(Y(:,5)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
        legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
        title('q versus time','FontSize',titleFontSize,'FontWeight','bold');
        subplot(2,3,6);
        plot(time_actual,r_actual,time,rad2deg(Y(:,6)),'lineWidth',lineWidth);grid on;box on;
        xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
        ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
        title('r versus time','FontSize',titleFontSize,'FontWeight','bold');
        legend('Act','NonLinear','Location','SouthEast','FontSize',legendFontSize);
        saveas(gcf,  fullfile(['Vehicles Figures\',Vehicle,'\NonLinearResponse\',[baseFileName,'\'] , ['1','.emf']]));
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
        %         saveas(gcf,  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , ['15','.emf']]));
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
        %     ylabel('ESCs','FontSize',labelFontSize,'FontWeight','bold');
        %     title('ESCs versus time','FontSize',titleFontSize,'FontWeight','bold');
        %     legend([h1,h2,h3,h4],'ESC1','ESC2','ESC3','ESC4');
        %          saveas(gcf,  fullfile(['Figures\',Vehicle,'\NonLinearResponse\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , ['input','.emf']]));
    end
end
    % % Linear Response
    % kavg = mean(k);
    % bavg = mean(b);
    % lavg = mean(l);
    % s=tf('s');
    % p_deltaLAT = lavg*kavg/Ix/s;
    % q_deltaLong = lavg*kavg/Iy/s;
    % r_deltaPend = bavg/Iz/s;
    % z_deltaCol = kavg/m/s^2;
    % PWM1 = -[10   10  0    9 10 10 10];
    % PWM2 = -[10    0  10  10 10 9 10];
    % PWM3 = -[10   10  0   10 9 10 10];
    % PWM4 = -[10    0  10  10 10 10 9];
    %% Comparing with the non linear Respose
    % for i =1:length(PWM1)
    %     acuators  = [esc1 esc2 esc3 esc4];%1,2,3,4
    %     mkdir (fullfile(['Figures\',Vehicle,'\Compare linear with the NonLinear']),['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4)] )
    %
    %     deltaCol= sum(acuators);
    %     vec=ones(length(acuators)/2,1);
    %     vec(2:2:end)=-1;
    %     deltaLAT = acuators(2:2:end)*vec;
    %     vec=ones(length(acuators)/2,1);
    %     vec(1:2:end)=-1;
    %     deltaLong = acuators(1:2:end)*vec;
    %     vec=ones(1,length(acuators));
    %     vec(1:2:end)=-1;
    %     deltaPend = acuators*vec';
    %     [y1,t1] = step(p_deltaLAT  * deltaLAT +p0,  tend);
    %     [y2,t2] = step(p_deltaLAT/s  * deltaLAT + phi0 ,  tend);
    %     [y3,t3] = step(q_deltaLong  * deltaLong + q0 ,  tend);
    %     [y4,t4] = step(q_deltaLong/s  * deltaLong + theta0 ,  tend);
    %     [y5,t5] = step(r_deltaPend  * deltaPend + r0 ,  tend);
    %     [y6,t6] = step(r_deltaPend/s  * deltaPend + psi0 ,  tend);
    %     [y7,t7] = step(z_deltaCol  * deltaCol + z0 ,  tend);
    %     [T,Y] =  ode45(@quad_eqom,[0 tend],initCondions);
    %     figure;
    %     set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    %     subplot(2,4,1)
    %     [a,h1,h2]=plotyy(t1,y1,T,Y(:,4));
    %     set(h1,'lineWidth',lineWidth+0.5)
    %     set(h2,'lineWidth',lineWidth-0.5)
    %     set(a,'FontSize',gcaFontSize)
    %     grid on
    %     hleg1=legend([h1,h2],'Linearized','Nonlinear');
    %     set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
    %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{4},'FontSize',labelFontSize,'FontWeight','bold');
    %     title(['\delta_{lat} = ',num2str(deltaLAT)],'FontSize',titleFontSize,'FontWeight','bold');
    %     subplot(2,4,2)
    %     [a,h1,h2]=plotyy(t2,y2,T,Y(:,7));
    %     set(h1,'lineWidth',lineWidth+0.5)
    %     set(h2,'lineWidth',lineWidth-0.5)
    %     set(a,'FontSize',gcaFontSize)
    %     grid on
    %     hleg1=legend([h1,h2],'Linerized','Nonlinear');
    %     set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
    %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{7},'FontSize',labelFontSize,'FontWeight','bold');
    %     title(['\delta_{lat} = ',num2str(deltaLAT)],'FontSize',titleFontSize,'FontWeight','bold');
    %     subplot(2,4,3)
    %     [a,h1,h2]=plotyy(t3,y3,T,Y(:,5));
    %     set(h1,'lineWidth',lineWidth+0.5)
    %     set(h2,'lineWidth',lineWidth-0.5)
    %     set(a,'FontSize',gcaFontSize)
    %     grid on
    %     hleg1=legend([h1,h2],'Linearized','Nonlinear');
    %     set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
    %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{5},'FontSize',labelFontSize,'FontWeight','bold');
    %     title(['\delta_{long} = ',num2str(deltaLong)],'FontSize',titleFontSize,'FontWeight','bold');
    %     subplot(2,4,4)
    %     [a,h1,h2]=plotyy(t4,y4,T,Y(:,8));
    %     set(h1,'lineWidth',lineWidth+0.5)
    %     set(h2,'lineWidth',lineWidth-0.5)
    %     set(a,'FontSize',gcaFontSize)
    %     grid on
    %     hleg1=legend([h1,h2],'Linerized','Nonlinear');
    %     set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
    %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{8},'FontSize',labelFontSize,'FontWeight','bold');
    %     title(['\delta_{long} = ',num2str(deltaLong)],'FontSize',titleFontSize,'FontWeight','bold');
    %     subplot(2,4,5)
    %     [a,h1,h2]=plotyy(t5,y5,T,Y(:,6));
    %     set(h1,'lineWidth',lineWidth+0.5)
    %     set(h2,'lineWidth',lineWidth-0.5)
    %     set(a,'FontSize',gcaFontSize)
    %     grid on
    %     hleg1=legend([h1,h2],'Linearized','Nonlinear');
    %     set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
    %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{6},'FontSize',labelFontSize,'FontWeight','bold');
    %     title(['\delta_{pend} = ',num2str(deltaPend)],'FontSize',titleFontSize,'FontWeight','bold');
    %     subplot(2,4,6)
    %     [a,h1,h2]=plotyy(t6,y6,T,Y(:,9));
    %     set(h1,'lineWidth',lineWidth+0.5)
    %     set(h2,'lineWidth',lineWidth-0.5)
    %     set(a,'FontSize',gcaFontSize)
    %     grid on
    %     hleg1=legend([h1,h2],'Linerized','Nonlinear');
    %     set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
    %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{9},'FontSize',labelFontSize,'FontWeight','bold');
    %     title(['\delta_{pend} = ',num2str(deltaPend)],'FontSize',titleFontSize,'FontWeight','bold');
    %     subplot(2,4,7)
    %     [a,h1,h2]=plotyy(t7,y7,T,Y(:,12));
    %     set(h1,'lineWidth',lineWidth+0.5)
    %     set(h2,'lineWidth',lineWidth-0.5)
    %     set(a,'FontSize',gcaFontSize)
    %     grid on
    %     hleg1=legend([h1,h2],'Linerized','Nonlinear');
    %     set(hleg1,'Location','SouthEast','FontSize',legendFontSize);
    %     xlabel('time (sec)','FontSize',labelFontSize,'FontWeight','bold');
    %     ylabel(ylabels{12},'FontSize',labelFontSize,'FontWeight','bold');
    %     title(['\delta_{col} = ',num2str(deltaCol)],'FontSize',titleFontSize,'FontWeight','bold');
    %     saveas(gcf,  fullfile(['Figures\',Vehicle,'\Compare linear with the NonLinear\',['PWMs_',num2str(esc1),'_',num2str(esc2),'_',num2str(esc3),'_',num2str(esc4),'\'] , [num2str(i),'.emf']]));
    %
    % end