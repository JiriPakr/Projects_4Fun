function b = gray2bin(g)
    b(1) = g(1);
    for i = 2 : length(g)
        x = xor(str2double(b(i-1)), str2double(g(i)));
        b(i) = num2str(x);
    end
end