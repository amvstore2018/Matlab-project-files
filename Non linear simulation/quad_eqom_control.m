function Tdot = quad_eqom_control(t,states)
%===========Airplane Basic assumptions============%
% x direction is in the same direction of motor 1
% motor 1 rotates CW
% +ve rotating of A/C is counter-clockwise
%===========Airplane Parameters============%
global m g Ix Iy Iz Ixz; 
global u0 v0 w0 p0 q0 r0 phi0 theta0 psi0 x0 y0 z0 trimAngle;
global  l k b;
global time_array PWM1  PWM2 PWM3 PWM4;
global debug1 debug2;
persistent  z_dPrev   z_Prev  phi_dPrev phi_Prev  theta_dPrev   theta_Prev  psi_dPrev psi_Prev time_prev i ;
global K0 K1 K2 K3 K4 K5 K6 theta_d phi_d psi_d z_d;
global simulationTime  gamma_state ay_state controlAction;
persistent  errorZ  errorTheta errorQ errorPhi errorP errorPsi errorR;
persistent q_dPrev   q_Prev  p_dPrev p_Prev  r_dPrev r_Prev v_prev ay_Prev gamma_Prev;
%=========states============%
u=1; v=2; w=3; %velocities w.r.t body axes
p=4; q=5; r=6; %angular velocities
phi=7; theta=8; psi=9; %Euler angles
x=10; y=11; z=12; %position vector w.r.t inertial frame
%calculating other states%
gamma=states(theta)-atan2(states(w),states(u));
zdot = - states(u) * sin(gamma);%h is opposite than z
gamma0=theta0-trimAngle;
beta0=v0/u0;
beta = atan2(states(v),states(u));
%% Desired
[a,index]=min(abs(time_array-t));
if t==0 % must
    errorZ=0;errorTheta=0; errorPhi =0;errorPsi=0; errorP=0; errorQ=0;errorR=0;%if not empty variable
     debug1=nan(1,length(time_array));     debug2=nan(1,length(time_array));
    controlAction=nan(length(time_array),4);
    simulationTime = nan(length(time_array),1);
    ay_state = nan(length(time_array),1); 
    gamma_state = nan(length(time_array),1); 
    ay = - (states(p) * states(w) -states(u) * states(r));
    i=1;
    time_prev=0;
    theta_dPrev = 0; phi_dPrev=0; psi_dPrev=0; 
    theta_Prev=theta0;phi_Prev=phi0;psi_Prev=psi0;
    z_Prev=z0;
p_dPrev = 0; q_dPrev=0; r_dPrev=0; 
    p_Prev=p0;q_Prev=q0;r_Prev=r0;
elseif(abs(t-time_prev)>0.0001)%machine error
    ay =  (states(v)-v_prev)/(t-time_prev)- (states(p) * states(w) -states(u) * states(r));
else% same time
    ay = ay_Prev;
end
ay_state(i)=ay;
simulationTime(i)=t;
gamma_state(i)  = gamma;
% Get desired set points
theta_desired_current=theta_d(index);
phi_desired_current=phi_d(index);
psi_desired_current=psi_d(index);
z_desired_current=z_d(index);
if(abs(t-time_prev)>0.0001)
        z_dDot  = ( z_desired_current - z_dPrev ) / (t-time_prev);
    z_Dot  = ( states(z) - z_Prev ) / (t-time_prev);
    theta_dDot  = ( theta_desired_current - theta_dPrev ) / (t-time_prev);
    theta_Dot  = ( states(theta) - theta_Prev ) / (t-time_prev);
    phi_dDot  = ( phi_desired_current - phi_dPrev ) / (t-time_prev);
    phi_Dot  = ( states(phi) - phi_Prev ) / (t-time_prev);
    psi_dDot  = ( psi_desired_current - psi_dPrev ) / (t-time_prev);
    psi_Dot  = ( states(psi) - psi_Prev ) / (t-time_prev);
else
    z_dDot=0;z_Dot=0;theta_dDot=0;theta_Dot=0;phi_dDot=0;phi_Dot=0;psi_dDot=0;psi_Dot=0;
end
errorZ = errorZ + (z_desired_current - (states(z)-psi0))*(t-time_prev);
errorPhi= errorPhi +(phi_desired_current - (states(phi)-phi0))*(t-time_prev);
errorTheta = errorTheta + (theta_desired_current - (states(theta)-theta0))*(t-time_prev);
errorPsi = errorPsi + (psi_desired_current - (states(psi)-psi0))*(t-time_prev);
deltaCol_c= K0(1)*(z_desired_current - (states(z)-z0)) + K0(3)*( z_dDot - z_Dot) + K0(2)*errorZ;
p_desired_current =deg2rad( K2(1)*rad2deg((phi_desired_current - (states(phi)-phi0))) + K2(3)*rad2deg(( phi_dDot - phi_Dot)) + K2(2)*rad2deg(errorPhi));
q_desired_current =deg2rad( K4(1)*rad2deg((theta_desired_current - (states(theta)-theta0))) + K4(3)*rad2deg(( theta_dDot - theta_Dot)) + K4(2)*rad2deg(errorTheta));
r_desired_current =deg2rad( K6(1)*rad2deg((psi_desired_current - (states(psi)-psi0))) + K6(3)*rad2deg(( psi_dDot - psi_Dot)) + K6(2)*rad2deg(errorPsi));
    if(abs(t-time_prev)>0.0001)
         p_dDot  = ( p_desired_current - p_dPrev ) / (t-time_prev);
        p_Dot  = ( states(p) - p_Prev ) / (t-time_prev);
        q_dDot  = ( q_desired_current - q_dPrev ) / (t-time_prev);
        q_Dot  = ( states(q) - q_Prev ) / (t-time_prev);
         r_dDot  = ( r_desired_current - r_dPrev ) / (t-time_prev);
        r_Dot  = ( states(r) - r_Prev ) / (t-time_prev);
    else
        p_dDot  =0;q_dDot=0;r_dDot=0;
        p_Dot  =0;q_Dot=0;r_Dot=0;
    end

    errorP = errorP + (p_desired_current - (states(p)-p0))*(t-time_prev);
        errorQ = errorQ + (q_desired_current - (states(q)-q0))*(t-time_prev);
    errorR = errorR + (r_desired_current - (states(r)-r0))*(t-time_prev);
    deltaLat_c = K1(1)*rad2deg((p_desired_current - (states(p)-p0))) + K1(3)*rad2deg(( p_dDot - p_Dot)) + K1(2)*rad2deg(errorP);
    deltaLong_c = K3(1)*rad2deg((q_desired_current - (states(q)-q0))) + K3(3)*rad2deg(( q_dDot - q_Dot)) + K3(2)*rad2deg(errorQ);
    deltaPend_c = K5(1)*rad2deg((r_desired_current - (states(r)-r0))) + K5(3)*rad2deg(( r_dDot - r_Dot)) + K5(2)*rad2deg(errorR);
    phi_dPrev = phi_desired_current;    theta_dPrev = theta_desired_current;    psi_dPrev = psi_desired_current;
    phi_Prev=states(phi);               theta_Prev=states(theta);               psi_Prev=states(psi);
    p_dPrev = p_desired_current;        q_dPrev = q_desired_current;            r_dPrev = r_desired_current;
    p_Prev=states(p);                   q_Prev=states(q);                       r_Prev=states(r);
z_dPrev = z_desired_current; z_Prev=states(z); 
acuators=[0 -1 0 1 ;
          1 0 -1 0;
          1 -1 1 -1;
          1 1 1 1]^-1*[deltaLat_c deltaLong_c deltaPend_c deltaCol_c]';
      acuators = acuators';
%       esc1 =                    + deltaLong_c +deltaPend_c;
%       esc2 =     - deltaLat_c                  -deltaPend_c;
%       esc3 =                    - deltaLong_c +deltaPend_c;
%       esc4 =     +deltaLat_c                   -deltaPend_c;
%       acuators = [esc1 esc2 esc3 esc4];
controlAction(i,:)=acuators;
%=========Stability drvatives===========%
global CR_CG_distance dampingConstant springConstant;

global Lphi Lp Mphi Mp Nphi Np Ltheta Lq Mtheta Mq Ntheta Nq Lpsi Lr Mpsi Mr Npsi Nr ;
%===========Calculating vehicle forces============%
X0 = m*g*sin(trimAngle);dX = 0;
Y0 = -m*g*cos(trimAngle)*sin(phi0);dY = 0;
Z0 = -m*g*cos(trimAngle)*cos(phi0);dZ = acuators*k;
%=========calculating force and moments from pg 107 Nellson============%
X=X0+dX;
Y=Y0+dY; 
Z=Z0+dZ; 
%=========differintial equations============%

Tdot = zeros(12,1);    
Tdot(u) = (X-m*g*sin(states(theta)))/m-states(q)*states(w)+states(r)*states(v);
Tdot(v) = (Y+m*g*cos(states(theta))*sin(states(phi)))/m-states(r)*states(u)+states(p)*states(w);
Tdot(w) = ((Z+m*g*cos(states(theta))*cos(states(phi)))/m-states(p)*states(v)+states(q)*states(u));
%===========Calculating vehicle moments============%
vec=ones(length(acuators)/2,1);
vec(2:2:end)=-1;
dL =     acuators(2:2:end) *    (-1*l(2:2:end).*k(2:2:end).*vec) + Lp*(states(p)-p0) +Lphi*(states(phi)-phi0) + Lq*(states(q)-q0) +Ltheta*(states(theta)-theta0) + Lr*(states(r)-r0) +Lpsi*(states(psi)-psi0);
vec=ones(length(acuators)/2,1);
vec(1:2:end)=-1;
dM =     acuators(1:2:end) *    (-1*l(1:2:end).*k(1:2:end).*vec)+ Mp*(states(p)-p0) +Mphi*(states(phi)-phi0)+ Mq*(states(q)-q0) +Mtheta*(states(theta)-theta0) + Mr*(states(r)-r0) +Mpsi*(states(psi)-psi0);
vec=ones(1,length(acuators));
vec(1:2:end)=-1;
PWM = -1*acuators.*vec;
dN = PWM*b+ Np*(states(p)-p0) +Nphi*(states(phi)-phi0)+ Nq*(states(q)-q0) +Ntheta*(states(theta)-theta0) + Nr*(states(r)-r0) +Npsi*(states(psi)-psi0);
% L0 = -m*g*CR_CG_distance * cos(states(theta))*sin(states(phi)) - dampingConstant * (states(p) +states(q) * sin(states(phi)) *tan(states(theta))+states(r) * cos(states(phi)) *tan(states(theta)))- springConstant *states(phi);
L0 = -m*g*CR_CG_distance * cos(states(theta))*sin(states(phi)) - dampingConstant * states(p) - springConstant *states(phi);
 M0 = -m*g*CR_CG_distance * sin(states(theta))- dampingConstant * states(q)- springConstant *states(theta);
% M0 = -m*g*CR_CG_distance * sin(states(theta))- dampingConstant * (0 +states(q) * cos(states(phi))-states(r) * sin(states(phi)))- springConstant *states(theta);
N0 = - dampingConstant * states(r);
L=L0+dL;
M=M0+dM; 
N=N0+dN; 
%=========differintial equations============%
Tdot(p) =1/(Ixz^2-Ix*Iz)*(-Iz*(L+Ixz*states(p)*states(q))-Ixz*(N+states(p)*states(q)*(Ix-Iy))+states(q)*states(r)*(Ixz^2+Iz*(Iz-Iy)));
Tdot(q) =(M-states(r)*states(p)*(Ix-Iz)-Ixz*(states(p)^2-states(r)^2))/Iy;
Tdot(r) =1/(Ix*Iz-Ixz^2)*(Ixz^2*states(p)*states(q)+Ix*(N+states(p)*states(q)*(Ix-Iy))+Ixz*(L-states(q)*states(r)*(Ix-Iy+Iz)));
Tdot(phi)=states(p)+states(q)*sin(states(phi))*tan(states(theta))+states(r)*cos(states(phi))*tan(states(theta));
Tdot(theta)=states(q)*cos(states(phi))-states(r)*sin(states(phi));
Tdot(psi)=(states(q)*sin(states(phi))+states(r)*cos(states(phi)))*sec(states(theta));
Tdot(x) =cos(states(theta))*cos(states(psi))*states(u)+(sin(states(phi))*sin(states(theta))*cos(states(psi))-cos(states(phi))*sin(states(psi)))*states(v)+(cos(states(phi))*sin(states(theta))*cos(states(psi))+sin(states(phi))*sin(states(psi)))*states(w);
Tdot(y) =cos(states(theta))*sin(states(psi))*states(u)+(sin(states(phi))*sin(states(theta))*sin(states(psi))+cos(states(phi))*cos(states(psi)))*states(v)+(cos(states(phi))*sin(states(theta))*sin(states(psi))-sin(states(phi))*cos(states(psi)))*states(w);
Tdot(z) =-sin(states(theta))*states(u)+sin(states(phi))*cos(states(theta))*states(v)+cos(states(phi))*cos(states(theta))*states(w);
time_prev=t;
v_prev= states(v);
ay_Prev=ay;
gamma_Prev  = gamma;
i=i+1;
end


