##客户端环境搭建

mac下配置vscode 
如果装了iTerm和插件oh-my-zsh 
vscode里装了flutter和dart插件
设置了.bash_profile里的flutter bin目录
在iTerm终端里测试flutter命令可用 echo $PATH里也有flutter sdk路径

但是在vscode里运行flutter命令 或者 new project会提示找不到sdk

这是因为iTerm里默认用的是zsh 而vscode装完flutter和dart插件配置里默认用的是bash
所以好不到环境 可以在vscode setting里搜索flutter sdk path 修改     "terminal.integrated.shell.osx": "/bin/bash", 为     "terminal.integrated.shell.osx": "/bin/zsh",

切换bash和zsh命令
chsh -s /bin/bash
chsh -s /bin/zsh

切换完需要 source ~/.bash_profile 重新加载下环境变量