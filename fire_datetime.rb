require 'rubygems'
require 'quick_magick'
require 'exifr'

class Photo
	# @@week=%W(Mon Tue Wed Thu Fri Sat Sun)
	# @@mons=%W(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
	def initialize org_img_full_name
		@org_img_full_name=org_img_full_name
		@img_filename=@org_img_full_name
		if @org_img_full_name=~/([^\/]+)$/i
			@img_filename = $1
		end
		@exif=EXIFR::JPEG.new(@org_img_full_name)
		date_time=@exif.date_time_original #date_time
		if !date_time #如果没有原始时间，就用修改时间。
			date_time=@exif.date_time 
			puts "#{org_img_full_name} !!! used NOT original date time !!!" if date_time
		end
		if !date_time #如果exifr里没有记录时间，就只能用文件的时间了。
			f = File.new(@org_img_full_name)
			date_time = f.mtime
			puts "#{org_img_full_name} !!! used file time !!!"
		end

		@date_str = date_time.strftime("%y/%m/%d %H:%M")
		# puts @date_str
	end
	
	def save_img out_path
		#~ 1600x1200x40	
		rt =[3.4,11.43, 30]
		x=@exif.width*(1-1/rt[0])
		y=@exif.height*(1-1/rt[1])

		img = QuickMagick::Image.read(@org_img_full_name).first
		img.append_to_operators('pointsize', @exif.width/rt[2])
		img.draw_text(x, y, @date_str, {:font=>'Arial', :fill=>'rgb(249,174,0)'})
		img.save("#{out_path}/#{@img_filename}")
		#~ result = `convert #{filename} -font Arial -pointsize 40 -fill white -annotate +1130+1102 %[exif:DateTimeOriginal] output/#{filename}`
	end
end

#~ path="F:\\photo\\2012_01"
# path="F:\\photo\\DCIM\\100CANON"
# in_path='D:\lwang\image_magick\photo_in'
# out_path='D:\lwang\image_magick\photo_out'
in_path='F:\photo\201411'
out_path='F:\photo\201411_date'

Dir["#{in_path}\\*.jpg".gsub(/\\/, "\/")].each{|x|
	# p x
	p = Photo.new(x)
	p.save_img out_path
}







