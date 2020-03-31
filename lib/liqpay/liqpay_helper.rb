module Liqpay
  module LiqpayHelper
    # Displays a form to send a payment request to LiqPay
    #
    # You can either pass in a block, that SHOULD render a submit button (or not, if you plan to submit the form otherwise), or
    # let the helper create a simple submit button for you.
    #
    # liqpay_request - an instance of Liqpay::Request
    # options - currently accepts two options
    #   id - the ID of the form being created (`liqpay_form` by default)
    #   title - text on the submit button (`Pay with LiqPay` by default); not used if you pass in a block
    def liqpay_button(liqpay_request, options={}, &block)
      id = options.fetch(:id, 'liqpay_form')
      title = options.fetch(:title, 'Pay with LiqPAY')
      hash = {:id => id, :action => Liqpay::LIQPAY_ENDPOINT_URL, :method => :post}
      hash[:target] = options[:target] if options[:target]

      content_tag(:form, hash) do
        liqpay_request.form_fields.each do |name, value|
          concat hidden_field_tag(name, value)
        end
        if block_given?
          yield
        else
          concat submit_tag(title, :name => nil)
        end
      end
    end
  end
end
