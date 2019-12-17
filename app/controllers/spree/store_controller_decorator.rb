# frozen_string_literal: true

module Spree
  StoreController.class_eval do
    before_action :set_locale

    def set_locale
      if session.key?(:currency) != current_store.code.upcase
        session[:currency] = current_store.code.upcase
      end
    end

  end
end
