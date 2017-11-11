require 'ruby-fann'
require 'sparse_array'

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
    lh = LearnHeadlines.new Sign.find(2)

    lh.headlines

    lh.write_training_file

    lh.train
  end


  def initialize(sign)
    @sign = sign
    @max_word_id = 0
  end

  def headlines
    get_headlines
    get_negatives

    eighty_percent = (@headlines.length*80)/100

    @training_headlines = @headlines.first(eighty_percent)
    @testing_headlines = @headlines.last(@headlines.count - eighty_percent)


    puts ">>> TRAINING"
    pp @training_headlines.count

    puts ">>> TESTING"
    pp @testing_headlines.count
  end

  def write_training_file
    file = File.open('./training-data', 'w')

    
  end

  # with stemming we'll probably never need more than 20,000 words in our vocabulary
  # training input is a vector of 20,000 with a 1 for each word that appears
  # we have 12 outputs, one for each sign - 1 means the sign is on, 0 off
  def train
    train_data = headlines_to_arrays(@training_headlines)

    puts '>>> 1'
#    pp data.inspect
    train = RubyFann::TrainData.new(inputs: train_data, desired_outputs: [[0.9]] )

    puts '>>> 2'
    fann = RubyFann::Standard.new(num_inputs: 20000, hidden_neurons: [2, 8, 4, 3, 4], num_outputs: 1)

    puts '>>> 3'
    fann.train_on_data(train, 1000, 10, 0.1) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)

    puts '>>> 4'
    outputs = fann.run([0.3, 0.2, 0.4])    
  end

  def get_headlines
    filter = Stopwords::Snowball::Filter.new "en"
    keywords = LearnHeadlines.normalize_words! Keyword.where(sign: @sign)

    matched_headlines = []
    matched_headlines_ids = []

    RecentHeadline.all.each do |headline|
      words = headline.normalized
      keywords.each do |k|
        if words.include? k
          matched_headlines.push words
          matched_headline_ids.push headline.id
        end
      end
    end

    @headline_ids = matched_headlines_id.uniq
    @headlines = matched_headlines.uniq
  end

  def get_negatives
    @negatives = []

    count = 0
    max_id = RecentHeadlines.last.id
    goal = @headlines.length
    loop do
      return if count >= goal

      attempt_id = rand(max_id)
      next if @headline_ids.include? attempt_id

      headline = RecentHeadlines.find attempt_id
      next unless headline

      @negatives.push headline

      count += 1
    end
  end

  def headlines_to_arrays(headlines)
    input_vectors = []
    output_vectors = []

    headlines.each do |words|
      vector = DefaultedSparseArray.new(0)
#      vector = Array.new(5000)
#     (0..4999).each do |x| vector[x] = 0 end

      word_ids = words.each do |word|
        id = MlDictionary.where(word: word).first_or_create.id
        vector[id] = 1
        @max_word_id = [ @max_word_id, id ].max
      end

      input_vectors.push vector
      output_vectors.push [ 1 ]
    end

    [ input_vectors, output_vectors ]
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

  def self.normalize_words!(keywords)
    keywords.map { |keyword| keyword.name.stem }
  end
end

# based on https://stackoverflow.com/questions/5324654/can-i-create-an-array-in-ruby-with-default-values
class DefaultedSparseArray < SparseArray
  @default = 0
  @max_length

  def initialize(default = 0, max_length = 20000)
    @default = default
    @max_length = max_length
  end

  def [](index)
    if index.is_a? Range
      index.map {|i| self[i] }
    else
      fetch(index) { @default }
    end
  end

  def length
    return @max_length
  end
end
