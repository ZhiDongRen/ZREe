% in case you experience problems with sound under windows, change 
% all pause(1) to pause(2) or more. 
% ----------------------------------------------

disp ('test_1 - compares with -  test_1 test_2 test_3 test_4 test_5');
%figure(1); pause(1); soundsc([test_1 training_1]); 
D1=dtw (c1, c1t);
%figure(2); pause(1); soundsc([test_1 training_2]); 
D2=dtw (c2, c1t);
%figure(3); pause(1); soundsc([test_1 training_3]);
D3=dtw (c3, c1t);
%figure(4); pause(1); soundsc([test_1 training_4]); 
D4=dtw (c4, c1t);
%figure(5); pause(1); soundsc([test_1 training_5]); 
D5=dtw (c5, c1t);
disp(['DTW distance  ' num2str([D1 D2 D3 D4 D5])]); 
[m,mini]=min([D1 D2 D3 D4 D5]);  
disp(sprintf('recognized ======= %d ========\n', mini));
pause(3);

disp ('test_2 - compares with  - test_1 test_2 test_3 test_4 test_5');
%figure(1); pause(1); soundsc([test_2 training_1]); 
D1=dtw (c1, c2t);
%figure(2); pause(1); soundsc([test_2 training_2]); 
D2=dtw (c2, c2t);
%figure(3); pause(1); soundsc([test_2 training_3]);
D3=dtw (c3, c2t);
%figure(4); pause(1); soundsc([test_2 training_4]);
D4=dtw (c4, c2t);
%figure(5); pause(1); soundsc([test_2 training_5]); 
D5=dtw (c5, c2t);
disp(['DTW distance  ' num2str([D1 D2 D3 D4 D5])]); 
[m,mini]=min([D1 D2 D3 D4 D5]); 
disp(sprintf('Recognized ======= %d ========\n', mini));
pause(3);


disp ('test_3 - compares with -  test_1 test_2 test_3 test_4 test_5');
%figure(1); pause(1); soundsc([test_3 training_1]);
D1=dtw (c1, c3t);
%figure(2); pause(1); soundsc([test_3 training_2]); 
D2=dtw (c2, c3t);
%figure(3); pause(1); soundsc([test_3 training_3]); 
D3=dtw (c3, c3t);
%figure(4); pause(1); soundsc([test_3 training_4]); 
D4=dtw (c4, c3t);
%figure(5); pause(1); soundsc([test_3 training_5]); 
D5=dtw (c5, c3t);
disp(['DTW distance  ' num2str([D1 D2 D3 D4 D5])]); 
[m,mini]=min([D1 D2 D3 D4 D5]); 
 
disp(sprintf('Recognized ======= %d ========\n', mini));
pause(3);


disp ('test_4 - compares with -  test_1 test_2 test_3 test_4 test_5');
%figure(1); pause(1); soundsc([test_4 training_1]); 
D1=dtw (c1, c4t);
%figure(2); pause(1); soundsc([test_4 training_2]); 
D2=dtw (c2, c4t);
%figure(3); pause(1); soundsc([test_4 training_3]);
D3=dtw (c3, c4t);
%figure(4); pause(1); soundsc([test_4 training_4]); 
D4=dtw (c4, c4t);
%figure(5); pause(1); soundsc([test_4 training_5]); 
D5=dtw (c5, c4t);
disp(['DTW distance  ' num2str([D1 D2 D3 D4 D5])]); 
[m,mini]=min([D1 D2 D3 D4 D5]); 
disp(sprintf('Recognized ======= %d ========\n', mini));
pause(3);


disp ('test_5 - compares with -  test_1 test_2 test_3 test_4 test_5');
%figure(1); pause(1); soundsc([test_5 training_1]); 
D1=dtw (c1, c5t);
%figure(2); pause(1); soundsc([test_5 training_2]); 
D2=dtw (c2, c5t);
%figure(3); pause(1); soundsc([test_5 training_3]);
D3=dtw (c3, c5t);
%figure(4); pause(1); soundsc([test_5 training_4]); 
D4=dtw (c4, c5t);
%figure(5); pause(1); soundsc([test_5 training_5]); 
D5=dtw (c5, c5t);
disp(['DTW distance  ' num2str([D1 D2 D3 D4 D5])]); 
[m,mini]=min([D1 D2 D3 D4 D5]); 
disp(sprintf('Recognized ======= %d ========\n', mini));
pause(3);



