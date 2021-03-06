# frozen_string_literal: true

module Spree
  StoreController.class_eval do
    before_action :set_locale

    def set_locale
      # Set the session and params currency to match store currency
      if session[:currency] != current_store.code.upcase
        session[:currency] = current_store.code.upcase
      end


      # Keep the store currency and order currency in sync
      if current_order
        if current_order.currency != current_currency
          params[:currency] = current_currency
        end
      end

      # Switch the currency based on the params given.
      if params[:currency].present?
        @currency = supported_currencies.find { |currency| currency.iso_code == params[:currency] }
        current_order.update_attributes!(currency: @currency.iso_code) if @currency && current_order
        session[:currency] = params[:currency] if Spree::Config[:allow_currency_change]
      end
    end

  end
end
