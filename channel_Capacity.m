k =0.1:0.001:15;
E=(2.^k-1)./k;
semilogy(10*log10(E),k,'LineWidth',2.0);
xlabel('E_b/N_o (dB)');
ylabel('Spectral Efficiency (\eta)');
title('Channel Capacity & Power efficiency limit')
hold on;
grid on;
xlim([-2 20]);
ylim([0.1 10]);
yL = get(gca,'YLim');
line([-1.59 -1.59],yL,'Color','r','LineStyle','--','LineWidth',2.0);