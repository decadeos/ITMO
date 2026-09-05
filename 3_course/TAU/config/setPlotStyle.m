function setPlotStyle(ax, varargin)

    F = 15; L = 2.5;
    gridColor = [0.9 0.9 0.9]; gridAlpha = 0.4;
    fontName = 'DejaVu Math TeX Gyre';
    
    if nargin > 1
        for i = 1:2:length(varargin)
            switch varargin{i}
                case 'FontSize', F = varargin{i+1};
                case 'LineWidth', L = varargin{i+1};
                case 'GridColor', gridColor = varargin{i+1};
                case 'GridAlpha', gridAlpha = varargin{i+1};
                case 'FontName', fontName = varargin{i+1};
            end
        end
    end
    
    ax.FontSize = F; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
    
    grid on; grid minor; box on;
    ax.GridColor = gridColor; ax.GridAlpha = gridAlpha;
    ax.MinorGridColor = min(1, gridColor + 0.05);
    ax.MinorGridAlpha = min(1, gridAlpha + 0.1);

    set(findall(gcf, '-property', 'FontName'), 'FontName', fontName);
    set(ax, 'LineWidth', L-0.5);
    
end