function Tdot = quad_eqom(t,states)
%===========Airplane Basic assumptions============%
% x direction is in the same direction of motor 1
% motor 1 rotates CW
% +ve rotating of A/C is clockwise
%===========Airplane Parameters============%
global m g Ix Iy Iz Ixz; 
global u0 v0 w0 p0 q0 r0 phi0 theta0 psi0 x0 y0 z0 trimAngle;
global  l k b;
global time_array PWM1  PWM2 PWM3 PWM4

[a,index]=min(abs(time_array-t));
PWM1_current = PWM1(index);
PWM2_current = PWM2(index);
PWM3_current = PWM3(index);
PWM4_current = PWM4(index);
acuators=[PWM1_current PWM2_current PWM3_current PWM4_current];
beta0=v0/u0;

%=========states============%
u=1; v=2; w=3; %velocities w.r.t body axes
p=4; q=5; r=6; %angular velocities
phi=7; theta=8; psi=9; %Euler angles
x=10; y=11; z=12; %position vector w.r.t inertial frame
%=========Stability drvatives===========%

global Lphi Lp Mphi Mp Nphi Np Ltheta Lq Mtheta Mq Ntheta Nq Lpsi Lr Mpsi Mr Npsi Nr ;
%===========Calculating vehicle forces============%
dX = 0;
dY = 0;
dZ = acuators*k;
%=========calculating force and moments from pg 107 Nellson============%
X=m*g*sin(trimAngle)+dX;
Y=-m*g*cos(trimAngle)*sin(phi0)+dY; 
Z=-m*g*cos(trimAngle)*cos(phi0)+dZ; 
%=========differintial equations============%

Tdot = zeros(12,1);    
Tdot(u) = (X-m*g*sin(states(theta)))/m-states(q)*states(w)+states(r)*states(v);
Tdot(v) = (Y+m*g*cos(states(theta))*sin(states(phi)))/m-states(r)*states(u)+states(p)*states(w);
Tdot(w) = ((Z+m*g*cos(states(theta))*cos(states(phi)))/m-states(p)*states(v)+states(q)*states(u));
%==Forces & Moments==%
vec=ones(length(acuators)/2,1);
vec(2:2:end)=-1;
dL =    acuators(2:2:end) *    (l(2:2:end).*k(2:2:end).*vec) + Lp*(states(p)-p0) +Lphi*(states(phi)-phi0) + Lq*(states(q)-q0) +Ltheta*(states(theta)-theta0) + Lr*(states(r)-r0) +Lpsi*(states(psi)-psi0);
vec=ones(length(acuators)/2,1);
vec(1:2:end)=-1;
dM =     acuators(1:2:end) *    (l(1:2:end).*k(1:2:end).*vec)+ Mp*(states(p)-p0) +Mphi*(states(phi)-phi0)+ Mq*(states(q)-q0) +Mtheta*(states(theta)-theta0) + Mr*(states(r)-r0) +Mpsi*(states(psi)-psi0);
vec=ones(1,length(acuators));
vec(1:2:end)=-1;
PWM = acuators.*vec;
dN = PWM*b+ Np*(states(p)-p0) +Nphi*(states(phi)-phi0)+ Nq*(states(q)-q0) +Ntheta*(states(theta)-theta0) + Nr*(states(r)-r0) +Npsi*(states(psi)-psi0);
L=dL;
M=dM; 
N=dN; 
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
end


