class PagesController <ApplicationController

  def index
    @quotes=[["People who think they know everything are a great annoyance to those of us who do.", "Issac Asimov"],
            ["If you could kick the person in the pants responsible for most of your trouble, you wouldn't sit for a month.", "Theodore Roosevelt"],
            ["Get your facts first, then you can distort them as you please.","Mark Twain"]]
  end

end
