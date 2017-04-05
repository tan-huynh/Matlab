%% Tan Huynh Ngoc
%% Auswertung Schlummbeger
addpath C:\Users\tan.huynhngoc\Desktop\TestPTT_Matlab\Schlumberg_Auswertung
clear all, clc, close all;
Arr_File = {
    'Schlumberger_Messformular_piezo1.xls' ...
    'Schlumberger_Messformular_piezo2.xls' ...
    'Schlumberger_Messformular_piezo3.xls'
};
data = [Arr_File{3}];
A = xlsread(data);
Freq = A(:,1); Impedanz = A(:,2); Phase = A(:,3);
figure, semilogy(Freq,Phase,'k.-',Freq,Impedanz,'r-'), grid on,
xlabel('Frequenz / Hz'), ylabel('Dek / dB'),
legend('Phase','Impedanz');