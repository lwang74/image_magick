require 'rubygems'
require 'quick_magick'

        #~ i1 = QuickMagick::Image::gradient(300, 300, QuickMagick::RadialGradient, :yellow, :red)
        #~ i1.save 'gradient.png'

        #~ i = QuickMagick::Image::solid(100, 100, :white)
        #~ i.draw_line(0,0,50,50)
        #~ i.draw_text(30, 30, "Hello world!", :rotate=>45)
        #~ i.save 'hello.jpg'


# Create a 300x300 gradient image from yellow to red
        i1 = QuickMagick::Image::gradient(300, 300, QuickMagick::RadialGradient, :yellow, :red)
        i1.save 'gradient.png'

        # Now you can access single pixel values
        i1.get_pixel(10,10) # [255, 0, 0]
        i1.get_pixel(50,50) # [255, 15, 0]
