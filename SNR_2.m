A = imread("C:\Users\Benjamin\Desktop\KEX\mag_zen_pic.tiff","tiff");

%    Y        X
mat_1 =  A(896:945, 530:622); mean_1 = mean(mat_1(:)); std_1 = std(double(mat_1(:)));
mat_2 = A(811:840, 500:558); mean_2 = mean(mat_2(:)); std_2 = std(double(mat_2(:)));
mat_3 = A(293:358, 600:715); mean_3 = mean(mat_3(:)); std_3 = std(double(mat_3(:)));
mat_4 = A(1145:1179, 1796:1844); mean_4 = mean(mat_4(:)); std_4 = std(double(mat_4(:)));
mat_5 = A(280:380, 550:712); mean_5 = mean(mat_5(:)); std_5 = std(double(mat_5(:)));
mat_6 = A(1029:1073, 1003:1073); mean_6 = mean(mat_6(:)); std_6 = std(double(mat_6(:)));
mat_7 = A(487:534, 1494:1565); mean_7 = mean(mat_7(:)); std_7 = std(double(mat_7(:)));
mat_8 = A(890:955, 1385:1478); mean_8 = mean(mat_8(:)); std_8 = std(double(mat_8(:)));
mat_9 = A(365:415, 1043:1121); mean_9 = mean(mat_9(:)); std_9 = std(double(mat_9(:)));
mat_10 = A(1046:1097, 375:460); mean_10 = mean(mat_10(:)); std_10 = std(double(mat_10(:)));
mat_11 = A(460:505, 1633:1697); mean_11 = mean(mat_11(:)); std_11 = std(double(mat_11(:)));
mat_12 = A(273:331, 50:135); mean_12 = mean(mat_12(:)); std_12 = std(double(mat_12(:)));
mat_13 = A(1053:1095, 1101:1162); mean_13 = mean(mat_13(:)); std_13 = std(double(mat_13(:)));
mat_14 = A(575:631, 835:911); mean_14 = mean(mat_14(:)); std_14 = std(double(mat_14(:)));
mat_15 = A(283:383, 578:733); mean_15 = mean(mat_15(:)); std_15 = std(double(mat_15(:)));
mat_16 = A(476:527, 1147:1229); mean_16 = mean(mat_16(:)); std_16 = std(double(mat_16(:)));
mat_17= A(474:536, 599:714); mean_17 = mean(mat_17(:)); std_17 = std(double(mat_17(:)));
mat_18 = A(55:99, 1466:1566); mean_18 = mean(mat_18(:)); std_18 = std(double(mat_18(:)));
mat_19 = A(108:153, 1003:1101); mean_19 = mean(mat_19(:)); std_19 = std(double(mat_19(:)));
mat_20 = A(865:915, 340:390); mean_20 = mean(mat_20(:)); std_20 = std(double(mat_20(:)));


mean_mat = [mean_1,mean_2,mean_3,mean_4,mean_5,mean_6,mean_7,mean_8,mean_9,mean_10,mean_11,mean_12,mean_13,mean_14,mean_15,mean_16,mean_17,mean_18,mean_19,mean_20];
std_mat = [std_1,std_2,std_3,std_4,std_5,std_6,std_7,std_8,std_9,std_10,std_11,std_12,std_13,std_14,std_15,std_16,std_17,std_18,std_19,std_20];

SNR = zeros(1,20);
for i = 1:20
    SNR(i) = mean_mat(i)/std_mat(i);
end

scatter(mean_mat,SNR)
xlabel("Mean")
ylabel("SNR")

%scatter(std_mat, mean_mat)
%ylabel("Mean")
%xlabel("Standard deviation")


