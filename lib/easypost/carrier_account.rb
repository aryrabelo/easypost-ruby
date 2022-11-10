# frozen_string_literal: true

# A CarrierAccount encapsulates your credentials with the carrier.
class EasyPost::CarrierAccount < EasyPost::Resource
  # Retrieve a list of available CarrierAccount types for the authenticated User.
  def self.types
    EasyPost::CarrierType.all
  end

  def self.create(params = {}, api_key = nil)
    wrapped_params = {}
    wrapped_params[class_name.to_sym] = params

    # For Ups and Fedex the endpoint is different
    create_url = if params[:type] == 'UpsAccount' || params[:type] == 'FedexAccount'
                   "#{url}/register"
                 else
                   url
                 end

    response = EasyPost.make_request(:post, create_url, api_key, wrapped_params)
    EasyPost::Util.convert_to_easypost_object(response, api_key)
  end
end
