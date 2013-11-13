# encode: utf-8

# 文件名包含此 tag 的会被下载.
DOWNLOAD_TAG = "[d]"

##
# 获取文件保存路径.

def get_output_dir
  File.open("#{ENV["HOME"]}/.xunlei.lixian.config", "r").each_line do |line|
    next if line.index("--output-dir") == nil
    return line.gsub("--output-dir=", "").gsub("\n", "")
  end
end

##
# 下载文件.

def download(item)
  return if item.index(DOWNLOAD_TAG) == nil

  item = item.split(" ")
  task_id = item[0]
  task_name = "#{item[1]} #{item[2]}"

  # download.
  p "  download #{task_id}: #{task_name}"
  `lx download #{task_id} --output "#{get_output_dir}#{task_name.gsub("#{DOWNLOAD_TAG} ", "")}"`

  # rename.
  p "  rename #{task_id}: #{task_name}"
  new_task_name = task_name.gsub(DOWNLOAD_TAG, "[downloaded]")
  `lx rename #{task_id} "#{new_task_name}"`
end

##
# 获取列表并下载.

list = `lx list --completed`
list = list.encode("utf-8", "utf-8")
list.split("\n").each do |item|
  p item
  download item
end

