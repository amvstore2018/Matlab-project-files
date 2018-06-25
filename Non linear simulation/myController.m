function [Gc,gains]=myController_V3(G_open,H_feedback,feedBack,RootLocus,zeta,wn,Type,unCertanityParamter)
sigma=-zeta*wn;
wd=wn*sqrt(1-zeta^2);
s=tf('s');
if ~isfloat(G_open)
    G_open=minreal(G_open);
end
if ~isfloat(H_feedback)
    H_feedback = minreal(H_feedback);
end
if(strcmp(feedBack,'+veFB'))
    H_feedback=-H_feedback;
elseif (strcmp(feedBack,'-veFB'))
    H_feedback=H_feedback;
end
if(strcmp(Type,'PI'))
    %% Second method
    % place a pole at the orgian
    % Place a zero to make the rootLocus pass through your desired pole
    % if angle is larger than 90 put another zero
    phase_GH_open=rad2deg(phase(evalfr(G_open*H_feedback/s,sigma+1i*wd))-2*pi);
    if(strcmp(RootLocus,'+veRL'))
        phase_PI=-360-phase_GH_open;
        while(phase_PI<0)
            phase_PI = phase_PI +360;
        end
    elseif (strcmp(RootLocus,'-veRL'))
        phase_PI=-180-phase_GH_open;
        while(phase_PI<0)
            phase_PI = phase_PI +180;
            
        end
    end

    if(phase_PI <=90 )
        z_I=wd/tand(phase_PI)-sigma;
        
        G_I=(s+z_I)/s;
        
        k = 1/abs(evalfr(G_open*G_I*H_feedback,sigma+1i*wd));
        
        Gopen_new=k*G_open*G_I;
        kp = k;
        ki = k*z_I;
        kd = 0;
    else
        z_I=wd/tand(phase_PI/unCertanityParamter)-sigma;
        G_I=(s+z_I)/s;
        phase_GH_open=rad2deg(phase(evalfr(G_open*G_I*H_feedback,sigma+1i*wd))-2*pi);
         if(strcmp(RootLocus,'+veRL'))
        phase_PD=-360-phase_GH_open;
        while(phase_PD<0)
            phase_PD = phase_PD +360;
        end
    elseif (strcmp(RootLocus,'-veRL'))
        phase_PD=-180-phase_GH_open;
        while(phase_PD<0)
            phase_PD = phase_PD +180;
            
        end
    end
        z_D=wd/tand(phase_PD)-sigma;
        G_D=(s+z_D);
        
        k = 1/abs(evalfr(G_open*G_I*G_D*H_feedback,sigma+1i*wd));
        
        Gopen_new=k*G_open*G_I*G_D;
        kp = k*(z_D+z_I);
        ki = k*z_I*z_D;
        kd = k;
    end
elseif(strcmp(Type,'P'))
    k = 1/abs(evalfr(G_open*H_feedback,sigma+1i*wd));
    Gopen_new=k*G_open;
    kp = k;
    ki = 0;
    kd = 0;
elseif(strcmp(Type,'PD'))
    phase_GH_open=rad2deg(phase(evalfr(G_open*H_feedback,sigma+1i*wd))-2*pi);
   if(strcmp(RootLocus,'+veRL'))
        phase_PD=-360-phase_GH_open;
        while(phase_PD<0)
            phase_PD = phase_PD +360;
        end
    elseif (strcmp(RootLocus,'-veRL'))
        phase_PD=-180-phase_GH_open;
        while(phase_PD<0)
            phase_PD = phase_PD +180;
            
        end
    end
    z_D=wd/tand(phase_PD)-sigma;
    
    G_D=(s+z_D);
    
    k = 1/abs(evalfr(G_open*G_D*H_feedback,sigma+1i*wd));
    
    Gopen_new=k*G_open*G_D;
    kp = k*z_D;
    ki = 0;
    kd = k;
elseif(strcmp(Type,'PI*'))
    phase_GH_open=rad2deg(phase(evalfr(G_open*H_feedback/s,sigma+1i*wd))-2*pi);
  if(strcmp(RootLocus,'+veRL'))
        phase_PI=-360-phase_GH_open;
        while(phase_PI<0)
            phase_PI = phase_PI +360;
        end
    elseif (strcmp(RootLocus,'-veRL'))
        phase_PI=-180-phase_GH_open;
        while(phase_PI<0)
            phase_PI = phase_PI +180;
            
        end
    end
    z_I=wd/tand(phase_PI)-sigma;
    
    G_I=(s+z_I)/s;
    
    k = 1/abs(evalfr(G_open*G_I*H_feedback,sigma+1i*wd));
    
    Gopen_new=k*G_open*G_I;
    kp = k;
    ki = k*z_I;
    kd = 0;
        elseif(strcmp(Type,'I'))
  
    G_I=1/s;
    
    k = 1/abs(evalfr(G_open*G_I*H_feedback,sigma+1i*wd));
    
    Gopen_new=k*G_open*G_I;
    kp = 0;
    ki = k;
    kd = 0;
      elseif(strcmp(Type,'D'))
  
    G_D=s;
    
    k = 1/abs(evalfr(G_open*G_D*H_feedback,sigma+1i*wd));
    
    Gopen_new=k*G_open*G_D;
    kp = 0;
    ki = 0;
    kd = k;
  elseif(strcmp(Type,'PID'))  
      phase_GH_open=rad2deg(phase(evalfr(G_open*H_feedback/s,sigma+1i*wd))-2*pi);
    if(strcmp(RootLocus,'+veRL'))
        phase_PI=-360-phase_GH_open;
        while(phase_PI<0)
            phase_PI = phase_PI +360;
        end
    elseif (strcmp(RootLocus,'-veRL'))
        phase_PI=-180-phase_GH_open;
        while(phase_PI<0)
            phase_PI = phase_PI +180;
            
        end
    end
       z_I=wd/tand(phase_PI/unCertanityParamter)-sigma;
        G_I=(s+z_I)/s;
        phase_GH_open=rad2deg(phase(evalfr(G_open*G_I*H_feedback,sigma+1i*wd))-2*pi);
   if(strcmp(RootLocus,'+veRL'))
        phase_PD=-360-phase_GH_open;
        while(phase_PD<0)
            phase_PD = phase_PD +360;
        end
    elseif (strcmp(RootLocus,'-veRL'))
        phase_PD=-180-phase_GH_open;
        while(phase_PD<0)
            phase_PD = phase_PD +180;
            
        end
    end
        z_D=wd/tand(phase_PD)-sigma;
        G_D=(s+z_D);
        
        k = 1/abs(evalfr(G_open*G_I*G_D*H_feedback,sigma+1i*wd));
        
        Gopen_new=k*G_open*G_I*G_D;
        kp = k*(z_D+z_I);
        ki = k*z_I*z_D;
        kd = k;
      
end

    Gc=feedback(Gopen_new,H_feedback);

gains=[kp ki kd];
end
