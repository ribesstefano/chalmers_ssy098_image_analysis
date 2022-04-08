function [Ps, us, U_true] = triangulation_test_case(noise)


U_true = rand(3,1);

C1 = rand(3,1) + [0;0;-4];
C2 = rand(3,1) + [0;0;-4];

K = diag([2000 2000 1]);

Ps{1} = K*smallRotation(0.1)*[eye(3) -C1];
Ps{2} = K*smallRotation(0.1)*[eye(3) -C2];

us(:,1) = Ps{1}*[U_true; 1];
us(:,2) = Ps{2}*[U_true; 1];

us(:,1) = us(:,1)/us(3,1) + noise*randn(3,1);
us(:,2) = us(:,2)/us(3,2) + noise*randn(3,1);

us(3,:) = [];


function R = smallRotation(max_angle)

axis = randn(3,1);
axis = axis/norm(axis);
angle = max_angle*rand;
s = axis*angle;

R = expm([0 -s(3) s(2);s(3) 0 -s(1); -s(2) s(1) 0]);