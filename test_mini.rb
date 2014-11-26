require 'rubygems'
require 'mini_magick'

filename='test1.jpg'
 # Read the image
 img = MiniMagick::Image.from_file(filename)
 
 # 0,0 0,0 = add the watermark at coordinates: x, y, set watermark size to auto with 0,0
 img.draw 'image Over 0,0 0,0 "lwang"'
 
 img.write("output/#{filename}")
