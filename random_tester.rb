#See http://realrand.rubyforge.org for information on the RealRand Gem.
#However, note that the 3 examples given are slightly incorrect.  The correct forms are below in the commented out
#bits at the end.
#Note that I've only incorporated one of the 3 remote random number generators; the other 2 return random bytes,
#not random numbers in a range.  Again, see the above web site.
#IMPORTANT:  before running this, you have to install th 'realrand' gem.
#On the command line, execute
#gem install realrand
#You should then be good to go.

require 'random/online'


class RandomTester
  attr_accessor :results
  def initialize()
    @results = Hash.new(0)
    #Note that this form of constant default value is just fine,
    #unlike the case described in the markov_generator.rb file
  end
  def basic_random()
    @results = Hash.new(0)
    10000.times do
      @results[rand(10)] += 1
    end
    (0..9).each {|rnum| puts @results[rnum]}
  end
  def better_random()
    #This approach is based on a suggestion from Knuth's Art of Computer Programming.
    #Here, it doesn't seem to help much, if at all, unlike my earlier experience in Smalltalk...
    #We build a table, populate it with random numbers of the desired range, then randomly access a result
    #and place a new random number in that location
    @results = Hash.new(0)
    table = Array.new(1000)
    count = 0
    1000.times do
      table[count]=rand(10)
      count += 1
    end
    10000.times do
      rnum=rand(1000)
      @results[table[rnum]] += 1
      table[rnum]=rand(10)
    end
    (0..9).each {|rnum| puts @results[rnum]}
  end
  def remote_random()
    @results = Hash.new(0)
    generator1 = RealRand::RandomOrg.new
    rnum_array= generator1.randnum(10000,0,9)
    rnum_array.each {|rnum|@results[rnum]+=1 }
    (0..9).each {|rnum| puts @results[rnum]}
  end
end

puts "From basic standard Ruby rand"
RandomTester.new.basic_random
puts 'Now from better random'
RandomTester.new.better_random
puts "From RandomOrg using randnum"
RandomTester.new.remote_random




#generator1 = Random::RandomOrg.new
#generator1 = RealRand::RandomOrg.new
#puts "From RandomOrg using first randbyte, then randnum"
#puts generator1.randbyte(5).join(",")
#puts generator1.randnum(100, 1, 6).join(",")  # Roll the dice 100 times.

#generator2 = Random::FourmiLab.new
#generator2 = RealRand::FourmiLab.new
#puts "From FourmiLab, using randbye, randnum not supported"
#puts generator2.randbyte(5).join(",")
# randnum is not supported.

#generator3 = Random::EntropyPool.new
#generator3 = RealRand::EntropyPool.new
#puts "from EntropyPool using randbyte, randnum not supported"
#puts generator3.randbyte(5).join(",")
# randnum is not supported.