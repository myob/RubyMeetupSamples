

class MarkovGenerator
  attr_accessor :dict; :in_text; :pattern_length; :out_text; :end_point
end
public
def post_initialize
  @dict=Hash.new{ |hash, key| hash[key] = Array.new }
  @out_text=''
  @pattern_length= 3
  #puts 'in post_initialize'
  prep_text
  build_dictionary
  build_output
end

def prep_text()
  #@in_text=File.open('GaryTheoryJuly.txt').gets
  @in_text=File.open('GaryText1.txt').gets
  #@in_text= 'Now is the time'
  @in_text=@in_text.gsub(%r{\s+}, ' ')
  #puts 'in prep_text'
  #puts @in_text
  @end_point=@in_text.size #- 1
  #puts @end_point
  #puts 'pattern length -'
  #puts @pattern_length
  @in_text=@in_text<<@in_text[0,(@pattern_length + 1)]
  #puts 'finished prepping text with result >> '+@in_text
end

def build_dictionary()
  (0...@end_point).each do |pos|
    @dict[@in_text[pos, @pattern_length].intern]<< @in_text[(pos + @pattern_length)] #+ 1)]
  end
 # @dict.keys.each do |a_key|
  #  p a_key + '>>' + (@dict[a_key]).join(' ')
  #end
end

def build_output()
  start_point = rand(@end_point)
  @out_text<<@in_text[start_point,@pattern_length + 1]
  char_list=@dict[@out_text.intern]
  selected_char=char_list[rand(char_list.size) - 1]
  #p @out_text + ' >> this is the initial output text with ' + @out_text.size.to_s + ' characters'
  (1...5000).each do |pos|
    new_pattern=@out_text[pos,@pattern_length]
   # puts 'this is the next pattern ' + new_pattern + ' and it has ' + new_pattern.size.to_s + ' characters'
    #puts 'Problem!!' unless @dict.has_key?(new_pattern)
    char_list=@dict[new_pattern.intern]
    selected_char=char_list[rand(char_list.size-1)]
    #puts 'selected character is ' + selected_char
    @out_text<<selected_char
  end
  puts @out_text
end

testish = MarkovGenerator.new
testish.post_initialize
testish.dict.inspect