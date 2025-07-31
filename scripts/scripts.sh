alias src="source ~/.bashrc;"
source /mnt/e/ubt/scripts/py.sh
alias a="cd /mnt/a"
alias c="cd /mnt/c"
alias d="cd /mnt/d"
alias e="cd /mnt/e"
alias f="cd /mnt/f"
alias scr="cd /mnt/e/ubt/scripts"
alias hm="cd ~"
alias ubt="cd /mnt/e/ubt"
alias tmp="sudo rm -rf /tmp/*;
sudo ln -s /mnt/e/ubt/tmp /tmp"
export PATH="/mnt/e/ubt/scripts:$PATH"
alias py="python3"
alias cls="clear"

pxy() {
    if [ -z "$1" ]; then
        # 无参数，清除代理
        unset http_proxy https_proxy ftp_proxy all_proxy
        echo "Proxy cleared."
    else
        # 有参数，设置代理到 127.0.0.1:$1
        export http_proxy="http://127.0.0.1:$1"
        export https_proxy="http://127.0.0.1:$1"
        echo "'$http_proxy $http_proxy'"
    fi
}
