% Credit for this function: https://stackoverflow.com/questions/1023948/rotate-normal-vector-onto-axis-plane
function R = get_rot_mat(n)
    b = acos(n(2) / sqrt(n(1)*n(1) + n(2)*n(2)));
    if (n(1) >= 0)
        Rb = [cos(-b) -sin(-b) 0; sin(-b) cos(-b) 0; 0 0 1];
    else
        Rb = [cos(-b) sin(-b) 0; -sin(-b) cos(-b) 0; 0 0 1];
    end
    n2 = n * Rb;
    a = acos(n2(3) / sqrt(n2(2)*n2(2) + n2(3)*n2(3)));
    Ra = [1 0 0; 0 cos(-a) -sin(-a); 0 sin(-a) cos(-a)];
    R = Rb * Ra;
end