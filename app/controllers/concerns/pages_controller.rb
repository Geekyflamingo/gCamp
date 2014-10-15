class PagesController <ApplicationController

  def index


    quote1 = Quote.new
    quote1.text = "People who think they know everything are a great annoyance to those of us who do."
    quote1.author = "Issac Asimov"

    quote2 = Quote.new
    quote2.text = "If you could kick the person in the pants responsible for most of your trouble, you wouldn't sit for a month."
    quote2.author = "Theodore Roosevelt"

    quote3 = Quote.new
    quote3.text = "Get your facts first, then you can distort them as you please."
    quote3.author = "Mark Twain"

    @quotes = [quote1, quote2, quote3]

  end

end
