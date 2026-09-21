% clc; clear;
% 
% syms x1 x2 real
% 
% systems = {
%     {[-x1 + 2*x1^3 + x2; -x1 - x2], [x1; x2]};
%     {[x1 + x1*x2; -x2 + x2^2 + x1*x2 - x1^3], [x1; x2]};
%     {[x2; -x1 + x2*(1-x1^2+0.1*x1^4)], [x1; x2]};
%     {[(x1-x2)*(1-x1^2-x2^2); (x1+x2)*(1-x1^2-x2^2)], [x1; x2]};
%     {[-x1^3 + x2; x1 - x2^3], [x1; x2]};
%     {[-x1^3 + x2^3; x2^3*x1 - x2^3], [x1; x2]}
% };
% 
% for i = 1:length(systems)
%     fprintf("> Система %0d", i); fprintf("\n");
%     sys  = systems{i}{1};
%     vars = systems{i}{2}; 
% 
%     sol = solve(sys == 0, vars, 'Real', true);
% 
%     pts = [];
%     for v = 1:length(vars)
%         pts = [pts, double(sol.(char(vars(v))))];
%     end;
%     pts
% 
%     J = jacobian(sys, vars)
%     fprintf("\n");
% 
%     for k = 1:size(pts, 1)
%         fprintf(">> Точка %0d", k); fprintf("\n");
%         Ak = subs(J, vars.', pts(k, :)) 
%         fprintf("\n");
%         eig_vals = eig(double(Ak))
%         fprintf("\n");
%     end;
% 
% end;


clc; clear;

syms x1 x2 x3 real

sys7 = [-x1^3 + x2^3; x1 + 3*x3 - x2^3; x1*x3 - x2^3 - sin(x1)];
vars7 = [x1; x2; x3];

sol7 = vpasolve(sys7 == 0, vars7, [-50 50; -50 50; -50 50]);

pts7 = [];
for v = 1:length(vars7)
    pts7 = [pts7, double(sol7.(char(vars7(v))))];
end
pts7 = unique(round(pts7, 8), 'rows')

J7 = jacobian(sys7, vars7);

fprintf("> Система 7\n");
disp('Матрица Якоби:');
disp(J7);
fprintf("\nНайденные точки равновесия:\n");
disp(pts7);

for k = 1:size(pts7, 1)
    fprintf(">> Точка %0d (%s)\n", k, mat2str(pts7(k,:), 6));
    Ak = subs(J7, vars7.', pts7(k, :));
    disp('Матрица A:');
    disp(double(Ak));
    eig_vals = eig(double(Ak));
    disp('Собственные числа:');
    disp(eig_vals);
    fprintf("\n");
end