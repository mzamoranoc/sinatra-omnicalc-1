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
get '/payment/results' do
  # Retrieve and convert parameters
  annual_rate = params[:apr].to_f / 100
  monthly_rate = annual_rate / 12
  years = params[:years].to_i
  months = years * 12
  principal = params[:present_value].to_f

  # Calculate monthly payment
  numerator = monthly_rate * principal
  denominator = 1 - (1 + monthly_rate) ** -months
  @payment = numerator / denominator

  # Round to one decimal place if needed
  @payment = @payment.round(1)

  erb :payment_results
end
