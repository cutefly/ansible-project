@echo off
pushd %~dp0
:: 명령 프롬프트 위치를 배치파일이 있는 디렉토리로 설정

TITLE KPC WINDOWS SYSTEM / SECURITY CHECK

::영문으로 변경
chcp 437

cls

echo ========= KPC Windows System / Security Check is Start =========
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 1/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  시스템 설치일                                                                                             >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
systeminfo | find "Install Date"                                                                                >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 2/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  시스템 부트일                                                                                             >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
net stats work | find "since"                                                                                   >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  시스템 가동일                                                                                             >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  ※ 엑셀 자동계산                                                                                          >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 3/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  날짜/시간                                                                                                 >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  ■ 시간 설정 정보                                                                                          >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
w32tm /dumpreg /subkey:Parameters                                                                               >>%COMPUTERNAME%_%DATE%.txt
echo -------------------------------------------------------                                                    >>%COMPUTERNAME%_%DATE%.txt
echo  ■ NTP 서버와 시간차                                                                                       >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
echo  1) 192.168.1.100 서버                                                                                     >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
w32tm /stripchart /dataonly /computer:192.168.1.100 /samples:5                                                  >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
echo  2) time.windows.com 서버                                                                                  >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
w32tm /stripchart /dataonly /computer:time.windows.com /samples:5                                               >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 4/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  CPU, 메모리 사용률 확인                                                                                   >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt 
echo  ■ Physical 메모리 정보                                                                                    >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
systeminfo | findstr "Memory" | find "Physical"                                                                 >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
echo  ※ 20초 동안 CPU 사용률, 사용 가능한 메모리 점검은 script 폴더에 생성된 %COMPUTERNAME%_%DATE%[CPU_MEM_Result].csv 파일 참고           >>%COMPUTERNAME%_%DATE%.txt
typeperf "\Processor(_Total)\%% Processor time" "\Memory\Available MBytes" -sc 21 -o %COMPUTERNAME%_%DATE%[CPU_MEM_Result].csv
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 5/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  디스크 사용률 확인                                                                                        >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt 
powershell "Get-WmiObject Win32_LogicalDisk"                                                                    >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 6/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  Array 상태 확인                                                                                           >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt 
echo  ※ HP Smart Storage의 Logical/Physical Drive 상태 수동 점검                                               >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 7/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  기본 계정 활성 여부 확인(Administrator, Guest 계정)                                                       >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  1) Administrator 계정                                                                                     >>%COMPUTERNAME%_%DATE%.txt
net user administrator | find "active"                                                                          >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt
echo  2) Guest 계정                                                                                             >>%COMPUTERNAME%_%DATE%.txt
net user guest | find "active"                                                                                  >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 8/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  불필요한 계정 존재 여부 확인                                                                              >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt 
FOR /F "tokens=1 skip=4" %%j IN ('net user') DO net user %%j                                                    >>%COMPUTERNAME%_%DATE%.txt
FOR /F "tokens=2 skip=4" %%j IN ('net user') DO net user %%j                                                    >>%COMPUTERNAME%_%DATE%.txt
FOR /F "tokens=3 skip=4" %%j IN ('net user') DO net user %%j                                                    >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 9/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  계정 잠금 임계값 확인                                                                                     >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
net accounts | find "Lockout threshold"                                                                         >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 10/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  관리자 그룹 계정 확인                                                                                     >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
net localgroup administrators                                                                                   >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 11/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  관리자 계정 암호 변경일 확인                                                                              >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
net user kpcadmin | find "last set"                                                                             >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 12/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  OS 방화벽 사용 여부 확인                                                                                  >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
netsh advfirewall show currentprofile                                                                           >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt

echo [ Checking 13/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  기본 공유 설정 여부 확인                                                                                  >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  1) 하드디스크 기본 공유 확인                                                                              >>%COMPUTERNAME%_%DATE%.txt
net share | FIND /V "IPC$" | FIND /V "command PRINT$ FAX$" | FIND "$" | findstr /I "^[A-Z]"                     >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 
echo  2) 레지스트리 설정 확인                                                                                   >>%COMPUTERNAME%_%DATE%.txt
reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer"                      >>%COMPUTERNAME%_%DATE%.txt
reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareWks"                         >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 

echo [ Checking 14/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  실행중인 서비스 확인                                                                                      >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
net start | find /v "started" | find /v "completed"                                                             >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 

echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  윈도우 업데이트 날짜                                                                                      >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  ※ 최근 윈도우 업데이트 성공 일자 수동 점검                                                               >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 

echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  백신 업데이트 날짜                                                                                        >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  ※ 최근 백신 업데이트 성공 일자 수동 점검                                                                 >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 

echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  백업 유무                                                                                                 >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  ※ 백업 유무 수동 점검                                                                                    >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 

echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  이벤트 로그                                                                                               >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  ※ 이벤트 로그 수동 점검                                                                                 >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 

echo [ Checking 15/15 ]
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
echo  점검일자                                                                                                  >>%COMPUTERNAME%_%DATE%.txt
echo ========================================================================================================== >>%COMPUTERNAME%_%DATE%.txt
date /t                                                                                                         >>%COMPUTERNAME%_%DATE%.txt
echo.>>%COMPUTERNAME%_%DATE%.txt 

cls
echo ========= KPC Windows System / Security Check is End =========
pause