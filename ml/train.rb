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
  def self.train_sign(sign)
    filter = Stopwords::Snowball::Filter.new "en"
    keywords = normalize_words! sign.keywords

    headlines.each do |headline|
      words = headline.normalized
    end

    vector = DefaultedSparseArray.new(0)
    word_ids = words.each do |word|
      id = MlDictionary.where(word: word).first_or_create.id
      vector[id] = 1
    end

    LearnHeadlines.train(vector)
  end

  def self.seed_dictionary
    filter = Stopwords::Snowball::Filter.new "en"

    RecentHeadline.all.each do |headline|
      words = headline.normalized
      words.each do |word|
        MlDictionary.where(word: word).first_or_create
      end
    end
  end

  private

  def train(data)
    train = RubyFann::TrainData.new(inputs: [ data ], desired_output: [[1]] )

    fann = RubyFann::Standard.new(num_inputs: 50000, hidden_neurons: [2, 8, 4, 3, 4], num_outputs: 1)

    fann.train_on_data(train, 1000, 10, 0.1) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)
    outputs = fann.run([0.3, 0.2, 0.4])    
  end

  def normalize_words!(words)
    keywords.map { |keyword| filter.filter([ keyword ]).first.stem }
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
