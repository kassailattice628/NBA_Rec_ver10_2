function plotData(src,event)
figure(3)

plot(event.TimeStamps, event.Data(:,1))
disp('OK')
end