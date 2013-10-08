
files = `find ./ -name "*.vm"`
files.split("\n").each do |file|
  file = file.gsub ".//", "./"
  encoding = `enca #{file}`.split("\n")[0]
  if encoding.index("UTF-8") != nil
    p "#{file}: #{encoding}"
  end
end

files = `find ./ -name "*.css"`
files.split("\n").each do |file|
  file = file.gsub ".//", "./"
  encoding = `enca #{file}`.split("\n")[0]
  if encoding.index("GB2312") != nil
    p "#{file}: #{encoding}"
  end
end

files = `find ./ -name "*.js"`
files.split("\n").each do |file|
  file = file.gsub ".//", "./"
  encoding = `enca #{file}`.split("\n")[0]
  if encoding.index("GB2312") != nil
    p "#{file}: #{encoding}"
  end
end


