require 'sinatra'
require 'sinatra/reloader' if development?

# Route for Square calculation
get '/' do
  erb :square
end

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
  @apr = params.fetch("apr").to_f
  r = @apr/1200
  @years = params.fetch("years").to_f
  n = @years*12
  @pv = params.fetch("present_value").to_f

  numerator = r * @pv
  denominator = 1 - (1 + r) ** -n
  @payment = (numerator / denominator)

  erb :payments_results
end
