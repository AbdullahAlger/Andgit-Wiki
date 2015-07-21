class ChargesController < ApplicationController

  before_action :authenticate_user!

  def new
    @stripe_btn_data = {
        key: "#{Rails.configuration.stripe[:publishable_key]}",
        description: "Premium Membership - #{current_user.name}",
        amount: amount_in_us_cents_for_membership
    }
  end

  def create

    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount_in_us_cents_for_membership,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for the contribution, #{current_user.name}!"
    current_user.update_attributes(stripe_id: customer.id)
    current_user.upgrade_account
    redirect_to wikis_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charges_path

  end

  def downgrade
    current_user.downgrade_account
    flash[:notice] = "You're now a standard user."
    redirect_to wikis_path
  end

  private

  def amount_in_us_cents_for_membership
    10_00
  end

end
