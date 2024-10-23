require 'sinatra'
require 'sinatra/reloader' if development?

# Route for Square calculation
get '/square/new' do
  erb :square
end

# Route to process the square result
get '/square/results' do
  @number = params[:number].to_f
  @result = @number ** 2
  erb :square_results
end

# Route for Square Root calculation
get '/square_root/new' do
  erb :square_root
end

# Route to process the square root result
get '/square_root/results' do
  @number = params[:number].to_f
  @result = Math.sqrt(@number)
  erb :square_root_results
end

# Route for Random Number calculation
get '/random/new' do
  erb :random
end

# Route to process random number result
get '/random/results' do
  @min = params[:user_min].to_f
  @max = params[:user_max].to_f
  @result = rand(@min..@max)
  erb :random_results
end

# Route for Payment calculation
get '/payment/new' do
  erb :payment
end

# Route to process the payment result
# app.rb

get '/payment/results' do
  # Retrieve and convert parameters
  annual_rate = params[:apr].to_f / 100  # Convert APR to decimal
  monthly_rate = annual_rate / 12        # Monthly rate
  years = params[:years].to_i            # Convert years to integer
  months = years * 12                    # Convert years to months
  principal = params[:present_value].to_f # Convert principal to float

  # Calculate monthly payment using the annuity formula
  numerator = monthly_rate * principal
  denominator = 1 - (1 + monthly_rate) ** -months
  @payment = (numerator / denominator).round(2)

  # Format the payment and APR for display
  @payment_formatted = format("$%.2f", @payment)
  @apr_formatted = (params[:apr].to_f).round(4).to_s + "%"

  erb :payment_results
end

helpers do
  def format_currency(amount)
    # Ensure the amount is a float rounded to two decimal places
    amount = amount.to_f.round(2)
    
    # Split the amount into whole and decimal parts
    integer_part, decimal_part = sprintf('%.2f', amount).split('.')
    
    # Add commas to the integer part
    integer_with_commas = integer_part.chars.to_a.reverse.each_slice(3).map(&:join).join(',').reverse
    
    # Combine the integer part with commas and the decimal part
    "$#{integer_with_commas}.#{decimal_part}"
  end
end
