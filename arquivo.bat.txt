@echo off
echo Criando estrutura MVC para fitness_app...

REM Criar nova estrutura de pastas
mkdir lib\src\fitness_app\controllers
mkdir lib\src\fitness_app\views\screens
mkdir lib\src\fitness_app\views\widgets\bottom_navigation
mkdir lib\src\fitness_app\views\widgets\ui_components
mkdir lib\src\fitness_app\views\widgets\diary
mkdir lib\src\fitness_app\services
mkdir lib\src\fitness_app\config

REM Mover arquivos para nova estrutura
echo Movendo arquivos...

REM Mover tema para config
move lib\src\fitness_app\fitness_app_theme.dart lib\src\fitness_app\config\

REM Mover telas para views/screens
move lib\src\fitness_app\fitness_app_home_screen.dart lib\src\fitness_app\views\screens\
move lib\src\fitness_app\my_diary\my_diary_screen.dart lib\src\fitness_app\views\screens\
move lib\src\fitness_app\training\training_screen.dart lib\src\fitness_app\views\screens\

REM Mover bottom navigation
move lib\src\fitness_app\bottom_navigation_view\bottom_bar_view.dart lib\src\fitness_app\views\widgets\bottom_navigation\

REM Mover componentes UI
move lib\src\fitness_app\ui_view\*.dart lib\src\fitness_app\views\widgets\ui_components\

REM Mover widgets do diary
move lib\src\fitness_app\my_diary\meals_list_view.dart lib\src\fitness_app\views\widgets\diary\
move lib\src\fitness_app\my_diary\water_view.dart lib\src\fitness_app\views\widgets\diary\

REM Remover pastas vazias
rmdir lib\src\fitness_app\bottom_navigation_view
rmdir lib\src\fitness_app\ui_view
rmdir lib\src\fitness_app\my_diary
rmdir lib\src\fitness_app\training

echo Estrutura MVC criada com sucesso!
echo Agora você precisa atualizar os imports nos arquivos.
pause