ppa(){
  # 安装用于管理 PPA 的工具
  sudo apt install -y software-properties-common

  # 添加 deadsnakes PPA
  sudo add-apt-repository ppa:deadsnakes/ppa

  # 更新软件包列表（添加 PPA 后必须执行）
  sudo apt update
}
pyins(){
  # 检查参数是否提供
  if [ -z "$1" ]; then
    echo "用法: pyins <版本号>"
    return 1
  fi

  ver=$1
  target_dir="/mnt/d/py$ver"
  
  # 创建目标目录
  mkdir -p "$target_dir"
  
  # 清理旧的deb文件
  rm -rf ./*.deb
  
  # 下载指定版本的Python包
  echo "正在下载Python  包..."
  apt download "libpython$ver-minimal"  "libpython$ver-stdlib" "python$ver-minimal" "python$ver" "python3.11-tk"
  
  # 检查下载是否成功
  if [ $? -ne 0 ]; then
    echo "下载失败"
    return 1
  fi
  
  # 解压所有包到目标目录
  echo "正在解压包..."
  for pkg in *.deb; do
    if [ -f "$pkg" ]; then
      dpkg -x "$pkg" "$target_dir"
    fi
  done
  
  # 验证核心文件
  if [ -f "$target_dir/usr/bin/python$ver" ]; then
    echo "Python $ver 安装成功!"
    ls "$target_dir/usr/bin/python$ver"  # 显示可执行文件
    echo "标准库结构:"
    tree -L 3 "$target_dir/usr/lib/python$ver"  # 显示标准库结构
  else
    echo "安装失败: 未找到Python可执行文件"
    return 1
  fi
  curl https://bootstrap.pypa.io/get-pip.py | /mnt/d/py$ver/usr/bin/python$ver
  if [ $ver <3.9 ]; then
    curl https://bootstrap.pypa.io/pip/$ver/get-pip.py | /mnt/d/py$ver/usr/bin/python$ver
  fi
  rm -rf ./*.deb
}
py(){
  ver=$1
  shift
  /mnt/d/py$ver/usr/bin/python$ver "$@"
}
pipex(){
  ver=$1
  shift
  /mnt/d/py$ver/usr/bin/python$ver -m pip "$@"
}
crenv(){
  ver=$1
  pipex $ver install virtualenv
  shift
  /mnt/d/py$ver/usr/bin/python$ver -m virtualenv "$@"
}
env(){
  name=$1
  source ./$name/bin/activate
}
install(){
  python -m pip install -r requirements.txt
}
uninstall(){
  python -m pip uninstall -r requirements.txt
}
pip-cl-env(){
  python -m pip cache purge
  pip freeze | xargs pip uninstall -y
}
pip-cl(){
  ver=$1
  py $ver -m pip cache purge
}
