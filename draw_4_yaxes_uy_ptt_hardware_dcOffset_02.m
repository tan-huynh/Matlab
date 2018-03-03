%% --------------------------------------
%% M.Sc Tan Huynh Ngoc
%% Hochschule Mannheim
%% huynh.ngoctan@yahoo.com
%% --------------------------------------

figure,
set(gcf,'NextPlot','add');
ax(1) = axes; ax_pos = get(ax(1),'Position'); hold on; 
a1 = plot(time_pressure_ads_piezo_gefiltert_1,diff_env_max_min_1,'k.-','MarkerSize',0.5,'linewidth',1.4), hold on, grid on;
plot(time_pressure_ads_piezo_gefiltert_2,diff_env_max_min_2,'b.-','MarkerSize',0.5,'linewidth',1.4), hold on;
plot(time_pressure_ads_piezo_gefiltert_3,diff_env_max_min_3,'g.-','MarkerSize',0.5,'linewidth',1.4);
a = get(gca,'Children');
%set(ax(1),'xlim',[t_lo t_hi]);
%set(ax(1),'ylim',[2.515 2.535]);
title('DC\_Offset + PTT Hardware + U_y envelope + Manschetten'), xlabel('Time / s'), ylabel('Voltage / V -- U_{y} envelope');
yWidth1 = 0.04;                      %# y axes spacing, in second
xLimit1 = [min(time_pressure_ads_piezo_gefiltert_1) max(time_pressure_ads_piezo_gefiltert_1)];         %# Range of x values
xOffset1 = -yWidth1*diff(xLimit1)/ax_pos(3);
ax(3) = axes('Position',ax_pos+yWidth1.*[-1 0 1 0],'XLim',xLimit1+[xOffset1 0]);
time_filtered_ptt_smooth_1_int = linspace((time_filtered_ptt_smooth_1(1)-xOffset1),time_filtered_ptt_smooth_1(end),length(filtered_ptt_smooth_1));
time_filtered_ptt_smooth_2_int = linspace((time_filtered_ptt_smooth_2(1)-xOffset1),time_filtered_ptt_smooth_2(end),length(filtered_ptt_smooth_2));
time_filtered_ptt_smooth_3_int = linspace((time_filtered_ptt_smooth_3(1)-xOffset1),time_filtered_ptt_smooth_3(end),length(filtered_ptt_smooth_3));
a3 = plot(ax(3),time_filtered_ptt_smooth_1_int,filtered_ptt_smooth_1,'k--','MarkerSize',0.5,'linewidth',1.4); hold on;
plot(ax(3),time_filtered_ptt_smooth_2_int,filtered_ptt_smooth_2,'b--','MarkerSize',0.5,'linewidth',1.4); hold on;
plot(ax(3),time_filtered_ptt_smooth_3_int,filtered_ptt_smooth_3,'g--','MarkerSize',0.5,'linewidth',1.4);
set(ax(3),'ylim',[2.515 2.546]);
c = get(gca,'Children');
set(ax(3),'Color','none','YAxisLocation','left','YColor','m');
set(ax(3),'XTickLabel',[],'FontWeight','demi'); ylabel('Voltage / V -- PTT Hardware');

yWidth2 = 0.08;                      %# y axes spacing, in second
xLimit2 = [min(time_filtered_ptt_smooth_1_int) max(time_filtered_ptt_smooth_1_int)];         %# Range of x values
xOffset2 = -yWidth2*diff(xLimit2)/ax_pos(3);
ax(4) = axes('Position',ax_pos+yWidth2.*[-1 0 1 0],'XLim',xLimit2+[xOffset2 0]);
time_filtered_dcOff_1 = linspace((time_filtered_smooth_1(1)-xOffset2),time_filtered_smooth_1(end),length(filtered_AP_smooth_1));
time_filtered_dcOff_2 = linspace((time_filtered_smooth_2(1)-xOffset2),time_filtered_smooth_2(end),length(filtered_AP_smooth_2));
time_filtered_dcOff_3 = linspace((time_filtered_smooth_3(1)-xOffset2),time_filtered_smooth_3(end),length(filtered_AP_smooth_3));
MarkerIndices1  = 1:1000:length(filtered_AD_smooth_1);
MarkerIndices2  = 1:1000:length(filtered_AD_smooth_2);
MarkerIndices3  = 1:1000:length(filtered_AD_smooth_3);
a4 = plot(ax(4),time_filtered_dcOff_1(MarkerIndices1),filtered_AP_smooth_1(MarkerIndices1),'k--o','MarkerSize',4,'linewidth',1.4); hold on; 
a5 = plot(ax(4),time_filtered_dcOff_1(MarkerIndices1),filtered_AD_smooth_1(MarkerIndices1),'k--v','MarkerSize',4,'linewidth',1.4);
	 plot(ax(4),time_filtered_dcOff_2(MarkerIndices2),filtered_AP_smooth_2(MarkerIndices2),'b--o','MarkerSize',4,'linewidth',1.4); hold on;
	 plot(ax(4),time_filtered_dcOff_2(MarkerIndices2),filtered_AD_smooth_2(MarkerIndices2),'b--v','MarkerSize',4,'linewidth',1.4);
	 plot(ax(4),time_filtered_dcOff_3(MarkerIndices3),filtered_AP_smooth_3(MarkerIndices3),'g--o','MarkerSize',4,'linewidth',1.4); hold on;
	 plot(ax(4),time_filtered_dcOff_3(MarkerIndices3),filtered_AD_smooth_3(MarkerIndices3),'g--v','MarkerSize',4,'linewidth',1.4);
%set(ax(4),'ylim',[2.515 2.546]);
d = get(gca,'Children');
set(ax(4),'Color','none','YAxisLocation','left','YColor','r');
set(ax(4),'XTickLabel',[],'FontWeight','demi'); ylabel('Voltage / V -- DC Offset');

ax(2) = axes('Position',ax_pos);
plot(time_filtered_pressure_1, filtered_pressure_1','r-','linewidth',2,'markersize',5); hold on;
plot(time_filtered_pressure_2, filtered_pressure_2','r-','linewidth',2,'markersize',5); hold on;
plot(time_filtered_pressure_3, filtered_pressure_3','r-','linewidth',2,'markersize',5); 
b = get(gca,'Children');
set(ax(2),'Color','none','YAxisLocation','right','YColor','r');
%set(ax(2),'xlim',[t_lo t_hi],'xtick',t_lo:t_hi,'ylim',[P_MIN P_MAX],'ytick',P_MIN:P_STEP:P_MAX,'Box','on');
set(ax(2),'XTickLabel',[],'FontWeight','demi');
ylabel('Manschettendruck / mmHg');
Leg = legend([a1; a3; a4; a5; b], {'U_{y} envelope', 'PTT Hardware','DC Offset Prox','DC Offset Dist','Manschettendruck'});
Pos = get(Leg, 'Position');
set(Leg, 'Position', [Pos(1:4)]);
linkaxes([ax(1) ax(2) ax(3)], 'x'); 