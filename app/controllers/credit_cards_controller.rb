class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:show, :edit, :update, :destroy]

  def index
    
  end

  def show
    
  end

  def edit
  end

  def new
    @credit_card = credit_card.new
  end

  def create
    @credit_card = credit_card.new(credit_card_params)
    if @credit_card.save
      redirect_to credit_card_path(@credit_card), notice: "#{@credit_card.number} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    @credit_card.update(credit_card_params)
    if @credit_card.save
      redirect_to credit_card_path(@credit_card), notice: "#{@credit_card.number} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @credit_card.destroy
    redirect_to credit_cards_url, notice: "#{@credit_card.number} was removed from the system."
  end

  private
    def set_credit_card
      @credit_card = credit_card.find(params[:id])
    end

    def credit_card_params
      params.require(:credit_card).permit(:number, :expiration_year, :expiration_month)
    end
end