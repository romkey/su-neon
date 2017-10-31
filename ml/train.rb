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
    s = Sign.find 2
    LearnHeadlines.train_sign s
  end

  def self.train_sign(sign)
    headlines = LearnHeadlines.get_headlines(sign)

    eighty_percent = (headlines.length*80)/100

    training_headlines = headlines.first(eighty_percent)
    testing_headlines = headlines.last(headlines.count - eighty_percent)

    puts ">>> TRAINING"
    pp training_headlines.count

    puts ">>> TESTING"
    pp testing_headlines.count

    train_data = LearnHeadlines.headlines_to_arrays(training_headlines)
    LearnHeadlines.train train_data
  end

  def self.get_headlines(sign)
    filter = Stopwords::Snowball::Filter.new "en"
    keywords = LearnHeadlines.normalize_words! Keyword.where(sign: sign)

    matched_headlines = []

    RecentHeadline.all.each do |headline|
      words = headline.normalized
      keywords.each do |k|
        if words.include? k
          matched_headlines.push words
        end
      end
    end

    matched_headlines.uniq
  end

  def self.headlines_to_arrays(headlines)
    vectors = []

    headlines.each do |words|
      vector = DefaultedSparseArray.new(0)
      vector = Array.new(5000)
      (0..4999).each do |x| vector[x] = 0 end

      word_ids = words.each do |word|
        id = MlDictionary.where(word: word).first_or_create.id
        vector[id] = 1
      end

      vectors.push vector
    end

    vectors
  end

  def self.train_headline(sign, vectors)
    LearnHeadlines.train(vector)
  end

  def self.seed_dictionary
    RecentHeadline.all.each do |headline|
      words = headline.normalized
      words.each do |word|
        MlDictionary.where(word: word).first_or_create
      end
    end
  end

  private

  def self.train(data)
    puts '>>> 1'
#    pp data.inspect
    train = RubyFann::TrainData.new(inputs: data, desired_outputs: [[0.9]] )

    puts '>>> 2'
    fann = RubyFann::Standard.new(num_inputs: 5000, hidden_neurons: [2, 8, 4, 3, 4], num_outputs: 1)

    puts '>>> 3'
    fann.train_on_data(train, 1000, 10, 0.1) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)

    puts '>>> 4'
    outputs = fann.run([0.3, 0.2, 0.4])    
  end

  def self.normalize_words!(keywords)
    keywords.map { |keyword| keyword.name.stem }
  end
end

# based on https://stackoverflow.com/questions/5324654/can-i-create-an-array-in-ruby-with-default-values
class DefaultedSparseArray < SparseArray
  @default = 0

  def initialize(default = 0)
    @default = default
  end

  def [](index)
    if index.is_a? Range
      index.map {|i| self[i] }
    else
      fetch(index) { @default }
    end
  end
end
