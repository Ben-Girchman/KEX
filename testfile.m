A = imread("C:\Users\Benjamin\Desktop\KEX\exp05_gain100.tiff","tiff");
load("HR4554_DATA.mat","-mat");
load("QE_DATA.mat","-mat");

% Data for Quantum Efficiency, Flux and Lambda.

% HR4554_DATA range index i = 1715:2567 => lambda: 300nm to 1100nm 
% https://ftp.eso.org/pub/usg/standards/hststan/

data_step = ceil((2567-1715)/57);
HR4554_DATA_range = 1715:data_step:2567;

F_lambda = HR4554_DATA(HR4554_DATA_range,2,1); % Or place 1:2 in the middle if you want wavelength as well
lambda = QE_DATA(:,1); % nanometer
Quant_eff = QE_DATA(:,2);

% Convert Quantum efficiency from percent to (0.0 to 1.0)
for i=1:length(Quant_eff)
    Quant_eff(i) = Quant_eff(i)/100;
end

% Convert nanometer to Ångström in lambda
for i=1:length(lambda)
    lambda(i) = lambda(i)*10; % Ångström
end

% Convert the flux F_lambda to appropriate SI units and multiply by 10^(-16)
for i=1:length(F_lambda)
    F_lambda(i) = F_lambda(i)*10^(-16)*10^(-7); % J/(cm^2 * s * Å)
end

% Calculate the integration function G

G = zeros(length(Quant_eff),1);
for i=1:length(G)
    G(i) = lambda(i) * F_lambda(i) * Quant_eff(i); % Å * J/(cm2 s * Å) = J/(cm^2 * s)
end

% Integration by using Trapezoid rule
% Convert Ångström to meter to get correct dimension and exponent.
for i=1:length(lambda)
    lambda(i) = lambda(i)*10^(-10);
end
G_trapz = trapz(lambda,G);


% Constants
h = 6.62607015e-34; %  m^2 kg / s
c = 3e8; % m / s
t_exp = 0.5; % seconds



%{
% Exp = 0.3s, Gain = 60
range_y = 567:580; 
range_x = 1205:1220;
%}

%{
% Exp = 0.5s, Gain = 60
range_y = 410:420;
range_x = 1160:1180;
%}

%{
% Exp = 0.3s, Gain = 80
range_x = 1430:1448;
range_y = 648:660;
%}

%{
% Exp = 0.5, Gain = 80
range_x = 1458:1479;
range_y = 645:657;
%}

%{
% Exp = 0.3s, Gain = 100
range_x = 1237:1257;
range_y = 670:682;
%}


% Exp = 0.5s, Gain = 100
range_x = 1290:1310;
range_y = 667:680;
%}

resized_A = A(range_y,range_x);

%[gray_data, pixel_level] = imhist(resized_A);
%bar(pixel_level,gray_data)

bububu=double(resized_A(:));
ave=mean(bububu);
var=std(bububu);
med = median(bububu);

dim = size(resized_A);

store_matrix = zeros(dim);

for i=1:dim(1)
    for j=1:dim(2)
        store_matrix(i,j) = resized_A(i,j) - med;
    end
end

[gray_data, pixel_level] = imhist(store_matrix);
%bar(pixel_level,gray_data)

counts = 0;
for i=1:dim(1)
    for j=1:dim(2)
        counts = counts + store_matrix(i,j);
    end
end

disp("Total counts: " + counts)

A_eff = counts * h * c / (G_trapz * t_exp);

disp("Effective Area: " + A_eff + " cm^2")
