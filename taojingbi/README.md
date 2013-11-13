# 淘金币自动领取脚本.

#### 使用方法

1. 下载依赖包

  ```
gem install mechanize
  ```

2. 配置 @username 和 @password

3. 配置 crontab 自动执行

  ```
# 每天早上 7 点自动领取淘金币.
0 7 * * * /bin/bash -l -c 'ruby /path_to_script_dir/main.rb' 
  ```
