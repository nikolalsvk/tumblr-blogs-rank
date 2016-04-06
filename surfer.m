function [G] = surfer(U)

% Initialize

[n, t] = size(U);
G = zeros(n, n);
m = 1;

for j = 1:n
   
    % Try to open a page.

    try
        disp(['open ' num2str(j) ' ' U{j}])
        page = urlread(U{j});
    catch
        disp(['fail ' num2str(j) ' ' U{j}])
        continue
    end

    % Follow the links from the open page.

    for f = findstr('http:', page);

        % A link starts with 'http:' and ends with 'tumblr.com/'

        e = min(findstr('tumblr.com/', page(f:end)));
        if isempty(e) 
            continue
        end
        url = deblank(page(f:f+e+8)); % Removes trailing blank from end of string
        url(url < ' ') = '!'; % Nonprintable characters
        if url(end) == '/' 
            url(end) = []; 
        end

        % Look for links that should be skipped.

        skips = {'.gif', '.jpg', '.pdf', '.png', '.css', 'lmscadsi', 'cybernet', ...
                'search.cgi', '.ram', 'www.w3.org', 'nofollow', '.swf', 'media' ...
                'scripts', 'netscape', 'shockwave', 'webex', 'fansonly', 'ogp' ...
                'assets', 'static', 'weheartit', 'pinterest', 'via', 'ref'};
        skip = any(url == '!') | any(url == '?');
        k = 0;
        while ~skip & (k < length(skips))
            k = k + 1;
            skip = ~isempty(findstr(url, skips{k}));
        end
        if skip
            if isempty(findstr(url, '.gif')) & isempty(findstr(url, '.jpg'))
                disp(['     skip ' url])
            end
            continue
        end

        % Check if page is already in url list.

        i = 0;
        for k = 1:n
            if isequal(U{k}, url)
                i = k;
                break
            end
        end
        
        % If the page is already in URL list move on to the next page
        if (i == 0) & (m < n)
            m = m + 1;
        end

        % Add a new link to G

        if i > 0
            disp(['     link ' int2str(i) ' ' url])
            G(i,j) = 1;
        end
    end
    
    ocene = num2cell(ones(n, 1));
    U = [U ocene];
end



%------------------------

function h = hashfun(url)
% Almost unique numeric hash code for pages already visited.
h = length(url) + 1024*sum(url);
