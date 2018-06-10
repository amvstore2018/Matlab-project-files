clc
clear all 
close all
mkdir('CFD_Figures')
file = 'magCal_bar_quad.xlsx';%Airfoil points excel sheet
mx=xlsread(file,'A1:A545686');      %in m
my=xlsread(file,'B1:B545686');      %in m
mz=xlsread(file,'C1:C545686');      %in m
titleFontSize=18;
labelFontSize=14;
        figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        hold on
        plot3(mx,my,mz,'lineWidth',2);
        scatter3(mx,my,mz,'fill','MarkerFaceColor',[0 .5 .5])
        title('Flight path','FontSize',titleFontSize,'FontWeight','bold');
        xlabel('mx','FontSize',labelFontSize,'FontWeight','bold');
        ylabel('my','FontSize',labelFontSize,'FontWeight','bold');
        zlabel('mz','FontSize',labelFontSize,'FontWeight','bold');
        grid on
        hold off
        view(-30,30)
saveas(gcf,'1.emf','emf');

mx=mx-7.206941;
my=my-20.557441;
mz=mz-8.940740;
mx=1.434919  *    mx       +-0.120679*  my           -0.112642*mz;
my=-0.120679*    mx     +1.472527 *   my      +-0.055210*mz;
mz=-0.112642*    mx     +-0.055210*    my        +1.181537*mz;
      figure
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        hold on
        plot3(mx,my,mz,'lineWidth',2);
        scatter3(mx,my,mz,'fill','MarkerFaceColor',[0 .5 .5])
        title('Flight path','FontSize',titleFontSize,'FontWeight','bold');
        xlabel('mx','FontSize',labelFontSize,'FontWeight','bold');
        ylabel('my','FontSize',labelFontSize,'FontWeight','bold');
        zlabel('mz','FontSize',labelFontSize,'FontWeight','bold');
        grid on
        hold off
        view(-30,30)
        saveas(gcf,'2.emf','emf');
