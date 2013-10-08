# 迅雷离线自动下载器.

基于 `https://github.com/iambus/xunlei-lixian`。

#### 使用方法

1. 安装 [xunlei-lixian](https://github.com/iambus/xunlei-lixian) 并配置如下

  ```
ln -s /path_to_xunlei_lixian/lixian_cli.py /bin/lx
lx config username "your_username"
lx config password "your_password"
lx config no-hash
lx config output-dir "path_to_output_dir"
lx config tool aria2
lx config -- aria2-opts "-s10 -x10 -c" 
  ```

2. 设置 crontab

  ```
# 每小时检查离线空间并下载.
1 * * * * /bin/bash -l -c 'ruby /path_to_script_dir/download.rb' 
  ```

3. 修改要下载文件的名字

  ```
lx rename task_id "[d] origin_filename"
  ```
