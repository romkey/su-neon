require 'ruby-fann'

def LearnHeadlines < RubyFann::Standard
  def train_sign(sign)
    filter = Stopwords::Snowball::Filter.new "en"
    keywords = normalize_words! sign.keywords

    headlines.each do |headline|
      words = headline.normalize.split(' ')
    end
  end

  private

  def train(data, desired_outputs)
    train = RubyFann::TrainData.new(:inputs=>[[0.3, 0.4, 0.5], [0.1, 0.2, 0.3]], :desired_outputs=>[[0.7], [0.8]])
    fann = RubyFann::Standard.new(:num_inputs=>3, :hidden_neurons=>[2, 8, 4, 3, 4], :num_outputs=>1)
    fann.train_on_data(train, 1000, 10, 0.1) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)
    outputs = fann.run([0.3, 0.2, 0.4])    
  end

  def normalize_words!(words)
    keywords.map { |keyword| filter.filter([ keyword ]).first.stem }
  end
end
