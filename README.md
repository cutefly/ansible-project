# ansible-project
Ansible playbook repository

### AWX 시작하기
Reference URL : https://urban1980.tistory.com/48?category=681899

~~~
AWX 설치(by docker)
=> https://github.com/ansible/awx/blob/devel/INSTALL.md#docker-compose
Project 생성(git 연동)
Credential 생성
Inventory 생성(Host 생성 : IP, Host명)
Template 구성
~~~

> 프로비저닝 자동화를 위한 Ansible AWX : https://engineering.linecorp.com/ko/blog/ansible-awx-for-provisioning-1/

```
# 설치 시 postgres data 저장소나 docker-compose 저장소를 절대경로로 지정
~/.awx/dockercompose(x) => /home/chris/awx/dockercompose(o)
```

> Ansible로 ISMS 취약성 점검 shell script 실행 및 결과물 취합 : https://urban1980.tistory.com/52

### WSL 설정

```
# wsl에 ssh 서버 설치후 해야 할 일(외부 접속 허용)

# 로컬에서 WSL2로의 Port Foward 연결(관리자권한)
$my_wsl_address = 172.22.176.1
$port = 22

netsh interface portproxy add v4tov4 listenport=$port listenaddress='0.0.0.0' connectport=$port connectaddress=$my_wsl_address
```

## SSH

```
Powershell을 ssh 기본 쉘로 변경(https://jjam89.tistory.com/164)
$ $New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
```
