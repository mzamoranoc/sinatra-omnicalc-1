describe "root URL" do
  it "has a level one heading with the text 'Dice Roll'", points: 1 do
    visit "/"

    expect(page).to have_tag("h1", text: /Dice\s+Roll/i)
  end
end

describe "root URL" do
  it "has one form element", points: 1 do
    visit "/"

    expect(page).to have_css("form", count: 1),
      "Expected to find one form element on the page but found 0 or more than 1."
  end
end

describe "root URL" do
  it "has form element with an action attribute", points: 1 do
    visit "/"

    expect(page).to have_css("form[action]"),
      "Expected page to have a form element with an 'action' attribute but didn't find one."
  end
end

describe "root URL" do
  it "has a label with text 'Number of dice to roll?'", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/"

    expect(page).to have_css("label", text: /Number\s+of\s+dice\s+to\s+roll/i)
  end
end

describe "root URL" do
  it "has a label with text 'How many sides per die?'", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/"

    expect(page).to have_css("label", text: /How\s+many\s+sides\s+per\s+die/i)
  end
end

describe "root URL" do
  it "has two input elements", points: 1, hint: h("label_for_input") do
    visit "/"

    expect(page).to have_css("input", count: 2)
  end
end

describe "root URL" do
  it "has a button element with text 'Roll!'", points: 1, hint: h("copy_must_match") do
    visit "/"

    expect(page).to have_css("button", text: /Roll/i)
  end
end

describe "root URL" do
  it "leads to another functional page when submitted", points: 3, hint: h("button_type label_for_input copy_must_match") do
    visit "/"

    # fill_in "Number of dice to roll?", with: 10
    # fill_in "How many sides per die?", with: 6
    dice_label = find("label", :text => /Number\s+of\s+dice\s+to\s+roll/i)
    for_attribute = dice_label[:for]
    begin
      dice_input = find("##{for_attribute}")
    rescue Capybara::ElementNotFound
      expect(false).to be(true), "Expected to find an input with an id attribute that matched the for attribute of a label but didn't find one."
    end
    dice_input.set(10)
    sides_label = find("label", :text => /How\s+many\s+sides\s+per\s+die/i)
    for_attribute = sides_label[:for]
    begin
      sides_input = find("##{for_attribute}")
    rescue Capybara::ElementNotFound
      expect(false).to be(true), "Expected to find an input with an id attribute that matched the for attribute of a label but didn't find one."
    end
    sides_input.set(6)

    # click_button "Roll!"
    find("button", :text => /Roll/i).click

    expect(page).to_not have_current_path("/", ignore_query: true),
      "Expected form to submit to a route different than '/' root URL but current route was still '/' root URL"
  end
end

describe "root URL" do
  it "captures the user's input in the query string", points: 3, hint: h("names_for_inputs") do
    visit "/"

    expect(page).to have_css("input[name]", count: 2)
  end
end

describe "root URL" do
  it "has a label for 'Number of dice to roll?' that is connected to an input", points: 1, hint: h("label_for_input") do
    visit "/"

    dice_label = find("label", :text => /Number\s+of\s+dice\s+to\s+roll/i)
    for_attribute = dice_label[:for]

    if for_attribute.empty?
      expect(for_attribute).to_not be_empty,
        "Expected label’s for attribute to be set to a non empty value, was '#{for_attribute}' instead."
    else
      all_inputs = all("input")

      all_input_ids = all_inputs.map { |input| input[:id] }.compact

      expect(all_input_ids.count(for_attribute)).to eq(1),
        "Expected 'Number of dice to roll?' label’s for attribute(#{for_attribute}) to match only 1 of the ids of an input tag (#{all_input_ids}), but found 0 or more than 1."
    end
  end
end

describe "root URL" do
  it "has a label for 'How many sides per die?' that is connected to an input", points: 1, hint: h("label_for_input") do
    visit "/"

    sides_label = find("label", :text => /How\s+many\s+sides\s+per\s+die/i)
    for_attribute = sides_label[:for]

    if for_attribute.empty?
      expect(for_attribute).to_not be_empty,
        "Expected label’s for attribute to be set to a non empty value, was '#{for_attribute}' instead."
    else
      all_inputs = all("input")

      all_input_ids = all_inputs.map { |input| input[:id] }.compact

      expect(all_input_ids.count(for_attribute)).to eq(1),
        "Expected 'How many sides per die?' label’s for attribute(#{for_attribute}) to match only 1 of the ids of an input tag (#{all_input_ids}), but found 0 or more than 1."
    end
  end
end

describe "/process_roll?dice=[RANDOM_DICE]&sides=[RANDOM_SIDES]" do
  it "has a level one heading with the text '[RANDOM_DICE]d[RANDOM_SIDES]'", points: 1 do

    random_dice = rand(2..100)
    random_sides = rand(2..100)

    visit "/process_roll?dice=#{random_dice}&sides=#{random_sides}"

    expect(page).to have_tag("h1", text: /\s*#{random_dice}d#{random_sides}\s*/)
  end
end

describe "/process_roll?dice=[RANDOM_DICE]&sides=[RANDOM_SIDES]" do
  it "displays the outcome of rolling two six-sided dice in an ordered (numbered) list", points: 1 do

    random_dice = rand(2..100)
    random_sides = rand(2..100)

    visit "/process_roll?dice=#{random_dice}&sides=#{random_sides}"

    expect(page).to have_tag("ol") do
      with_tag("li", count: random_dice)
    end
  end
end
