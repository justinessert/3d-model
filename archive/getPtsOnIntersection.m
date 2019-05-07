function points = getPtsOnIntersection( params1, params2 )
% Gets two points on the intersection of two planes

points = zeros(2,3);
for c=0:1
    % Try setting z=[0,1]
    a = [params1(1:2); params2(1:2)];
    A = a'*a;
    % If A is singular then z=[0,1] is not a point on the intersection
    if rank(A)>1
        z = [-(c*params1(3)+params1(4));-(c*params2(3)+params2(4))];
        x = A\(a'*z);
        points(c+1,:) = [x' c];
    else
        % If z=0 is not a point on the intersection, try setting x=[0,1]
        a = [params1(2:3); params2(2:3)];
        A = a'*a;
        % If A is singular then x=[0,1] is not a point on the intersection
        if rank(A)>1
            z = [-(c*params1(1)+params1(4));-(c*params2(1)+params2(4))];
            x = A\(a'*z);
            points(c+1,:) = [c x'];
        else
            % Finally, if x=[0,1] and z=[0,1] are not on the intersection
            % Then y=[0,1] must be on the intersection, so use that
            a = [params1(1,3); params2(1,3)];
            A = a'*a;
            z = [-(c*params1(2)+params1(4));-(c*params2(2)+params2(4))];
            x = A\(a'*z);
            points(c+1,:) = [x(1) c x(2)];
        end
    end
end


end

