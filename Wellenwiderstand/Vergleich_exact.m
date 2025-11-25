%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Simulation von der Anpassung des Wellenwiderstand 
%% Autor: Huynh Ngoc Tan
%% MABEL Insitut, Hochschule Mannheim, Deutschland

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all; clc;

par = @(x,y) (x.*y)./(x+y);
serie = @(x,y) (x+y);

% KONSTANTEN UND PARAMETER WENN FC1 >FL1
R1 = 13e0; % 13 Ohm/km
G1 = 1e-5;
L1 = 1.5e-6; % 1.5uH/km
C1 = 6.12e-9; % 6.12nF/km

Z_lower1=sqrt(L1/C1);
Z_upper1=sqrt(R1/G1);

f_lo = 10e-3; % Unterer Frequenzwert 0.01 Hz
f_hi = 10e9; % Oberer Frequenzwert  10 GHz
f_L1 = 1./(2*pi*L1/R1);
f_C1 = 1./(2*pi*C1/G1); 

% Frequenzachse (don#t touch!!!)
f = logspace(log10(f_lo),log10(f_hi),1000); % Frequenzvektor 

% GLEICHUNG
pC1 = 1./sqrt(i*2*pi*f*(C1/R1)); % lower C

% LOG. KURVENVERLAUF
figure('color','w'); line_width = 1.5;
loglog([1e-2 5e10],[1 1],'k'); hold on;
loglog([1 1],[1e-4 1e8],'k');

Z1 = par(Z_upper1,pC1);
Z1 = serie(Z1,Z_lower1);

% BEDINGUNG
if (Z_upper1 > Z_lower1) 
    loglog(f,Z_upper1*ones(size(f)),'-.','color',[0.49 0 0],'Linewidth',1.1);
    loglog(f,Z_lower1*ones(size(f)),'-.','color',[0.51 0 0],'Linewidth',1.1);
    loglog([f_L1, f_L1],get(gca,'YLim'),'--','color',[0.99 0 1]);
    loglog([f_C1, f_C1],get(gca,'YLim'),'--','color',[0.98 0 1]);
    loglog(f(10:end),abs(pC1(10:end)),'r-.','Linewidth',line_width);
end

%loglog(f(1:end-9),abs(Z1(10:end)),'color',[1 0.5 0],'Linewidth',line_width);
xlabel('f / Hz'); 
set(gca,'FontSize',10);
text(0.625,5e7,' \uparrow','HorizontalAlignment','left','FontSize',10)
text(5e10,1.1,' \rightarrow','HorizontalAlignment','left','FontSize',10)
axis on
grid on

set(gca,'yscale','log') %# to set the y-axis to logarithmic
set(gca,'xscale','log') %# to set the x-axis to logarithmic

xlabel('f / Hz'); 
ylabel ('Magnitude / dB'); 
title('Vergleich in Wellenwiderstand Anpassung 01');

set(gca,'XLim',[f(1) f(end)],'XTick',10.^[log10(f_lo):1:log10(f_hi)],...
        'YLim',sort(ylim));
% --------------------------------------------------------------------
% EIN BEISPIEL 
R3 = 13e0; % 13 Ohm/km
G3 = 1e-5;
L3 = 1.5e-6; % 1.5 uH/km
C3 = 6.12e-9; % 6.12nF/km

% bei Frequenz f = 800Hz
fo = 850; % Anpassung bei f = 800Hz
Z = sqrt(1+(R3/(2*pi*fo*L3)).^2);
Phi = -atan(R3./(2*pi*fo*L3));
a = abs(Z)^0.5*cos(Phi/2);
b = abs(Z)^0.5*abs(sin(Phi/2));

R_L = a*sqrt(L3/C3);
C_L = 1./(2*pi*fo*b*sqrt(L3/C3));
pC_L = 1./(i*2*pi*f*C_L);

f_inter = abs(1./(i*2*pi*C_L*R_L));
f_intersect = sprintf('%d (Hz) between R_L und C_L in HF',f_inter)
f_C_L = abs(C1./(i*2*pi*C_L^2));
f_intersect_C_L = sprintf('%d (Hz) between C_L und C_L **',abs(C1./(i*2*pi*C_L^2)))
f_R_L = abs(1./(i*2*pi*C1*R_L^2));
f_intersect_R_L = sprintf('%d (Hz) between R_L und C_L **',abs(1./(i*2*pi*C1*R_L^2)))

% Gemeinsam Widerstand nach dem Last
if(R_L >= R1)
Z_anpassung = serie(serie(pC_L, pC1),R_L);
elseif (R_L < R1)
Z_anpassung = serie(serie(pC_L, pC1),Z1);
end

loglog(f,R_L*ones(size(f)),'color',[0 0.99 1],'Linewidth',line_width);
loglog(f(10:end),abs(pC_L(10:end)),'color',[0 0.98 1],'Linewidth',line_width);
loglog(f(10:end),abs(Z_anpassung(10:end)),'k-.','Linewidth',1.5);

% Information 
disp(sprintf('-->>-- Geometrische Mittel zwischen f_intersect_C_L and f_intersect_R_L --<<--\n-->>-- passt die Bedingung der Wellenwiderstand-Anpassung --<<--'))
f_geomittel = sqrt(f_C_L.*f_R_L)
% Vergleich mit dem Formel HF und der Method in Bode
Z_phi3(fo) = sqrt(L3/C3).*abs(sqrt(1-i*(R3/(2*pi*L3))/fo));
Z_phi1(fo) = abs(sqrt((R1+i*2*pi*fo*L1)/(G1+i*2*pi*fo*C1)));
Z_phi_1 = sqrt((R1+i*2*pi*f*L1)./(G1+i*2*pi*f*C1));
loglog(f(10:end),abs(Z_phi_1(10:end)),'b-.','Linewidth',line_width);
% --- Suchen den Wert b wenn Anpassung sein ---
format longEng 
for k = 0.001:0.0001:15
R_such = Z_phi1(fo)./k;
C_such = 1./(2*pi*R_such*fo);
if (round(R_such.*C_such, 8) == round((1./(2*pi*fo)),8)) && (round(R_such./C_such,8) == round(Z_phi1(fo)^2*(2*pi*fo),8))
    break
end
end

disp('[k >> R_L >> C_L]')
result = [k R_such C_such]

pC_such = 1./(i*2*pi*f*C_such);
loglog(f,R_such*ones(size(f)),'color',[0 0.61 0],'Linewidth',line_width);
loglog(f(10:end),abs(pC_such(10:end)),'color',[0 0.59 0],'Linewidth',line_width);

if (R1 >= R_such)
    Z2 = serie(serie(pC_such,pC1),Z1);
elseif (R1 < R_such)
    Z2 = serie(serie(pC_such,pC1),R_such);
end
loglog(f(1:end-9),abs(Z2(10:end)),'color',[1 0 0],'Linewidth',line_width);

% Legend für multiple Graphiks
a = findobj('Color',[0 0.61 0]);
b = findobj('Color',[0 0.59 0]);
c = findobj('Color',[1 0 0]);
d = findobj('Color',[0 0.99 1]);
e = findobj('Color',[0 0.98 1]);
f = findobj('Color','k');
h = findobj('Color','b');
v = [a(1) b(1) c(1) d(1) e(1) f(1) h(1)];
legend(v,'R\_such in Bode','C\_such in Bode','Z2','R_L in HF','pC_L in HF','Z\_anpassung in HF','Z\_phi1','location', 'NorthEastOutside','Interpreter', 'none');
%---------------------------------------------------------------
disp('Der Wert von b ist')
 fileID = fopen('b.txt','w');
 fprintf(fileID,'%10s  %11s\n','fo(Hz)','Result(b)');
if true
for fo = 100:5:1e5
Z = sqrt(1+(R3/(2*pi*fo*L3)).^2);
Phi = -atan(R3./(2*pi*fo*L3));
a = abs(Z)^0.5*cos(Phi/2);
R_L = a*sqrt(L3/C3);

Z_phi = abs(sqrt((R1+i*2*pi*fo*L1)./(G1+i*2*pi*fo*C1)));
b = [fo; Z_phi./R_L];
fprintf(fileID,'%10.2f  %12.12f\n',b);

end
end
fclose(fileID);
