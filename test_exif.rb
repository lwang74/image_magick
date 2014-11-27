require 'rubygems'
require 'exifr'

pho = 'photo_in/30728_708729144375459.JPG'
pobj = EXIFR::JPEG.new(pho)
p pobj.date_time_original
p pobj.date_time
p pobj.date_time_digitized

p f = File.new(pho)
# p dto.strftime("%Y/%m/%d %H:%M")
# EXIFR::JPEG.new(pho).methods.each{|one|
# 	if /date/i=~one
# 		p one
# 	end
# }

# f.methods.each{|one|
# 	if /(date|time)/i=~one
# 		p one
# 	end
# }

p f.atime
p f.mtime
p f.ctime
