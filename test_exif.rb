require 'rubygems'
require 'exifr'
p EXIFR::JPEG.new('test1.JPG').date_time
