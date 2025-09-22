% Скрипт для построения графиков из данных task2
clear all;
close all;
clc;

% Параметры стиля
lineWidth = 2.5;
axisLineWidth = 1.5;
fontSize = 13;
fontName = 'DejaVuMathTeXGyre';
gridColor = [0.9, 0.9, 0.9];
minorGridColor = [0.95, 0.95, 0.95];
textColor = [0.3, 0.3, 0.3];

colors = [
    0.8, 0.2, 0.2;    % красный
    0.0, 0.2, 0.6;    % синий
    0.2, 0.6, 0.2;    % зеленый
    0.6, 0.2, 0.6     % фиолетовый
];

% Создаем структуру для хранения данных
signals_data = struct();

% 1. Обрабатываем model_upr.slx
if exist('model_upr.slx', 'file')
    disp('Обрабатываем model_upr.slx...');
    load_system('model_upr.slx');
    simOut = sim('model_upr.slx');
    
    % Извлекаем данные из SimulationOutput
    signals_data.upr.time = simOut.y_upr.time;
    signals_data.upr.values = simOut.y_upr.signals.values;
    signals_data.upr.name = 'y_{upr}';
    disp('✓ Данные model_upr извлечены');
    
    close_system('model_upr.slx', 0);
end

% 2. Обрабатываем model_diag.slx
if exist('model_diag.slx', 'file')
    disp('Обрабатываем model_diag.slx...');
    load_system('model_diag.slx');
    simOut = sim('model_diag.slx');
    
    % Извлекаем данные из SimulationOutput
    signals_data.diag.time = simOut.y_diag.time;
    signals_data.diag.values = simOut.y_diag.signals.values;
    signals_data.diag.name = 'y_{diag}';
    disp('✓ Данные model_diag извлечены');
    
    close_system('model_diag.slx', 0);
end

% 3. Обрабатываем model_nabl.slx
if exist('model_nabl.slx', 'file')
    disp('Обрабатываем model_nabl.slx...');
    load_system('model_nabl.slx');
    simOut = sim('model_nabl.slx');
    
    % Извлекаем данные из SimulationOutput
    signals_data.nabl.time = simOut.y_nabl.time;
    signals_data.nabl.values = simOut.y_nabl.signals.values;
    signals_data.nabl.name = 'y_{nabl}';
    disp('✓ Данные model_nabl извлечены');
    
    close_system('model_nabl.slx', 0);
end

% 4. Обрабатываем model_Wp.slx
if exist('model_Wp.slx', 'file')
    disp('Обрабатываем model_Wp.slx...');
    load_system('model_Wp.slx');
    simOut = sim('model_Wp.slx');
    
    % Извлекаем данные из SimulationOutput
    signals_data.Wp.time = simOut.y_Wp.time;
    signals_data.Wp.values = simOut.y_Wp.signals.values;
    signals_data.Wp.name = 'y_{Wp}';
    disp('✓ Данные model_Wp извлечены');
    
    close_system('model_Wp.slx', 0);
end

% Проверяем, есть ли данные для построения
if isempty(fieldnames(signals_data))
    error('Не удалось получить данные ни от одной модели');
end

% Создаем график
figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;

% Массивы для легенды
legend_entries = {};
color_index = 1;

% Перебираем все собранные данные
fields = fieldnames(signals_data);
for i = 1:length(fields)
    field_name = fields{i};
    data = signals_data.(field_name);
    
    if isfield(data, 'time') && isfield(data, 'values')
        plot(data.time, data.values, ...
            'LineWidth', lineWidth, ...
            'Color', colors(color_index, :));
        
        legend_entries{end+1} = data.name;
        color_index = color_index + 1;
        
        if color_index > size(colors, 1)
            color_index = 1;
        end
    end
end

hold off;

% Настройка осей
ax = gca;
set(ax, 'LineWidth', axisLineWidth, ...
        'FontSize', fontSize, ...
        'FontName', fontName, ...
        'XColor', textColor, ...
        'YColor', textColor);

yline(3.5, '--', 'LineWidth', 2, 'Color', [0.5, 0.5, 0.5], ...
    'DisplayName', 'Set value (3.5)');


% Добавляем мягкую сетку
grid on;
grid minor;
set(ax, 'GridColor', gridColor, ...
        'GridAlpha', 0.4, ...
        'MinorGridColor', minorGridColor, ...
        'MinorGridAlpha', 0.2);

% Подписи осей
xlabel('Time', 'FontSize', fontSize+1, 'FontWeight', 'normal', 'Color', textColor);
ylabel('Amplitude', 'FontSize', fontSize+1, 'FontWeight', 'normal', 'Color', textColor);

% Легенда
if ~isempty(legend_entries)
    legend(legend_entries, 'Location', 'southeast', 'FontSize', fontSize+1, 'TextColor', textColor);
end

% Улучшаем внешний вид
box on;
set(gcf, 'Color', 'w');

% Автоматическое масштабирование
ylim_auto = ylim;
ylim([ylim_auto(1), ylim_auto(2) * 1.05]);

% Сохраняем график
output_path = '../../images/task2/signals.png';
exportgraphics(gcf, output_path, 'Resolution', 300);
disp(['График сохранен: ' output_path]);

disp('Все модели обработаны успешно!');