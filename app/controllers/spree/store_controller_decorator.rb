# frozen_string_literal: true

module Spree
  StoreController.class_eval do
    before_action :set_locale

    def set_locale

      if session.key?(:currency) && session[:currency] != current_store.code.upcase
        session[:currency] = current_store.code.upcase
        params[:currency] = current_store.code.upcase
      end

      # Keep the store currency and order currency in sync
      if current_order
        if current_order.currency != current_currency
          params[:currency] = current_order.currency
          (cookies[:preferred_currency] = { value: current_order.currency, expires: 1.year.from_now })
        end
      end

    end

  end
end
