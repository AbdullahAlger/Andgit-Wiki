class ChargesController < ApplicationController

  def new

    @stripe_btn_data = {
        key: "#{Rails.configuration.stripe[:publishable_key]}",
        description: "Premium Membership - #{current_user.name}",
        amount: amount
    }
  end


  def create

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:success] = "Thanks for subscribing, #{current_user.name}!"
    redirect_to wikis_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def amount
    10_00
  end



end
