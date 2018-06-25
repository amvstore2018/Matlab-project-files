clc
clear all
close all
%figure
lineWidth=2;
legendFontSize=11;
titleFontSize=20;
labelFontSize=18;
gcaFontSize=14;
xlabels = {'PWM'};
ylabels = {'Thrust (N)' 'Torque (N.m)'} ;
titles = {'Thrust vs PWM' 'Torque vs PWM'} ;
mkdir ('Motors Data')
mkdir ('Motors Figures')
n = 4; % number of elements taken (2n+1)
reqPWM = [1650 1700];
for i = 1 : 4
    mkdir ('Motors Data',['Motor ',num2str(i)])
mkdir ('Motors Figures',['Motor ',num2str(i)])
    file = ['Motor ',num2str(i),'.xlsx'];
    motor = readtable(file);
    PWM = table2array(motor(:,1));
    Fz  = table2array(motor(:,2));
    Tz  = table2array(motor(:,3));
    for k = 1 : length(reqPWM)
        PWM_ = PWM(find(PWM == reqPWM(k))-n:find(PWM == reqPWM(k))+n);
        Fz_ = Fz(find(PWM == reqPWM(k))-n:find(PWM == reqPWM(k))+n);
        Tz_ = Tz(find(PWM == reqPWM(k))-n:find(PWM == reqPWM(k))+n);
        K = mean(diff(Fz_)./diff(PWM_));
        B = mean(diff(Tz_)./diff(PWM_));
        fid1 = fopen( fullfile(['Motors Data\Motor ',num2str(i)], [num2str(reqPWM(k)),'.txt']), 'wt' );
        fprintf(fid1,'%s',evalc('K'));
        fprintf(fid1,'%s',evalc('B'));
        fclose(fid1);
    end
    figure
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    subplot(1,2,1);grid on;
    plot(PWM,Fz,'-.*','lineWidth',lineWidth);grid on;box on;
    xlabel(xlabels{1},'FontSize',labelFontSize,'FontWeight','bold');
    ylabel(ylabels{1},'FontSize',labelFontSize,'FontWeight','bold');
    title(titles{1},'FontSize',titleFontSize,'FontWeight','bold');
    subplot(1,2,2);grid on;
    plot(PWM,Tz,'-.*','lineWidth',lineWidth);grid on;box on;
    xlabel(xlabels{1},'FontSize',labelFontSize,'FontWeight','bold');
    ylabel(ylabels{2},'FontSize',labelFontSize,'FontWeight','bold');
    title(titles{2},'FontSize',titleFontSize,'FontWeight','bold');
    saveas(gcf,  fullfile(['Motors Figures\Motor ',num2str(i)],'1.eps'),'epsc');
end
