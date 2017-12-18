require 'ruby-fann'

#
# 1. split headline into words
# 2. strip punctuation
# 3. remove stop words
# 4. stem words
# 5. convert words into unique word IDs
# 6. create sparse vector of word IDs
# 7. create neural network with 100,000 neurons
# 8. train with vectors of word IDs

class LearnHeadlines < RubyFann::Standard
  def self.test
    lh = LearnHeadlines.new 

    lh.headlines

    lh.write_training_file

    lh.train
  end

  def initialize
    @max_word_id = 0
    @number_of_inputs = ENV['SU_NEON_NN_INPUTS'].to_i || 25000
    puts "#{@number_of_inputs} inputs"
    @number_of_outputs = Sign.count
    @keywords = Keyword.all
  end

  # with stemming we'll probably never need more than 20,000 words in our vocabulary
  # training input is a vector of 20,000 with a 1 for each word that appears
  # we have 12 outputs, one for each sign - 1 means the sign is on, 0 off
  def train
    puts '>>> 1'
    train = RubyFann::TrainData.new(filename: './train.data')

    puts '>>> 2'
    @fann = RubyFann::Standard.new(num_inputs: @number_of_inputs, hidden_neurons: [@number_of_inputs/20, @number_of_inputs/40], num_outputs: @number_of_outputs)

    puts '>>> 3'
    @fann.train_on_data(train, 1000, 10, 0.1) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)
    @fann.save('./headlines.net')

    puts '>>> 4'
    test
  end

  def load
    @fann = RubyFann::Standard.new(filename: './headlines.net')
  end

  def test
    hls = RecentHeadline.order(id: :desc).limit(100)
    hls.each do |h|
      v = vectorize_headline(h)
      next unless v

      puts h.headline, @fann.run(v)
    end
  end

  def headlines
    total_headlines = RecentHeadline.count
    eighty_percent = (total_headlines*80)/100

    @training_headlines = RecentHeadline.order(id: :asc).limit(eighty_percent)
    @testing_headlines = RecentHeadline.order(id: :desc).limit(total_headlines - eighty_percent)

    puts ">>> TRAINING"
    pp @training_headlines.count

    puts ">>> TESTING"
    pp @testing_headlines.count
  end

  # FANN training data file format
  # http://leenissen.dk/fann/html/files/fann_train-h.html#fann_read_train_from_file
  #
  # num_train_data num_input num_output
  # inputdata seperated by space
  # outputdata seperated by space
  def write_training_file
    file = File.open('./train.data', 'w')

    file.puts "#{@training_headlines.count} #{@number_of_inputs} #{@number_of_outputs}"
    @training_headlines.find_each do |headline|
      file.puts vectorize_headline(headline).join(' ')
      file.puts vectorized_signs(headline).join(' ')
      file.puts
      file.puts
    end

    file.close
  end

  def write_turi_file
    file = File.open('./turi.data', 'w')

    topics = Sign.order(id: :asc).pluck(:name).downcase.join(' ')

    file.puts "word, topic"
    @training_headlines.find_each do |headline|
      sanitized = headline.headline.split(/\s/).map { |word| word.downcase.gsub(/\W/, '') }.join(' ')
      file.puts "#{topics} #{sanitized}, #{vectorized_signs(headline).join(' ')}"
    end
  end

  def vectorized_signs(headline)
    vector = Array.new(@number_of_outputs) { |i| 0 }

    words = headline.normalized.uniq
    @keywords.each do |k|
      if words.include? k.normalized
        k.signs.pluck(:id).each { |id| vector[id] = 1 }
      end
    end

    vector
  end


  def vectorize_headline(headline)
    vector = Array.new(@number_of_inputs) { |i| 0 }
    words = headline.normalized

    words.each do |word|
      id = MlDictionary.where(word: word).first_or_create.id
      if id >= @number_of_inputs
        return nil
      end
      vector[id] = 1
      @max_word_id = [ @max_word_id, id ].max
    end

    vector
  end

  def seed_dictionary
    @headlines.each do |headline|
      words = headline.normalized
      words.each do |word|
        MlDictionary.where(word: word).first_or_create
      end
    end
  end

  private
end
