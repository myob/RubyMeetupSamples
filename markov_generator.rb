

class MarkovGenerator
  attr_accessor :dict; :in_text; :pattern_length; :out_text; :end_point
end
public
def post_initialize
  @dict=Hash.new{ |hash, key| hash[key] = Array.new }
  @out_text=''
  @pattern_length= 3
  #@pattern_length= 4
  prep_text
  build_dictionary
  build_output
end

def prep_text()
  #@in_text=File.open('GaryTheoryJuly.txt') {|file| file.gets}
  @in_text=File.open('GaryText1.txt') {|file| file.gets}
  @in_text=@in_text.gsub(%r{\s+}, ' ')
  @end_point=@in_text.size #- 1
  @in_text=@in_text<<@in_text[0,(@pattern_length + 1)]
end

def build_dictionary()
  (0...@end_point).each do |pos|
    @dict[@in_text[pos, @pattern_length].intern]<< @in_text[(pos + @pattern_length)] #+ 1)]
  end
end

def build_output()
  start_point = rand(@end_point)
  @out_text<<@in_text[start_point,@pattern_length + 1]
  char_list=@dict[@out_text.intern]
  selected_char=char_list[rand(char_list.size) - 1]
  (1...5000).each do |pos|
    new_pattern=@out_text[pos,@pattern_length]
    char_list=@dict[new_pattern.intern]
    selected_char=char_list[rand(char_list.size-1)]
    @out_text<<selected_char
  end
  puts @out_text
end

testish = MarkovGenerator.new
testish.post_initialize
