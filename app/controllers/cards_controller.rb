class CardsController < ApplicationController

  def show
    @card = Card.get params[:id]

    unless @card
      @card = Card.new(:name => params[:id])
      render :action => :new
    end

  end

  def new
  end

  def create
    if %w{Simple}.include? params[:card][:type]
      type = params[:card][:type]
    else
      type = "Simple"
    end
    
    card = type.constantize.create!(params[:card])

    redirect_to card_url(card)
  end

  def edit
    @card = Card.get_without_sti params[:id]
  end

  def update
    card = Card.get params[:id]
    card.update_attributes(params[:card])
    card.save

    redirect_to card_url(card)
  end

end