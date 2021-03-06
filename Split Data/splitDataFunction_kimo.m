function splitDataFunction_kimo( filePath ,delta,numCoulmn,state,Ts,Tp,dcgain_angle,dcgain_angleRate)
[folder, baseFileName, extension] = fileparts(filePath);
mkdir (fullfile([folder,'\','Figures']))
data=importdata(filePath);
deltaInput = data(:,numCoulmn);
idx = deltaInput == 1 ;
idx=diff(idx);
n = length(find(idx~=0));
startIndx=find(idx==1);
endIndx=find(idx==-1);
lineWidth=2;
for k = 1 : n/2
    if(startIndx(k)< endIndx(k))
        l1 =  startIndx(k);
        l2 =  endIndx(k);
    else
        l1 =  startIndx(k);
        l2 =  endIndx(k+1);
    end
    A=(data(l1:l2,:));
    A(:,11)=rad2deg(unwrap(deg2rad(A(:,11))));
    time =A(2:end,15)-A(1,15);
    xlswrite(fullfile([folder,'\',baseFileName,' ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' T',num2str(k),'.xlsx']),A);
    %% Transfer function extraction
    st1=state+8;
    st2=state+11;
    st3=state+1;
    st4=state+5;
    st5=11-3*state;
    B=A;
    Time=B(:,15)-B(1,15);
    roll=B(:,st1);
    p=B(:,st2);
    if st3 ==4
        PWM_Roll=abs((-B(:,5)+B(2,1)));
        PWM_Roll(1)=0;
    else PWM_Roll=(B(:,st4)-B(:,st5))/2;
    end
    if sign(B(2,st3))==-1
        if st3==4
            ind1=find(diff(PWM_Roll)<0);
        else ind1=find(diff(PWM_Roll)>0);
        end
        p=p(ind1:end);
        roll=roll(ind1:end);
        Time1=Time(ind1:end);
        PWM_Roll=PWM_Roll(ind1:end);
    else sign(B(2,st3))== 1
        ind1=find(diff(PWM_Roll)>0);
        ind2=find(diff(PWM_Roll)<0);
        p=p(ind1:ind2);
        roll=roll(ind1:ind2);
        Time1=Time(ind1:ind2);
        PWM_Roll=PWM_Roll(ind1:ind2);
        
    end
    
    s=tf('s');
    syms x y
    v_roll=4/Ts;
    eqn_roll=@(x)-Tp*v_roll+x*pi/sqrt(1-x^2);
    zeta_roll=fzero(eqn_roll,0.5);
    wn_roll=v_roll/zeta_roll;
    
    if k==1 || k==2
        dcgain_roll=dcgain_angle(1);dcgain_p=dcgain_angleRate(1);
    elseif k==3 || k==4
        
        dcgain_roll=dcgain_angle(2);dcgain_p=dcgain_angleRate(2);
        
    elseif k==5 || k==6
        
        dcgain_roll=dcgain_angle(3);dcgain_p=dcgain_angleRate(3);
        
        
    elseif k==7 || k==8
        
        dcgain_roll=dcgain_angle(4);dcgain_p=dcgain_angleRate(4);
        
    elseif k==9 || k==10
        
        dcgain_roll=dcgain_angle(5);dcgain_p=dcgain_angleRate(5);
        
        
    elseif k==11 || k==12
        
        dcgain_roll=dcgain_angle(6);dcgain_p=dcgain_angleRate(6);
        
    end
    if st3==4
        Tf_roll=dcgain_roll/(s+Tp)/s;
        Tf_p=dcgain_p/(s+Tp);
        fid1 = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),'delta',num2str(A(2,delta)),' T',num2str(k),'roll_deltaPWM_tf.txt']), 'wt' );
        fid2 = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),'delta',num2str(A(2,delta)),' T',num2str(k),'p_deltaPWM_tf.txt']), 'wt' );
        fprintf(fid1,'%s',evalc('Tf_roll'));
        fprintf(fid2,'%s',evalc('Tf_p'));
        fclose(fid1);
        fclose(fid2);
        [y_roll,t_roll]=step(Tf_roll,10);[y_p,t_p]=step(Tf_p,10);
        
    else
        Tf_roll=dcgain_roll/(s^2+2*zeta_roll*wn_roll*s+wn_roll^2);
        Tf_p=dcgain_p*(s)*(Tf_roll)/dcgain_roll;
        fid1 = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),'delta',num2str(A(2,delta)),' T',num2str(k),'roll_deltaPWM_tf.txt']), 'wt' );
        fid2 = fopen( fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),'delta',num2str(A(2,delta)),' T',num2str(k),'p_deltaPWM_tf.txt']), 'wt' );
        fprintf(fid1,'%s',evalc('Tf_roll'));
        fprintf(fid2,'%s',evalc('Tf_p'));
        fclose(fid1);
        fclose(fid2);
        [y_roll,t_roll]=step(Tf_roll,10);[y_p,t_p]=step(Tf_p,10);
    end
    
    if sign(B(2,st3))==-1
        figure (1)
        contr1=(k)/2;
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        if k ==13
            subplot(3,2,6)
        else
            subplot(3,2,contr1)
        end
        plot(Time1,roll,t_roll+20,y_roll+roll(1),'lineWidth',lineWidth)
        if state ==1
            ylabel('\phi (deg)','FontSize',18,'FontWeight','bold');
            title(' \phi versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %        legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==12
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Negative Equivelant_Roll_response.eps']),'epsc');
            end
        elseif state==2
            ylabel('\theta (deg)','FontSize',18,'FontWeight','bold');
            title('\theta versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %       legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==12
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Negative Equivelant_Pitch_response.eps']),'epsc');
            end
        elseif state==3
            
            ylabel('\psi (deg)','FontSize',18,'FontWeight','bold');
            title('\psi versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \tau = ',num2str(Tp)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %        legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==13
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Negative Equivelant_psi_response.eps']),'epsc');
            end
            
        end
        figure (2)
        if k==13
            subplot(3,2,6)
        else     subplot(3,2,contr1)
        end
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(Time1,p,t_p+20,y_p+p(1),'lineWidth',lineWidth)
        if state==1
            ylabel('p (deg/rate)','FontSize',18,'FontWeight','bold');
            title(' p versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %        legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==12
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Negative Equivelant_P_response.eps']),'epsc');
            end
        elseif state==2
            ylabel('q (deg/rate)','FontSize',18,'FontWeight','bold');
            title(' q versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %       legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==12
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Negative Equivelant_q_response.eps']),'epsc');
            end
        elseif state==3
            
            ylabel('r (deg)','FontSize',18,'FontWeight','bold');
            title(' r versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \tau = ',num2str(Tp)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %        legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==13
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Negative Equivelant_r_response.eps']),'epsc');
            end
        end
    else sign(B(2,st3))==1
        figure (3)
        if k==12
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            subplot(3,2,6)
        else
            contr2=(k+1)/2;
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            subplot(3,2,contr2)
        end
        
        plot(Time1,roll,t_roll+10,y_roll+roll(1),'lineWidth',lineWidth)
        if state==1
            ylabel('\phi (deg)','FontSize',18,'FontWeight','bold');
            title('\phi versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==11
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Positive Equivelant_Roll_response.eps']),'epsc');
            end
        elseif state==2
            ylabel('\theta (deg)','FontSize',18,'FontWeight','bold');
            title('\theta versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==11
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Positive Equivelant_Pitch_response.eps']),'epsc');
            end
        elseif state==3
            
            ylabel('\psi (deg)','FontSize',18,'FontWeight','bold');
            title('\psi versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \tau = ',num2str(Tp)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %        legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==12
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Positive Equivelant_psi_response.eps']),'epsc');
            end
        end
        figure (4)
        subplot(3,2,contr2)
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        plot(Time1,p,t_p+10,y_p+p(1),'lineWidth',lineWidth)
        if state==1
            ylabel('p (deg/rate)','FontSize',18,'FontWeight','bold');
            title(' p versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==11
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Positive Equivelant_P_response.eps']),'epsc');
            end
        elseif state==2
            ylabel('q (deg/rate)','FontSize',18,'FontWeight','bold');
            title(' q versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \zeta = ',num2str(zeta_roll),' &  \omega_{n}',num2str(wn_roll)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==11
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Positive Equivelant_q_response.eps']),'epsc');
            end
        elseif state==3
            
            ylabel('r (deg)','FontSize',18,'FontWeight','bold');
            title(' r versus time','FontSize',20,'FontWeight','bold');
            xlabel('time (sec)','FontSize',18,'FontWeight','bold');
            grid on;box on;
            title([' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k),'with \tau = ',num2str(Tp)],'FontSize',14);
            %   suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            %        legend('Act','Equ','Location','Best','FontSize',6); % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            % suptitle([' T_{s} =',num2str(Ts(1)),'sec , T_{p} =',num2str(Tp(1)),'sec']);
            if k==12
                saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' Positive Equivelant_r_response.eps']),'epsc');
            end
        end
    end
    
    
    %%
    figure(5)
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
    saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),'delta',num2str(A(2,delta)),' T',num2str(k),'_inputs.eps']),'epsc');
    figure(6)
    
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
    plot(time,A(2:end,11),'lineWidth',2);
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
%     suptitle([baseFileName,' Nom-Thrust = ',num2str(A(2,1)),' delta ',num2str(A(2,delta)),' Test #',num2str(k)])
    saveas(gcf,fullfile([folder,'\Figures\'], [baseFileName,' ',num2str(A(1,1)),'delta',num2str(A(2,delta)),' T',num2str(k),'_States.eps']),'epsc');
    all_figs = findobj(0, 'type', 'figure');
    delete(setdiff(all_figs, [1 2 3 4]));
end
end


