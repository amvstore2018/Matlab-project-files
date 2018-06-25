function splitDataFunction_closedloop( filePath ,numCoulmn)
[folder, baseFileName, extension] = fileparts(filePath);
mkdir (fullfile([folder,'\','Figures']))
data=importdata(filePath);
deltaInput = data(:,numCoulmn);
idx = deltaInput == 1 ;
idx=diff(idx);
n = length(find(idx~=0));
startIndx=find(idx==1);
endIndx=find(idx==-1);
for k = 1 : n/2
    if(startIndx(k)< endIndx(k))
        l1 =  startIndx(k);
        l2 =  endIndx(k);
    else
        l1 =  startIndx(k);
        l2 =  endIndx(k+1);
    end
    A=data(l1:l2,:);
    A(:,11)=rad2deg(unwrap(deg2rad(A(:,11))));
    time =A(2:end,41)-A(1,41);
    xlswrite(fullfile([folder,'\',baseFileName,' ',num2str(A(2,1)),' T',num2str(k),'.xlsx']),A);
    
    figure
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    hold all
    h1 = plot(time,A(2:end,5),'lineWidth',2);
    h2 = plot(time,A(2:end,6),'lineWidth',2);
    h3 = plot(time,A(2:end,7),'lineWidth',2);
    h4 = plot(time,A(2:end,8),'lineWidth',2);
    grid on;box on;
    hold off
    xlabel('time (sec)','FontSize',18,'FontWeight','bold');
    ylabel('ESCs','FontSize',18,'FontWeight','bold');
    title('ESCs versus time','FontSize',20,'FontWeight','bold');
    legend([h1,h2,h3,h4],'ESC1','ESC2','ESC3','ESC4');
    saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),' T',num2str(k),'_inputs.eps']),'epsc');
    figure
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
     subplot(2,3,1)
    plot(time,A(2:end,9),'lineWidth',2);
    xlabel('time (sec)','FontSize',18,'FontWeight','bold');
    ylabel('\phi (deg)','FontSize',18,'FontWeight','bold');
    title('\phi versus time','FontSize',20,'FontWeight','bold');
    grid on;box on;
 subplot(2,3,2)
    plot(time,A(2:end,10),'lineWidth',2);
    xlabel('time (sec)','FontSize',18,'FontWeight','bold');
    ylabel('\theta (deg)','FontSize',18,'FontWeight','bold');
    title('\theta versus time','FontSize',20,'FontWeight','bold');
    grid on;box on;
 subplot(2,3,3)
    plot(time,unwrap(A(2:end,11)),'lineWidth',2);
    xlabel('time (sec)','FontSize',18,'FontWeight','bold');
    ylabel('\psi (deg)','FontSize',18,'FontWeight','bold');
    title('\psi versus time','FontSize',20,'FontWeight','bold');
    grid on;box on;
 subplot(2,3,4)
    plot(time,A(2:end,12),'lineWidth',2);
    xlabel('time (sec)','FontSize',18,'FontWeight','bold');
    ylabel('p (deg/sec)','FontSize',18,'FontWeight','bold');
    title('p versus time','FontSize',20,'FontWeight','bold');
    grid on;box on;
     subplot(2,3,5)
    plot(time,A(2:end,13),'lineWidth',2);
    xlabel('time (sec)','FontSize',18,'FontWeight','bold');
    ylabel('q (deg/sec)','FontSize',18,'FontWeight','bold');
    title('q versus time','FontSize',20,'FontWeight','bold');
    grid on;box on;
 subplot(2,3,6)
    plot(time,A(2:end,14),'lineWidth',2);
    xlabel('time (sec)','FontSize',18,'FontWeight','bold');
    ylabel('r (deg/sec)','FontSize',18,'FontWeight','bold');
    title('r versus time','FontSize',20,'FontWeight','bold');
    grid on;box on;
%     suptitle(['Nom.Thrust = ',num2str(A(2,1)),' Test #',num2str(k)])
    saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),' T',num2str(k),'_States.eps']),'epsc');
  fid = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),' T',num2str(k),'_Phi_Gains.txt']), 'wt' );
fprintf(fid,'%s','Outer loop gains');
fprintf(fid,'%s',evalc('A(2,15:17)'));
fprintf(fid,'%s','Inner loop gains');
fprintf(fid,'%s',evalc('A(2,18:20)'));
fclose(fid);
  fid = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),' T',num2str(k),'_Theta_Gains.txt']), 'wt' );
fprintf(fid,'%s','Outer loop gains');
fprintf(fid,'%s',evalc('A(2,21:23)'));
fprintf(fid,'%s','Inner loop gains');
fprintf(fid,'%s',evalc('A(2,24:26)'));
fclose(fid);
  fid = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),' T',num2str(k),'_Psi_Gains.txt']), 'wt' );
fprintf(fid,'%s','Outer loop gains');
fprintf(fid,'%s',evalc('A(2,27:29)'));
fprintf(fid,'%s','Inner loop gains');
fprintf(fid,'%s',evalc('A(2,30:32)'));
fclose(fid);
fid = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),' T',num2str(k),'_Max.txt']), 'wt' );
fprintf(fid,'%s',evalc('A(2,33:36)'));
fclose(fid);
fid = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),' T',num2str(k),'_Max.txt']), 'wt' );
fprintf(fid,'%s',evalc('A(2,37:40)'));
fclose(fid);


    close all
end
end