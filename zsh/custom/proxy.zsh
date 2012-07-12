alias proxy='export http_proxy=http://192.168.1.248:3128;export HTTPS_PROXY=$http_proxy;export HTTP_PROXY=$http_proxy;export FTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export ftp_proxy=$http_proxy;'
alias noproxy='export http_proxy='';export HTTPS_PROXY=$http_proxy;export HTTP_PROXY=$http_proxy;export FTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export ftp_proxy=$http_proxy;'

# run only if I am at work
if [ `ifconfig | grep -P '(10.10.0.|192.168.2)' | wc -l` = 1 ]; then
    proxy
fi
