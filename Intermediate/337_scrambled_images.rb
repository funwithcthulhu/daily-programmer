require 'rmagick'

def organize(array, key, size)
  until array[-size..-1] == key
    temp = array.shift(size)
    array.push(temp)
    array.flatten!
  end
  array
end

def unscramble(filename, savename)
  img = Magick::Image.read(filename)[0]
  rows, cols, p = img.rows, img.columns, img.rows * 3
  pixels = img.dispatch(0, 0, rows, cols, 'RGB').each_slice(p).to_a
  pixels.each { |row| organize(row, [65535, 0, 0], 3) }
  pixels.flatten!
  unscrambled = Magick::Image.constitute(400, 400, 'RGB', pixels)
  unscrambled.write(savename)
end
