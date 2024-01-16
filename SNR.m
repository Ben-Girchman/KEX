A = imread("C:\Users\Benjamin\Desktop\KEX\mag_zen_pic.tiff","tiff");

% Indices
i = 0;
j = 1;

% Range of the x-axis of the matrix
range_1920 = 1:16;

% Standard deviation and average matrices
avg_matrix = zeros(1,9120);
std_matrix = zeros(1,9120);
index_mat = zeros(1,9120);

% Allocate values of A that does not exceed 7000 to store_matrix. Rest is
% zero.

dim = size(A);
store_matrix = zeros(dim);
for k=1:dim(1)
    for l=1:dim(2)
        if A(k,l) < 5400
            store_matrix(k,l) = A(k,l);
        else
            store_matrix(k,l) = 0;
        end
    end
end

% Main code. Takes the mean and standard deviation of all nonzero values.
while true
    B = store_matrix(i+1:i+16, range_1920);
    %counts = sum(B,"all");
    %disp(counts)
    avg_matrix(j) = mean(nonzeros(B));
    std_matrix(j) = std(nonzeros(B));
    j = j+1;
    i = i+16;
    %disp(j)
    %disp(j)
    if i == 1216
        i = 0;
        range_1920 = range_1920 + 16;
        %disp(range_1920)
        if range_1920(length(range_1920)) > 1920
            break
        end
    end
end

scatter(avg_matrix,std_matrix,'.')
xlabel("Average")
ylabel("Standard deviation")

