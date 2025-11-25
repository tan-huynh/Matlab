%% --------------------------------------
%% M.Sc Tan Huynh Ngoc
%% Hochschule Mannheim
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
title('PTT Hardware + U_y envelope + Manschetten'), xlabel('Time / s'), ylabel('Time / s');
yWidth = 0.04;                      %# y axes spacing, in second
xLimit = [min(time_pressure_ads_piezo_gefiltert_1) max(time_pressure_ads_piezo_gefiltert_1)];         %# Range of x values
xOffset = -yWidth*diff(xLimit)/ax_pos(3);
ax(3) = axes('Position',ax_pos+yWidth.*[-1 0 1 0],'XLim',xLimit+[xOffset 0]);
time_filtered_ptt_smooth_1_int = linspace((time_filtered_ptt_smooth_1(1)-xOffset),time_filtered_ptt_smooth_1(end),length(filtered_ptt_smooth_1));
time_filtered_ptt_smooth_2_int = linspace((time_filtered_ptt_smooth_2(1)-xOffset),time_filtered_ptt_smooth_2(end),length(filtered_ptt_smooth_2));
time_filtered_ptt_smooth_3_int = linspace((time_filtered_ptt_smooth_3(1)-xOffset),time_filtered_ptt_smooth_3(end),length(filtered_ptt_smooth_3));
a3 = plot(ax(3),time_filtered_ptt_smooth_1_int,filtered_ptt_smooth_1,'k--','MarkerSize',0.5,'linewidth',1.4); hold on;
plot(ax(3),time_filtered_ptt_smooth_2_int,filtered_ptt_smooth_2,'b--','MarkerSize',0.5,'linewidth',1.4); hold on;
plot(ax(3),time_filtered_ptt_smooth_3_int,filtered_ptt_smooth_3,'g--','MarkerSize',0.5,'linewidth',1.4);
set(ax(3),'ylim',[2.515 2.546]);
c = get(gca,'Children');
set(ax(3),'Color','none','YAxisLocation','left','YColor','m');
%set(ax(2),'xlim',[t_lo t_hi],'xtick',t_lo:t_hi,'ylim',[P_MIN P_MAX],'ytick',P_MIN:P_STEP:P_MAX,'Box','on');
set(ax(3),'XTickLabel',[],'FontWeight','demi'); ylabel('Voltage / V');
ax(2) = axes('Position',ax_pos);
plot(time_filtered_pressure_1, filtered_pressure_1','r-','linewidth',2,'markersize',5); hold on;
plot(time_filtered_pressure_2, filtered_pressure_2','r-','linewidth',2,'markersize',5); hold on;
plot(time_filtered_pressure_3, filtered_pressure_3','r-','linewidth',2,'markersize',5); 
b = get(gca,'Children');
set(ax(2),'Color','none','YAxisLocation','right','YColor','r');
%set(ax(2),'xlim',[t_lo t_hi],'xtick',t_lo:t_hi,'ylim',[P_MIN P_MAX],'ytick',P_MIN:P_STEP:P_MAX,'Box','on');
set(ax(2),'XTickLabel',[],'FontWeight','demi');
ylabel('Manschettendruck / mmHg');
Leg = legend([a1; a3; b], {'U_{y} envelope', 'PTT Hardware','Manschettendruck'});
Pos = get(Leg, 'Position');
set(Leg, 'Position', [Pos(1:4)]);

linkaxes([ax(1) ax(2) ax(3)], 'x'); 
