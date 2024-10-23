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
  # Convert APR from string to float and calculate monthly rate
  @apr = params[:apr].to_f / 100 / 12

  # Convert years to months
  @years = params[:years].to_i * 12

  # Convert present value (principal) to float
  @present_value = params[:present_value].to_f

  # Calculate monthly payment using the formula
  numerator = @apr * @present_value
  denominator = 1 - (1 + @apr) ** -@years
  @payment = (numerator / denominator).round(2) # Round to two decimal places

  # Format values for display
  @payment_formatted = @payment.to_fs(:currency)
  @apr_formatted = (params[:apr].to_f).to_fs(:percentage, { precision: 4 })

  erb :payment_results
end

