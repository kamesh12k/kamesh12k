@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: ============================================================
::  COLOUR HELPER  – prints coloured text via PowerShell
::  Usage:  call :cecho <color> "message"
::  Colors: Black,DarkBlue,DarkGreen,DarkCyan,DarkRed,
::          DarkMagenta,DarkYellow,Gray,DarkGray,Blue,
::          Green,Cyan,Red,Magenta,Yellow,White
:: ============================================================
goto :DETECT

:cecho
powershell -NoProfile -Command "Write-Host '%~2' -ForegroundColor %~1"
goto :eof

:cecho_nn
powershell -NoProfile -Command "Write-Host '%~2' -ForegroundColor %~1 -NoNewline"
goto :eof

:: ============================================================
::  AUTO-DETECT TurboC BIN folder
:: ============================================================
:DETECT
set "TCBIN="

call :cecho Cyan "  Scanning for TurboC installation..."

for %%D in (C D E F G) do (
    for %%F in (TC TurboC TurboC3 Turboc3 turboc tc turbo Turbo) do (
        if exist "%%D:\%%F\BIN\TC.EXE"   set "TCBIN=%%D:\%%F\BIN"
        if exist "%%D:\%%F\BIN\TCC.EXE"  set "TCBIN=%%D:\%%F\BIN"
        if exist "%%D:\%%F\bin\tc.exe"   set "TCBIN=%%D:\%%F\bin"
        if exist "%%D:\%%F\bin\tcc.exe"  set "TCBIN=%%D:\%%F\bin"
    )
)

if not defined TCBIN (
    for %%D in (C D E) do (
        for %%P in ("%%D:\Program Files" "%%D:\Program Files (x86)") do (
            for /d %%S in ("%%~P\Turbo*" "%%~P\TC*") do (
                if exist "%%S\BIN\TC.EXE"  set "TCBIN=%%S\BIN"
                if exist "%%S\BIN\TCC.EXE" set "TCBIN=%%S\BIN"
            )
        )
    )
)

if not defined TCBIN (
    for %%D in (C D E) do (
        for /d %%A in ("%%D:\*") do (
            for /d %%B in ("%%A\*") do (
                if exist "%%B\BIN\TC.EXE"  set "TCBIN=%%B\BIN"
                if exist "%%B\BIN\TCC.EXE" set "TCBIN=%%B\BIN"
            )
        )
    )
)

if not defined TCBIN (
    cls
    call :cecho Red   "  ╔══════════════════════════════════════════╗"
    call :cecho Red   "  ║   TurboC NOT FOUND on this computer!     ║"
    call :cecho Red   "  ╚══════════════════════════════════════════╝"
    echo.
    call :cecho Yellow "  Enter the full path to your TurboC BIN folder."
    call :cecho Gray   "  Example:  C:\TC\BIN   or   D:\TurboC3\BIN"
    echo.
    call :cecho_nn White "  Path: "
    set /p TCBIN=
)

if "%TCBIN:~-1%"=="\" set "TCBIN=%TCBIN:~0,-1%"

if not exist "%TCBIN%" (
    call :cecho Red "  [ERROR] Folder not found: %TCBIN%"
    pause
    exit /b
)


:MENU
cls
color 0B
powershell -NoProfile -Command ^
    "Write-Host '' ;"^
    "Write-Host '  ╔══════════════════════════════════════════════════════════╗' -ForegroundColor Cyan ;"^
    "Write-Host '  ║                                                          ║' -ForegroundColor Cyan ;"^
    "Write-Host '  ║        DSA C PROGRAM GENERATOR  ░  Turbo C              ║' -ForegroundColor Yellow ;"^
    "Write-Host '  ║                                                          ║' -ForegroundColor Cyan ;"^
    "Write-Host '  ╚══════════════════════════════════════════════════════════╝' -ForegroundColor Cyan"

call :cecho DarkGray "  ----------------------------------------------------------"
powershell -NoProfile -Command "Write-Host '  Save Path: ' -ForegroundColor Gray -NoNewline; Write-Host $env:TCBIN -ForegroundColor Green"
call :cecho DarkGray "  ----------------------------------------------------------"
echo.
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 1' -ForegroundColor Cyan -NoNewline; Write-Host ' ]  Singly Linked List  ' -ForegroundColor White -NoNewline; Write-Host '(Array Based)' -ForegroundColor DarkYellow"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 2' -ForegroundColor Cyan -NoNewline; Write-Host ' ]  Singly Linked List  ' -ForegroundColor White -NoNewline; Write-Host '(Pointer Based)' -ForegroundColor DarkYellow"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 3' -ForegroundColor Magenta -NoNewline; Write-Host ' ]  Stack Using Linked List' -ForegroundColor White"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 4' -ForegroundColor Magenta -NoNewline; Write-Host ' ]  Queue Using Linked List' -ForegroundColor White"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 5' -ForegroundColor Yellow -NoNewline; Write-Host ' ]  Infix to Postfix Conversion' -ForegroundColor White"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 6' -ForegroundColor Yellow -NoNewline; Write-Host ' ]  Priority Queue' -ForegroundColor White"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 7' -ForegroundColor Green -NoNewline; Write-Host ' ]  Linear Search' -ForegroundColor White"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 8' -ForegroundColor Green -NoNewline; Write-Host ' ]  Binary Search' -ForegroundColor White"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' 9' -ForegroundColor Red -NoNewline; Write-Host ' ]  Bubble Sort / Selection Sort' -ForegroundColor White"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host '10' -ForegroundColor Red -NoNewline; Write-Host ' ]  BST Insertion and Deletion' -ForegroundColor White"
echo.
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' A' -ForegroundColor Yellow -NoNewline; Write-Host ' ]  ' -ForegroundColor White -NoNewline; Write-Host 'Generate ALL Programs' -ForegroundColor Yellow"
powershell -NoProfile -Command "Write-Host '   [' -ForegroundColor DarkGray -NoNewline; Write-Host ' Q' -ForegroundColor DarkGray -NoNewline; Write-Host ' ]  Quit' -ForegroundColor DarkGray"
echo.
call :cecho_nn Cyan "  Enter your choice: "
set /p choice=

if /i "%choice%"=="1"  goto PROG1
if /i "%choice%"=="2"  goto PROG2
if /i "%choice%"=="3"  goto PROG3
if /i "%choice%"=="4"  goto PROG4
if /i "%choice%"=="5"  goto PROG5
if /i "%choice%"=="6"  goto PROG6
if /i "%choice%"=="7"  goto PROG7
if /i "%choice%"=="8"  goto PROG8
if /i "%choice%"=="9"  goto PROG9
if /i "%choice%"=="10" goto PROG10
if /i "%choice%"=="A"  goto ALL
if /i "%choice%"=="Q"  goto EXIT
call :cecho Red "  [!] Invalid choice. Please try again."
timeout /t 1 >nul
goto MENU


:ALL
cls
call :cecho Yellow "  Generating all 10 programs..."
echo.

call :WRITE1
call :WRITE2
call :WRITE3
call :WRITE4
call :WRITE5
call :WRITE6
call :WRITE7
call :WRITE8
call :WRITE9
call :WRITE10
echo.
call :cecho Green "  ╔═══════════════════════════════════════════╗"
call :cecho Green "  ║   ALL 10 programs saved successfully!    ║"
call :cecho Green "  ╚═══════════════════════════════════════════╝"
echo.
pause
goto MENU

:PROG1
call :WRITE1
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG2
call :WRITE2
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG3
call :WRITE3
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG4
call :WRITE4
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG5
call :WRITE5
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG6
call :WRITE6
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG7
call :WRITE7
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG8
call :WRITE8
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG9
call :WRITE9
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:PROG10
call :WRITE10
echo.
call :cecho Green "  [DONE] Open TurboC, File > Open, then Alt+F9 to compile!"
echo.
pause
goto MENU

:WRITE1
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram1.c...' -ForegroundColor White -NoNewline; Write-Host ' Singly Linked List (Array Based)' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo #define MAX 10
echo.
echo struct Node {
echo     int data;
echo     int next;
echo };
echo.
echo struct Node list[MAX];
echo int head = -1;
echo int freeIndex = 0;
echo.
echo void initialize^(^) {
echo     for ^(int i = 0; i ^< MAX - 1; i++^)
echo         list[i].next = i + 1;
echo.
echo     list[MAX - 1].next = -1;
echo     freeIndex = 0;
echo     head = -1;
echo }
echo.
echo void insertBeg^(int value^) {
echo     if ^(freeIndex == -1^) {
echo         printf^("List is full\n"^);
echo         return;
echo     }
echo.
echo     int newNode = freeIndex;
echo     freeIndex = list[freeIndex].next;
echo.
echo     list[newNode].data = value;
echo     list[newNode].next = head;
echo     head = newNode;
echo }
echo.
echo void display^(^) {
echo     if ^(head == -1^) {
echo         printf^("List is empty\n"^);
echo         return;
echo     }
echo.
echo     int temp = head;
echo     while ^(temp ^!= -1^) {
echo         printf^("%%d -^> ", list[temp].data^);
echo         temp = list[temp].next;
echo     }
echo     printf^("NULL\n"^);
echo }
echo.
echo int main^(^) {
echo     int ch, val;
echo     initialize^(^);
echo.
echo     do {
echo         printf^("\n1.Insert  2.Display  3.Exit\n"^);
echo         printf^("Enter choice: "^);
echo         scanf^("%%d", ^&ch^);
echo.
echo         switch ^(ch^) {
echo         case 1:
echo             printf^("Enter value: "^);
echo             scanf^("%%d", ^&val^);
echo             insertBeg^(val^);
echo             break;
echo.
echo         case 2:
echo             display^(^);
echo             break;
echo.
echo         case 3:
echo             printf^("Exiting...\n"^);
echo             break;
echo.
echo         default:
echo             printf^("Invalid choice\n"^);
echo         }
echo     } while ^(ch ^!= 3^);
echo.
echo     return 0;
echo }
) > "%TCBIN%\gkprogram1.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram1.c') -ForegroundColor Cyan"
goto :eof

:WRITE2
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram2.c...' -ForegroundColor White -NoNewline; Write-Host ' Singly Linked List (Pointer Based)' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo #include ^<stdlib.h^>
echo struct Node {
echo  int data;
echo  struct Node *next;
echo };
echo struct Node *head = NULL;
echo void insertBeg^(int value^) {
echo  struct Node *newNode;
echo  newNode = ^(struct Node *^)malloc^(sizeof^(struct Node^)^);
echo  newNode-^>data = value;
echo  newNode-^>next = head;
echo  head = newNode;
echo }
echo void display^(^) {
echo  struct Node *temp = head;
echo  while ^(temp ^!= NULL^) {
echo  printf^("%%d -^> ", temp-^>data^);
echo  temp = temp-^>next;
echo  }
echo  printf^("NULL\n"^);
echo }
echo int main^(^) {
echo  int ch, val;
echo  do {
echo  printf^("\n1.Insert 2.Display 3.Exit\n"^);
echo  scanf^("%%d", ^&ch^);
echo  switch ^(ch^) {
echo  case 1:
echo  printf^("Enter value: "^);
echo  scanf^("%%d", ^&val^);
echo  insertBeg^(val^);
echo  break;
echo  case 2:
echo  display^(^);
echo  break;
echo  }
echo  } while ^(ch ^!= 3^);
echo  return 0;
echo }
) > "%TCBIN%\gkprogram2.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram2.c') -ForegroundColor Cyan"
goto :eof

:WRITE3
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram3.c...' -ForegroundColor White -NoNewline; Write-Host ' Stack Using Linked List' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo #include ^<stdlib.h^>
echo struct Node {
echo  int data;
echo  struct Node *next;
echo };
echo int main^(^) {
echo  struct Node *top = NULL, *newNode, *temp;
echo  int ch, val;
echo  while ^(1^) {
echo  printf^("\n1.Push 2.Pop 3.Exit\n"^);
echo  scanf^("%%d", ^&ch^);
echo  if ^(ch == 1^) {
echo  newNode = ^(struct Node *^)malloc^(sizeof^(struct Node^)^);
echo  printf^("Enter value: "^);
echo  scanf^("%%d", ^&val^);
echo  newNode-^>data = val;
echo  newNode-^>next = top;
echo  top = newNode;
echo  }
echo  else if ^(ch == 2^) {
echo  if ^(top == NULL^) {
echo  printf^("Stack is empty\n"^);
echo  } else {
echo  temp = top;
echo  printf^("Popped %%d\n", temp-^>data^);
echo  top = top-^>next;
echo  free^(temp^);
echo  }
echo  }
echo  else {
echo  break;
echo  }
echo  } return 0; }
) > "%TCBIN%\gkprogram3.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram3.c') -ForegroundColor Cyan"
goto :eof

:WRITE4
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram4.c...' -ForegroundColor White -NoNewline; Write-Host ' Queue Using Linked List' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo #include ^<stdlib.h^>
echo struct Node {
echo  int data;
echo  struct Node *next;
echo };
echo int main^(^) {
echo  struct Node *front = NULL, *rear = NULL, *newNode, *temp;
echo  int ch, val;
echo  while ^(1^) {
echo  printf^("\n1.Enqueue 2.Dequeue 3.Exit\n"^);
echo  scanf^("%%d", ^&ch^);
echo  if ^(ch == 1^) {
echo  newNode = ^(struct Node *^)malloc^(sizeof^(struct Node^)^);
echo  printf^("Enter value: "^);
echo  scanf^("%%d", ^&val^);
echo  newNode-^>data = val;
echo  newNode-^>next = NULL;
echo  if ^(rear == NULL^) {
echo  front = rear = newNode;
echo  } else {
echo  rear-^>next = newNode;
echo  rear = newNode;
echo  }
echo  }
echo  else if ^(ch == 2^) {
echo  if ^(front == NULL^) {
echo  printf^("Queue is empty\n"^);
echo  } else {
echo  temp = front;
echo  printf^("Dequeued %%d\n", temp-^>data^);
echo  front = front-^>next;
echo  free^(temp^);
echo  if ^(front == NULL^)
echo  rear = NULL;
echo  }
echo  }
echo  else {
echo  break;
echo  }
echo  }
echo  return 0;
echo }
) > "%TCBIN%\gkprogram4.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram4.c') -ForegroundColor Cyan"
goto :eof

:WRITE5
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram5.c...' -ForegroundColor White -NoNewline; Write-Host ' Infix to Postfix Conversion' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo #include ^<ctype.h^>
echo char stack[50];
echo int top = -1;
echo /* Push */
echo void push^(char x^) {
echo  stack[++top] = x;
echo }
echo /* Pop */
echo char pop^(^) {
echo  return stack[top--];
echo }
echo /* Priority */
echo int priority^(char x^) {
echo  if ^(x == '+' ^|^| x == '-'^)
echo  return 1;
echo  if ^(x == '*' ^|^| x == '/'^)
echo  return 2;
echo  return 0;
echo }
echo int main^(^) {
echo  char infix[50], postfix[50];
echo  int i = 0, j = 0;
echo  char x;
echo  printf^("Enter infix expression: "^);
echo  scanf^("%%s", infix^);
echo  while ^(infix[i] ^!= '\0'^) {
echo  if ^(isalnum^(infix[i]^)^) {
echo  postfix[j++] = infix[i];
echo  }
echo  else if ^(infix[i] == '^('^) {
echo  push^(infix[i]^);
echo  }
echo  else if ^(infix[i] == '^)'^) {
echo  while ^(^(x = pop^(^)^) ^!= '^('^) {
echo  postfix[j++] = x;
echo  }
echo  }
echo  else {
echo  while ^(top ^!= -1 ^&^& priority^(stack[top]^) ^>= priority^(infix[i]^)^) {
echo  postfix[j++] = pop^(^);
echo  }
echo  push^(infix[i]^);
echo  }
echo  i++;
echo  }
echo  while ^(top ^!= -1^) {
echo  postfix[j++] = pop^(^);
echo  }
echo  postfix[j] = '\0';
echo  printf^("Postfix expression: %%s\n", postfix^);
echo  return 0;
echo }
) > "%TCBIN%\gkprogram5.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram5.c') -ForegroundColor Cyan"
goto :eof

:WRITE6
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram6.c...' -ForegroundColor White -NoNewline; Write-Host ' Priority Queue' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo struct PriorityQueue {
echo  int data;
echo  int priority;
echo };
echo struct PriorityQueue pq[10];
echo int size = 0;
echo /* Insert element */
echo void insert^(int data, int priority^) {
echo  pq[size].data = data;
echo  pq[size].priority = priority;
echo  size++;
echo }
echo /* Delete highest priority element */
echo void delete^(^) {
echo  if ^(size == 0^) {
echo  printf^("Queue is empty\n"^);
echo  return;
echo  }
echo  int i, pos = 0;
echo  for ^(i = 1; i ^< size; i++^) {
echo  if ^(pq[i].priority ^< pq[pos].priority^) {
echo  pos = i;
echo  }
echo  }
echo  printf^("Deleted: %%d\n", pq[pos].data^);
echo  for ^(i = pos; i ^< size - 1; i++^) {
echo  pq[i] = pq[i + 1];
echo  }
echo  size--;
echo }
echo /* Display queue */
echo void display^(^) {
echo  if ^(size == 0^) {
echo  printf^("Queue is empty\n"^);
echo  return;
echo  }
echo  for ^(int i = 0; i ^< size; i++^) {
echo  printf^("^(%%d , %%d^) ", pq[i].data, pq[i].priority^);
echo  }
echo  printf^("\n"^);
echo }
echo int main^(^) {
echo  int ch, data, pr;
echo  while ^(1^) {
echo  printf^("\n1.Insert 2.Delete 3.Display 4.Exit\n"^);
echo  scanf^("%%d", ^&ch^);
echo  if ^(ch == 1^) {
echo  printf^("Enter data and priority: "^);
echo  scanf^("%%d %%d", ^&data, ^&pr^);
echo  insert^(data, pr^);
echo  }
echo  else if ^(ch == 2^) {
echo  delete^(^);
echo  }
echo  else if ^(ch == 3^) {
echo  display^(^);
echo  }
echo  else {
echo  break;
echo  }
echo  }
echo  return 0;
echo }
) > "%TCBIN%\gkprogram6.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram6.c') -ForegroundColor Cyan"
goto :eof

:WRITE7
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram7.c...' -ForegroundColor White -NoNewline; Write-Host ' Linear Search' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo int main^(^) {
echo  int a[10], n, key, i, found = 0;
echo  printf^("Enter number of elements: "^);
echo  scanf^("%%d", ^&n^);
echo  printf^("Enter elements:\n"^);
echo  for ^(i = 0; i ^< n; i++^)
echo  scanf^("%%d", ^&a[i]^);
echo  printf^("Enter element to search: "^);
echo  scanf^("%%d", ^&key^);
echo  for ^(i = 0; i ^< n; i++^) {
echo  if ^(a[i] == key^) {
echo  printf^("Element found at position %%d\n", i + 1^);
echo  found = 1;
echo  break;
echo  }
echo  }
echo  if ^(^!found^)
echo  printf^("Element not found\n"^);
echo  return 0;
echo }
) > "%TCBIN%\gkprogram7.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram7.c') -ForegroundColor Cyan"
goto :eof

:WRITE8
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram8.c...' -ForegroundColor White -NoNewline; Write-Host ' Binary Search' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo int main^(^) {
echo     int a[10], n, key;
echo     int low = 0, high, mid;
echo     printf^("Enter number of elements: "^);
echo     scanf^("%%d", ^&n^);
echo     printf^("Enter sorted elements:\n"^);
echo     for ^(int i = 0; i ^< n; i++^)
echo         scanf^("%%d", ^&a[i]^);
echo     printf^("Enter element to search: "^);
echo     scanf^("%%d", ^&key^);
echo     high = n - 1;
echo     while ^(low ^<= high^) {
echo         mid = ^(low + high^) / 2;
echo         if ^(a[mid] == key^) {
echo             printf^("Element found at position %%d\n", mid + 1^);
echo             return 0;
echo         }
echo         else if ^(a[mid] ^< key^) {
echo             low = mid + 1;
echo         }
echo         else {
echo             high = mid - 1;
echo         }
echo     }
echo     printf^("Element not found\n"^);
echo     return 0;
echo }
) > "%TCBIN%\gkprogram8.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram8.c') -ForegroundColor Cyan"
goto :eof

:WRITE9
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram9.c...' -ForegroundColor White -NoNewline; Write-Host ' Bubble Sort / Selection Sort' -ForegroundColor DarkYellow"
(
echo /* BUBBLE SORT */
echo #include ^<stdio.h^>
echo int main^(^) {
echo     int a[10], n, i, j, temp;
echo     printf^("Enter number of elements: "^);
echo     scanf^("%%d", ^&n^);
echo     printf^("Enter elements:\n"^);
echo     for ^(i = 0; i ^< n; i++^)
echo         scanf^("%%d", ^&a[i]^);
echo     for ^(i = 0; i ^< n - 1; i++^) {
echo         for ^(j = 0; j ^< n - 1 - i; j++^) {
echo             if ^(a[j] ^> a[j + 1]^) {
echo                 temp = a[j];
echo                 a[j] = a[j + 1];
echo                 a[j + 1] = temp;
echo             }
echo         }
echo     }
echo     printf^("Sorted array:\n"^);
echo     for ^(i = 0; i ^< n; i++^)
echo         printf^("%%d ", a[i]^);
echo     return 0;
echo }
echo.
echo /* SELECTION SORT */
echo /*
echo #include ^<stdio.h^>
echo int main^(^) {
echo     int a[10], n, i, j, min, temp;
echo     printf^("Enter number of elements: "^);
echo     scanf^("%%d", ^&n^);
echo     printf^("Enter elements:\n"^);
echo     for ^(i = 0; i ^< n; i++^)
echo         scanf^("%%d", ^&a[i]^);
echo     for ^(i = 0; i ^< n - 1; i++^) {
echo         min = i;
echo         for ^(j = i + 1; j ^< n; j++^) {
echo             if ^(a[j] ^< a[min]^)
echo                 min = j;
echo         }
echo         temp = a[i];
echo         a[i] = a[min];
echo         a[min] = temp;
echo     }
echo     printf^("Sorted array:\n"^);
echo     for ^(i = 0; i ^< n; i++^)
echo         printf^("%%d ", a[i]^);
echo     return 0;
echo }
echo */
) > "%TCBIN%\gkprogram9.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram9.c') -ForegroundColor Cyan"
goto :eof

:WRITE10
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host '+' -ForegroundColor Cyan -NoNewline; Write-Host '] Writing gkprogram10.c...' -ForegroundColor White -NoNewline; Write-Host ' BST Insertion and Deletion' -ForegroundColor DarkYellow"
(
echo #include ^<stdio.h^>
echo #include ^<stdlib.h^>
echo struct Node {
echo     int data;
echo     struct Node *left, *right;
echo };
echo /* Create new node */
echo struct Node* createNode^(int value^) {
echo     struct Node *newNode = ^(struct Node*^)malloc^(sizeof^(struct Node^)^);
echo     newNode-^>data = value;
echo     newNode-^>left = newNode-^>right = NULL;
echo     return newNode;
echo }
echo /* Insert into BST */
echo struct Node* insert^(struct Node* root, int value^) {
echo     if ^(root == NULL^)
echo         return createNode^(value^);
echo     if ^(value ^< root-^>data^)
echo         root-^>left = insert^(root-^>left, value^);
echo     else if ^(value ^> root-^>data^)
echo         root-^>right = insert^(root-^>right, value^);
echo     return root;
echo }
echo /* Find minimum value node */
echo struct Node* minValueNode^(struct Node* node^) {
echo     struct Node* current = node;
echo     while ^(current ^&^& current-^>left ^!= NULL^)
echo         current = current-^>left;
echo     return current;
echo }
echo /* Delete from BST */
echo struct Node* deleteNode^(struct Node* root, int value^) {
echo     if ^(root == NULL^)
echo         return root;
echo     if ^(value ^< root-^>data^)
echo         root-^>left = deleteNode^(root-^>left, value^);
echo     else if ^(value ^> root-^>data^)
echo         root-^>right = deleteNode^(root-^>right, value^);
echo     else {
echo         /* Node with one or no child */
echo         if ^(root-^>left == NULL^) {
echo             struct Node* temp = root-^>right;
echo             free^(root^);
echo             return temp;
echo         }
echo         else if ^(root-^>right == NULL^) {
echo             struct Node* temp = root-^>left;
echo             free^(root^);
echo             return temp;
echo         }
echo         /* Node with two children */
echo         struct Node* temp = minValueNode^(root-^>right^);
echo         root-^>data = temp-^>data;
echo         root-^>right = deleteNode^(root-^>right, temp-^>data^);
echo     }
echo     return root;
echo }
echo /* Inorder traversal */
echo void inorder^(struct Node* root^) {
echo     if ^(root ^!= NULL^) {
echo         inorder^(root-^>left^);
echo         printf^("%%d ", root-^>data^);
echo         inorder^(root-^>right^);
echo     }
echo }
echo int main^(^) {
echo     struct Node* root = NULL;
echo     int ch, val;
echo     while ^(1^) {
echo         printf^("\n1.Insert 2.Delete 3.Display^(Inorder^) 4.Exit\n"^);
echo         scanf^("%%d", ^&ch^);
echo         if ^(ch == 1^) {
echo             printf^("Enter value: "^);
echo             scanf^("%%d", ^&val^);
echo             root = insert^(root, val^);
echo         }
echo         else if ^(ch == 2^) {
echo             printf^("Enter value to delete: "^);
echo             scanf^("%%d", ^&val^);
echo             root = deleteNode^(root, val^);
echo         }
echo         else if ^(ch == 3^) {
echo             inorder^(root^);
echo             printf^("\n"^);
echo         }
echo         else {
echo             break;
echo         }
echo     }
echo     return 0;
echo }
) > "%TCBIN%\gkprogram10.c"
powershell -NoProfile -Command "Write-Host '  [' -ForegroundColor DarkGray -NoNewline; Write-Host 'OK' -ForegroundColor Green -NoNewline; Write-Host '] Saved: ' -ForegroundColor Gray -NoNewline; Write-Host ($env:TCBIN + '\gkprogram10.c') -ForegroundColor Cyan"
goto :eof

:EXIT
cls
echo.
call :cecho Cyan   "  ╔═══════════════════════════════════════╗"
call :cecho Cyan   "  ║                                       ║"
call :cecho Yellow "  ║     Goodbye! Happy Coding in C  :)    ║"
call :cecho Cyan   "  ║                                       ║"
call :cecho Cyan   "  ╚═══════════════════════════════════════╝"
echo.
pause
exit