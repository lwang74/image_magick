require 'rubygems'
require 'quick_magick'
require 'exifr'

class Photo
	@@week=%W(Mon Tue Wed Thu Fri Sat Sun)
	@@mons=%W(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
	def initialize org_img_full_name
		@org_img_full_name=org_img_full_name
		@img_filename=@org_img_full_name
		if @org_img_full_name=~/([^\/]+)$/i
			@img_filename = $1
		end
		@exif=EXIFR::JPEG.new(@org_img_full_name)
		p date_time=@exif.date_time

		year=''; mon=''; day=''; hour=''; min=''
		if /^(#{@@week.join('|')})\s+(#{@@mons.join('|')})\s+(\d+)\s+(\d+):(\d+):(\d+)\s+[\+\-]\d+\s+(\d+)$/i=~date_time.to_s
			mon=$2
			day=$3
			hour=$4
			min=$5
			year=$7
		end
		#~ p year, mon, day, hour, min

		@date_str="#{year}/#{@@mons.index(mon)+1}/#{day} #{hour.to_i}:#{min.to_i}"
		puts @date_str
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
in_path='F:\photo\201411'
out_path='F:\photo\201411_date'
Dir["#{in_path}\\*.jpg".gsub(/\\/, "\/")].each{|x|
	p x
	p = Photo.new(x)
	p.save_img out_path
}







