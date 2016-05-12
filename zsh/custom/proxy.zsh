alias proxy='export http_proxy=http://192.168.1.248:3128;export HTTPS_PROXY=$http_proxy;export HTTP_PROXY=$http_proxy;export FTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export ftp_proxy=$http_proxy;export NO_PROXY="local-delivery,local-auth";export no_proxy=$NO_PROXY'
alias noproxy='unset http_proxy;unset HTTPS_PROXY;unset HTTP_PROXY;unset FTP_PROXY;unset https_proxy;unset ftp_proxy'

# run only if I am at work
if [ `ifconfig | grep 10.10.0 | wc -l` = 1 ]; then
    proxy
fi
if [ `ifconfig | grep 192.168.2 | wc -l` = 1 ]; then
    proxy
fi
