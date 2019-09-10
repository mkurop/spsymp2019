function [index] = binarySearchRows(A, n, num)

%--------------------------------------------------------------------------
% Syntax:       [index] = binarySearch(A, n, num);
%               
% Inputs:       A: matrix (row sorted) that you want to search
%               n: Length of array A
%               num: vector you want to search in array A
%               
% Outputs:      index: Return position in A that A(index,:) == num
%                      or -1 if num does not exist in A
%               
% Description:  This function find number in array (sorted) using binary
%               search
%               
% Complexity:   O(1)    best-case performance
%               O(log_2 (n))    worst-case performance
%               O(1)      auxiliary space
%               
% Author:       Trong Hoang Vo
%               hoangtrong2305@gmail.com
%               
% Date:         March 31, 2016
%--------------------------------------------------------------------------

left = 1;
right = n;
flag = 0;

while left <= right
    mid = ceil((left + right) / 2);
    
    if prod(A(mid,:) == num)
        index = mid;
        flag = 1;
        break;
    else
        if lessVecs(num,A(mid,:))
        right = mid - 1;
        else
            left = mid + 1;
        end
    end
end

if flag == 0
    index = -1;
end

end

function [less_equal] = lessVecs(a,b)
if length(a) ~= length(b)
    error('a and b vecs should be of the same length ...');
end
for i = 1:length(a)
    if a(i) == b(i)
        continue
    else
        less_equal = (a(i) < b(i));
        return
    end        
end
less_equal = true;
end
